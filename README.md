# Gitlab agent module

This module deploy gitlab agent to gitlab projects or groups. Also have option to create project if not exist.
Important thing on this module is agent_config variable, its map kind any, example gitlab agent config is down below.

## Gitlab agent config: HCL to YAML

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

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~> 16.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.9 |

Basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 agent_name  = 

	 # Optional variables
	 agent_config  = {}
	 agent_version  = null
	 author_email  = "example@mail.com"
	 chart_version  = "1.13.0"
	 commit_message  = "feature: add/update agent config"
	 create_project  = false
	 namespace  = "gitlab-agent"
	 project_name  = "k8s-agent"
	 project_path  = ""
	 token_description  = ""
}
```

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
| <a name="input_agent_config"></a> [agent\_config](#input\_agent\_config) | agent config to be used regarding:<br>    * https://docs.gitlab.com/ee/user/clusters/agent/gitops.html<br>    * https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_workflow.html#authorize-the-agent-to-access-your-projects | `any` | `{}` | no |
| <a name="input_agent_name"></a> [agent\_name](#input\_agent\_name) | agent name | `string` | n/a | yes |
| <a name="input_agent_version"></a> [agent\_version](#input\_agent\_version) | specific agent version | `string` | `null` | no |
| <a name="input_author_email"></a> [author\_email](#input\_author\_email) | author email to be used for commit | `string` | `"example@mail.com"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | agent chart version | `string` | `"1.13.0"` | no |
| <a name="input_commit_message"></a> [commit\_message](#input\_commit\_message) | use this commit message for agent config update | `string` | `"feature: add/update agent config"` | no |
| <a name="input_create_project"></a> [create\_project](#input\_create\_project) | create a new agent managing project or use existing one | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | agent namespace | `string` | `"gitlab-agent"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | agent managing project name/id | `string` | `"k8s-agent"` | no |
| <a name="input_project_path"></a> [project\_path](#input\_project\_path) | agent managing project path | `string` | `""` | no |
| <a name="input_token_description"></a> [token\_description](#input\_token\_description) | gilab agent token description in managing project | `string` | `""` | no |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->