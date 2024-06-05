<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | >= 16.0, < 18.0 |

Basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 agent_name  = 
	 agent_project_path  = 
	 app_namespace  = 
	 environment  = 
	 project_path  = 
}
```

## Resources

| Name | Type |
|------|------|
| [gitlab_project_variable.agent_name](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_variable) | resource |
| [gitlab_project_variable.app_namespace](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_variable) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_name"></a> [agent\_name](#input\_agent\_name) | n/a | `string` | n/a | yes |
| <a name="input_agent_project_path"></a> [agent\_project\_path](#input\_agent\_project\_path) | n/a | `string` | n/a | yes |
| <a name="input_app_namespace"></a> [app\_namespace](#input\_app\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_project_path"></a> [project\_path](#input\_project\_path) | n/a | `string` | n/a | yes |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->