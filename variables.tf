variable "create_project" {
  type        = bool
  default     = false
  description = "create a new agent managing project or use existing one"
}

variable "project_name" {
  type        = string
  default     = "k8s-agent"
  description = "agent managing project nice/visible name"
}

variable "project_path" {
  type        = string
  default     = null
  description = "agent managing project technical name (slug)"
}

variable "project_namespace" {
  type        = string
  default     = ""
  description = "agent managing project namespace, required when creating new project"
}

variable "agent_config" {
  type        = any
  default     = {}
  description = <<EOF
    agent config to be used regarding:
    * https://docs.gitlab.com/ee/user/clusters/agent/gitops.html
    * https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_workflow.html#authorize-the-agent-to-access-your-projects
EOF
}

variable "author_email" {
  type        = string
  default     = "example@mail.com"
  description = "author email to be used for commit"
}

variable "commit_message" {
  type        = string
  default     = "feature: add/update agent config"
  description = "use this commit message for agent config update"
}

variable "agent_name" {
  type        = string
  description = "agent name"
}

variable "chart_version" {
  type        = string
  default     = "1.14.1"
  description = "agent chart version"
}

variable "agent_version" {
  type        = string
  default     = null
  description = "specific agent version"
}

variable "token_description" {
  type        = string
  default     = ""
  description = "gilab agent token description in managing project"
}

variable "namespace" {
  type        = string
  default     = "gitlab-agent"
  description = "agent namespace"
}

variable "create_namespace" {
  type        = bool
  default     = false
  description = "option for create namespace"
}

variable "gitlab_agent_cluster_projects" {
  type = map(object({
    envs = list(object({
      scope     = string
      namespace = string
    }))
    path = string
  }))
}
