# Gitlab agent module

This module deploy gitlab agent to gitlab projects or groups. Also have option to create project if not exist.
Important thing on this module is agent_config variable, its map kind any, example gitlab agent config is down below.

## Usage/Examples

Example config for project
```hcl
ci_access:
  projects:
    - id: path/to/project
}
```

Example config for group
```hcl
ci_access:
  groups:
    - id: path/to/group/subgroup
}
```


## Documentation

[Gitlab agent config](https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_workflow.html)
