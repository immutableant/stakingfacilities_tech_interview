# Ethereum Full Node Deployment and Update Automation

## Background

This project aims to automate the deployment and update process for an Ethereum Full Node on the Holesky Testnet using Terraform and Ansible. The objective is to provision infrastructure in AWS, configure the instances with the necessary software, and manage the lifecycle of the deployment efficiently.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [AWS CLI](https://aws.amazon.com/cli/) (configured with appropriate credentials)

## Configuring AWS for Terraform

If you haven't already installed and configured the AWS CLI on your WSL Ubuntu, follow these steps:

```sh
sudo apt-get install -y awscli
```

### Step 1: Create a User for Terraform
1. Log in to AWS Management Console:
    - Go to the AWS Management Console.

2. Navigate to IAM (Identity and Access Management):
    - In the AWS Management Console, search for "IAM" and select it.

3. Create a New User:
    - Click on "Users" in the left-hand menu.
    - Click on the "Add user" button.
    - Enter a username (e.g., terraform-user).
    - Select the checkbox for "Access key - Programmatic access".
    - Click "Next: Permissions".

### Step 2: Attach Policies to the User
1. Attach Existing Policies:
    - Select "Attach existing policies directly".

2. Create a Custom Policy:
    - Click on "Create policy".
    - Go to the "JSON" tab.
    - Paste the following policy JSON, which grants necessary permissions for Terraform to manage resources:
    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:DescribeInstanceCreditSpecifications",
                    "ec2:DescribeInstanceTypes",
                    "ec2:AuthorizeSecurityGroupEgress",
                    "ec2:DisassociateRouteTable",
                    "ec2:AssociateRouteTable",
                    "ec2:DeleteSubnet",
                    "ec2:ModifySubnetAttribute",
                    "ec2:DetachInternetGateway",
                    "ec2:DeleteRoute",
                    "ec2:DeleteLaunchTemplate",
                    "ec2:DescribeLaunchTemplateVersions",
                    "ec2:DescribeLaunchTemplates",
                    "ec2:CreateLaunchTemplate",
                    "ec2:CreateRoute",
                    "ec2:DeleteRouteTable",
                    "ec2:DeleteInternetGateway",
                    "ec2:DescribeInternetGateways",
                    "ec2:AuthorizeSecurityGroupIngress",
                    "ec2:AttachInternetGateway",
                    "ec2:CreateSubnet",
                    "ec2:RevokeSecurityGroupEgress",
                    "ec2:CreateRouteTable",
                    "ec2:CreateInternetGateway",
                    "ec2:ModifyVpcAttribute",
                    "ec2:DescribeVpcAttribute",
                    "ec2:DeleteVpc",
                    "ec2:DescribeVpcs",
                    "ec2:AllocateAddress",
                    "ec2:ImportKeyPair",
                    "ec2:CreateVpc",
                    "ec2:AssociateAddress",
                    "ec2:AttachVolume",
                    "ec2:CreateKeyPair",
                    "ec2:CreateSecurityGroup",
                    "ec2:CreateTags",
                    "ec2:CreateVolume",
                    "ec2:DeleteKeyPair",
                    "ec2:DeleteSecurityGroup",
                    "ec2:DeleteTags",
                    "ec2:DeleteVolume",
                    "ec2:DescribeAddresses",
                    "ec2:DescribeAvailabilityZones",
                    "ec2:DescribeImages",
                    "ec2:DescribeInstanceAttribute",
                    "ec2:DescribeInstanceStatus",
                    "ec2:DescribeInstances",
                    "ec2:DescribeKeyPairs",
                    "ec2:DescribeNetworkInterfaces",
                    "ec2:DescribeRouteTables",
                    "ec2:DescribeSecurityGroups",
                    "ec2:DescribeSubnets",
                    "ec2:DescribeTags",
                    "ec2:DescribeVolumes",
                    "ec2:DetachVolume",
                    "ec2:ModifyInstanceAttribute",
                    "ec2:ModifyVolumeAttribute",
                    "ec2:ReleaseAddress",
                    "ec2:RevokeSecurityGroupIngress",
                    "ec2:RunInstances",
                    "ec2:TerminateInstances"
                ],
                "Resource": "*"
            }
        ]
    }
    ```
    
    - Click "Review policy".

    - Name the policy (e.g., TerraformBasicAccess) and add an optional description.

    - Click "Create policy".

3. Attach the Custom Policy:
    - Go back to the "Add user" page.
    - Click "Refresh" and search for the custom policy you just created (e.g., TerraformBasicAccess).
    - Select the custom policy.
    - Click "Next: Tags".

4. Add Tags (Optional):
    - Add any tags you need, such as Project: Terraform.

5. Review and Create User:
    - Review the settings.
    - Click "Create user".

### Step 3: Download Access Key and Secret Key
1. Download the Credentials:
    - After creating the user, you will see a page with the user's Access Key ID and Secret Access Key.
    - Download the .csv file with these credentials or copy them to a secure location.

### Step 4: Configure AWS CLI with the Access Key and Secret Key
1. Open Your WSL Ubuntu Terminal:
    - Run the following command to configure the AWS CLI with the new user's credentials:
    ```sh
    aws configure
    ```
2. Enter the Credentials:

    - Enter the Access Key ID and Secret Access Key when prompted.
    - Set the default region name (e.g., us-west-2).
    - Set the default output format (e.g., json).

By following these steps, you will have configured AWS for Terraform with a new IAM user, attached a policy with the necessary permissions, and set up the AWS CLI with the user's credentials. This setup will enable Terraform to manage AWS resources securely and effectively.


## Start Guide

### Step 1: Deploy the Infrastructure with Terraform

Navigate to the `terraform` directory and initialize the Terraform configuration:

```sh
cd terraform
terraform init
```

Plan the Terraform deployment to see the actions it will take:

```sh
terraform plan
```

Apply the Terraform configuration to deploy the infrastructure:

```sh
terraform apply
```

### Step 2: Run the Ansible Playbook

Navigate to the ansible directory and run the site.yml playbook to configure the deployed infrastructure, Terraform should had created the hosts.ini file under inventory folder:

```sh
cd ../ansible
ansible-playbook site.yml
```

### Updating Configuration
To update the configuration or apply updates to the infrastructure, run the rolling_update.yml playbook:

```sh
ansible-playbook update.yml
```

### Summary
This project uses Terraform for provisioning AWS infrastructure and Ansible for configuring Ethereum full nodes on the Holesky Testnet. The directory structure separates the concerns of infrastructure management and configuration management, making it easier to maintain and extend the project.
