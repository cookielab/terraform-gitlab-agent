data "gitlab_metadata" "this" {}

data "gitlab_project" "this" {
  path_with_namespace = var.create_project ? gitlab_project.this[0].path_with_namespace : var.project_path
}

resource "gitlab_project" "this" {
  count = var.create_project ? 1 : 0
  name  = var.project_name
  path  = var.project_path
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

  set {
    name  = "image.tag"
    value = var.agent_version
  }

  values = [<<YAML
config:
  kasAddress: "${data.gitlab_metadata.this.kas.external_url}"
YAML
  ]
}
