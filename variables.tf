variable "create_project" {
  type    = bool
  default = false
}

variable "project_name" {
  type    = string
  default = "k8s-agent"
}

variable "agent_config" {
  type    = any
  default = {}
}

variable "author_email" {
  type    = string
  default = "example@mail.com"
}

variable "commit_message" {
  type    = string
  default = "feature: add/update agent config"
}

variable "project_path" {
  type    = string
  default = ""
}

variable "agent_name" {
  type = string
}

variable "chart_version" {
  type    = string
  default = "1.13.0"
}

variable "agent_version" {
  type    = string
  default = null
}

variable "token_description" {
  type    = string
  default = ""
}

variable "namespace" {
  type    = string
  default = "gitlab-agent"
}
