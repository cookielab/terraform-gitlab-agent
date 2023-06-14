resource "gitlab_project_variable" "agent_name" {
  project           = var.project_path
  key               = "KUBE_CONTEXT"
  value             = "${var.agent_project_path}:${var.agent_name}"
  environment_scope = var.environment
  protected         = false
}

resource "gitlab_project_variable" "app_namespace" {
  project           = var.project_path
  key               = "KUBE_NAMESPACE"
  value             = var.app_namespace
  environment_scope = var.environment
  protected         = false
}
