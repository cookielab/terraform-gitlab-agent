locals {
  map_gitlab_agent_scopes = {
    for item in flatten([
      for project_key, project_value in var.gitlab_agent_cluster_projects : [
        for env in project_value.envs : {
          key = "${project_value.path}-${env.scope}"
          value = {
            path      = project_value.path
            scope     = env.scope
            namespace = env.namespace
          }
        }
      ]
    ]) : item.key => item.value
  }
}

data "gitlab_metadata" "this" {}

data "gitlab_project" "this" {
  path_with_namespace = var.create_project ? gitlab_project.this[0].path_with_namespace : "${var.project_namespace}/${var.project_path}"
}

data "gitlab_group" "namespace" {
  count     = var.create_project ? 1 : 0
  full_path = var.project_namespace
}

resource "gitlab_project" "this" {
  count = var.create_project ? 1 : 0
  name  = var.project_name
  path  = var.project_path

  namespace_id = data.gitlab_group.namespace[0].id

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

resource "kubernetes_namespace" "gitlab_agent" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations["cattle.io/status"],
      metadata[0].annotations["lifecycle.cattle.io/create.namespace-auth"],
      metadata[0].annotations["field.cattle.io/projectId"],
      metadata[0].annotations["management.cattle.io/no-default-sa-token"],
      metadata[0].labels["field.cattle.io/projectId"],
    ]
  }
}

resource "helm_release" "gitlab_agent" {
  name       = var.agent_name
  repository = "https://charts.gitlab.io/"
  chart      = "gitlab-agent"
  version    = var.chart_version
  namespace  = var.create_namespace ? kubernetes_namespace.gitlab_agent[0].metadata[0].name : var.namespace

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
  for_each           = local.map_gitlab_agent_scopes
  source             = "./modules/gitlab_agent_name_variable"
  agent_name         = var.agent_name
  agent_project_path = data.gitlab_project.this.path_with_namespace
  app_namespace      = each.value.namespace
  environment        = each.value.scope
  project_path       = each.value.path
}
