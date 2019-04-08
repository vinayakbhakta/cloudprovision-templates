# SnappyFlow Templates for provisioning VM applications
This repository consists of templates for provisioning VM applications. These templates are meant to be used from SnappyFlow. These templates are based on either Terraform or AWS CloudFormation. Developers can use these templates directly from CloudFormation or Terraform.

## Terraform Reference
The recommended framework for development is Terraform. Please go through below links to learn Terraform.
 - [https://learn.hashicorp.com/terraform/](https://learn.hashicorp.com/terraform/)
 - [Terrafrom Interpolation Syntax](https://www.terraform.io/docs/configuration/interpolation.html)

## Guidelines for creating a new template.
 - Every template should be committed to a new directory.
 - Top level of template directory should have a file [template_info.json](template_info.md) and [parameters.json](parameters.md).
 - Refer [Creating-a-new-template.md](Creating-a-new-template.md).
 - Once template development is complete, it can be promoted to production by adding to **templates_list_production.json** file.
 - _If you are creating AWS CloudFormation based template, then template folder contains only template_info.json and actual CloudFormation template_ 
 - Templates which are not added to templates_list_production.json file will not be availabe on production version SnappyFlow servers. This helps you to hide the template which are under development.
 - __[integration with SnappyFlow](Integration-With-SnappyFlow.md)__
