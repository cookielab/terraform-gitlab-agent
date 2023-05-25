# Gitlab agent module

This module deploy gitlab agent to gitlab projects or groups. Also have option to create project if not exist.
Important thing on this module is agent_config variable, its map kind any, example gitlab agent config is down below.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~> 15.11.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | ~> 15.11.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_cluster_agent.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/cluster_agent) | resource |
| [gitlab_cluster_agent_token.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/cluster_agent_token) | resource |
| [gitlab_project.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project) | resource |
| [gitlab_repository_file.agent_config](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/repository_file) | resource |
| [helm_release.gitlab_agent](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [gitlab_metadata.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/metadata) | data source |
| [gitlab_project.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_config"></a> [agent\_config](#input\_agent\_config) | n/a | `any` | `{}` | no |
| <a name="input_agent_name"></a> [agent\_name](#input\_agent\_name) | n/a | `string` | n/a | yes |
| <a name="input_author_email"></a> [author\_email](#input\_author\_email) | n/a | `string` | `"example@mail.com"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | n/a | `string` | `"1.13.0"` | no |
| <a name="input_commit_message"></a> [commit\_message](#input\_commit\_message) | n/a | `string` | `"feature: add/update agent config"` | no |
| <a name="input_create_project"></a> [create\_project](#input\_create\_project) | n/a | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"gitlab-agent"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `"k8s-agent"` | no |
| <a name="input_project_path"></a> [project\_path](#input\_project\_path) | n/a | `string` | `""` | no |
| <a name="input_token_description"></a> [token\_description](#input\_token\_description) | n/a | `string` | `""` | no |

## Outputs

No outputs.


## Usage/Examples

Example config
```hcl
agent_config = {
  "ci_access" = {
    "projects" = [
      {
        "id" : path/to/project, environments = ["exampleEnvironment1", "exampleEnvironment2"]
      }
    ]
    "groups" = [
      {
        "id" : path/to/group/subgroup, environments = ["exampleEnvironment1", "exampleEnvironment2"]
      }
    ]
  }
}
```


## Documentation

[Gitlab agent config](https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_workflow.html)
