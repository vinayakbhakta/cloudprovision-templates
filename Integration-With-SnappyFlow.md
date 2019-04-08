## Integration with SnappyFlow
- There are default variables available for all supported cloud providers.
- These variables support passing credentials required to access desired cloud environment and also setting networks, regions, etc.,
- All default variables are sourced from __cloud profile__ and __accounts__ sections of snappyflow.
- All values along with variables passed from UI using [parameters.json](parameters.md) are written to __values.tfvars__ file except variables masked sensitive in template execution directory 
- __"access_key", "secret_key", "session_token","vsphere_user", "vsphere_password","openstack_username", "openstack_password"__ are not populated inside values.tfvars file, they are marked sensitive variables
- optionally one can include _terrafrom.tfvars_ file with some variables values defined by default 

### terrafrom and ansible commands executed from within template directory 
```bash
export TF_PLUGIN_CACHE_DIR=/data/deepinight/terraform-plugin-cache && terraform init -input=false
terraform apply -input=false -var-file="values.tfvars" 

export ANSIBLE_CONFIG=./ansible/ansible.cfg
ansible-playbook -b -v -i artifacts/hosts.ini --user=ubuntu --key-file=./keys/awskube.pem ansible/playbook.yml

terraform destroy -force -var-file="values.tfvars"
```

## Default Variables list 

### Common Variables

| variable | description |
| :--- | :--- |
| `stackname` | application name with creation time stamp ex: test-1551354199 |
| `appname` | application name with out creation time stamp ex: test |
| `ssh_user` | user name of linux instances read from user.txt file in template |


### AWS 

- #### account
| variable | description |
| :--- | :--- |
| `access_key` | aws access key  |
| `secret_key` | aws secret key  |
| `session_token` | MFA token |
| `region` | aws region |

- #### cloudprofile
| variable | description |
| :--- | :--- |
| `ssh_key_name` | The user-supplied key pair name, which is used to connect to an instance |
| `vpc_id` | AWS VPC where template hasto be deployed |
| `subnet_id` | Subnet within the VPC which is used by template  |

example: [elasticsearch-cluster-3-node-aws/variables.tf](elasticsearch-cluster-3-node-aws/variables.tf)
 
### VCENTER 

- #### account
| variable | description |
| :--- | :--- |
| `vsphere_user` | vsphere server user |
| `vsphere_password` | vsphere server password |
| `vsphere_server` | vsphere server ip |

- #### cloudprofile
| variable | description |
| :--- | :--- |
| `ssh_key_name` | ssh key file name supplied with vsphere templates |
| `datacenter` | datacenter to be used by the template within vsphere |
| `target_resource_pool` | resource pool to be used by the template within vsphere |
| `datastore`| datastore to be used by the template within vsphere |
| `cluster` | cluster to be used by the template within vsphere |

example: [elasticsearch-cluster-3-node-vcenter/variables.tf](elasticsearch-cluster-3-node-vcenter/variables.tf)

### OPENSTACK

- #### account
| variable | description |
| :--- | :--- |
| `openstack_username` | openstack username |
| `openstack_password` | openstack password |
| `openstack_server` | openstack server ip |
| `sshkey` | ssh key file associated with openstack_username |

- #### cloudprofile
| variable | description |
| :--- | :--- |
| `ssh_key_name` | ssh key associated with openstack_username |

example: [elasticsearch-cluster-3-node-openstack/variables.tf](elasticsearch-cluster-3-node-openstack/variables.tf)

### GCP

- #### account
| variable | description |
| :--- | :--- |
| `gcp_credentials_path` | path where gcp credentials file in json format is located |
| `region` | gcp region where template will be deployed |
| `zone` | zone within the region where template will be deployed |
| `project` | project within which template is deployed |
| `service_account` | service account to be used for deploying template |

- #### cloudprofile
| variable | description |
| :--- | :--- |
| `ssh_key_name` | ssh key name stored in gcp used to deploy this template |

example: [elasticsearch-cluster-3-node-gcp/variables.tf](elasticsearch-cluster-3-node-gcp/variables.tf)

