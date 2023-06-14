data "gitlab_metadata" "this" {}

data "gitlab_project" "this" {
  path_with_namespace = var.create_project ? gitlab_project.this[0].path_with_namespace : var.project_path
}

resource "gitlab_project" "this" {
  count = var.create_project ? 1 : 0
  name  = var.project_name
  path  = var.project_path

  skip_wait_for_default_branch_protection = true
}


resource "gitlab_cluster_agent" "this" {
  project = data.gitlab_project.this.id
  name    = var.agent_name
}

resource "gitlab_cluster_agent_token" "this" {
  project     = data.gitlab_project.this.id
  agent_id    = gitlab_cluster_agent.this.agent_id
  name        = var.agent_name
  description = var.token_description
}

resource "gitlab_repository_file" "agent_config" {
  project = data.gitlab_project.this.id

  branch    = data.gitlab_project.this.default_branch
  file_path = ".gitlab/agents/${gitlab_cluster_agent.this.name}/config.yaml"
  content   = base64encode(yamlencode(var.agent_config))

  author_email   = var.author_email
  commit_message = "${var.commit_message} ${gitlab_cluster_agent.this.name}"
}

resource "helm_release" "gitlab_agent" {
  name       = var.agent_name
  repository = "https://charts.gitlab.io/"
  chart      = "gitlab-agent"
  version    = var.chart_version
  namespace  = var.namespace

  set_sensitive {
    name  = "config.token"
    value = gitlab_cluster_agent_token.this.token
  }

  dynamic "set" {
    for_each = var.agent_version == null ? {} : { yes = "1" }
    content {
      name  = "image.tag"
      value = var.agent_version
    }
  }

  values = [<<YAML
config:
  kasAddress: "${data.gitlab_metadata.this.kas.external_url}"
YAML
  ]
}

module "gitlab_agent_variable" {
  count              = var.create_gitlab_variables == false ? 0 : 1
  source             = "./modules/gitlab_agent_name_variable"
  agent_name         = var.agent_name
  agent_project_path = data.gitlab_project.this.id
  app_namespace      = var.application_namespace
  environment        = var.gitlab_environment
  project_path       = var.app_project_path
}