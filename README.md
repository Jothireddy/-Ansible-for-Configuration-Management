# Ansible for Configuration Management

This project demonstrates how to automate system setup and application deployment using Ansible Playbooks. It is designed to provision and configure target servers (which could be running on AWS, GCP, or elsewhere) by:

- Installing and configuring required packages.
- Installing Docker.
- Deploying a sample Dockerized application (using the official Nginx image).

By storing all configuration in Git, you can implement a GitOps workflow where changes to the repository trigger updates on your servers.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup & Deployment](#setup--deployment)
- [Configuration Details](#configuration-details)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

This repository contains Ansible Playbooks and roles to automate the following:

- **System Setup:** Update the package cache, install prerequisite packages, add the Docker repository, install Docker, and ensure Docker is running.
- **Application Deployment:** Pull a Docker image (in this example, Nginx) and run it as a container to serve as a sample web application.

All target hosts are defined in the `inventory/hosts.ini` file. You can update this file with your remote server IP addresses or hostnames. The playbooks are designed to run with privilege escalation (i.e., using `become: yes`) to perform system-level changes.

---

## Features

- **Automated System Setup:** Uses Ansible roles to update package caches and install Docker and other prerequisites.
- **Application Deployment:** Deploys a Dockerized application using the `docker_container` module.
- **Modular & Extensible:** Easily add more roles or tasks to manage additional configurations or applications.
- **GitOps-Ready:** Store all configuration in Git. Integrate with CI/CD pipelines to trigger deployments on commit.

---

## Technologies Used

- **Ansible:** Automation tool for configuration management.
- **Docker:** Container platform for application deployment.
- **AWS/GCP (or any cloud):** Target hosts can be provisioned on any provider.
- **YAML/Jinja2:** For playbook and template definitions.

---

## Project Structure

ansible-config-management/ ├── README.md ├── inventory/ │ └── hosts.ini ├── playbooks/ │ ├── site.yml │ ├── setup-system.yml │ └── deploy-app.yml ├── roles/ │ ├── common/ │ │ ├── tasks/ │ │ │ └── main.yml │ │ ├── vars/ │ │ │ └── main.yml │ │ └── templates/ │ │ └── config.j2 │ └── docker_app/ │ ├── tasks/ │ │ └── main.yml │ └── templates/ │ └── docker-compose.yml.j2 └── scripts/ └── run-playbook.sh


- **inventory/hosts.ini:** Define your target servers.
- **playbooks/site.yml:** The master playbook that calls the setup and deploy playbooks.
- **roles/common:** Contains tasks for system configuration (e.g., installing Docker).
- **roles/docker_app:** Contains tasks for deploying the Dockerized sample application.
- **scripts/run-playbook.sh:** A helper script to execute the playbooks.

---

## Prerequisites

- **Ansible:** Install Ansible (version 2.9+ recommended).  
  [Installation Instructions](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- **SSH Access:** Ensure you have SSH access to the target hosts.
- **Sudo Privileges:** The target hosts should allow sudo (or root) access.
- **Docker:** The playbooks will install Docker, but ensure your hosts support Docker.

---

## Setup & Deployment

1. **Clone the Repository:**

```bash
   git clone <repository_url>
```
## Update the Inventory:
 Edit the inventory/hosts.ini file to include your target hosts. For example:

[webservers]
192.168.1.10 ansible_user=ubuntu
192.168.1.11 ansible_user=ubuntu
Run the Master Playbook:

You can run the master playbook which calls both the system setup and application deployment roles:

```
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```
## Alternatively, you can run the individual playbooks:

To setup the system:
```
ansible-playbook -i inventory/hosts.ini playbooks/setup-system.yml
```
 ## To deploy the application:
```
ansible-playbook -i inventory/hosts.ini playbooks/deploy-app.yml
```
## Using the Helper Script:

A helper script is provided in the scripts folder:
```
chmod +x scripts/run-playbook.sh
./scripts/run-playbook.sh
```
## Configuration Details
Roles:

common: Performs system updates and installs Docker.
docker_app: Pulls the Docker image (nginx) and runs a container.
Templates:
An example Jinja2 template (config.j2) is provided in the common role for additional configuration files if needed.
The docker-compose.yml.j2 file in the docker_app role is optional if you wish to deploy using Docker Compose.

## Variables:
Modify roles/common/vars/main.yml if you need to override any defaults (currently a placeholder for future expansion).

## Troubleshooting
SSH Connection Issues:
Ensure your SSH keys and user permissions are correctly configured in the inventory/hosts.ini.

## Ansible Errors:
Run the playbooks in verbose mode for more details:

```
ansible-playbook -vvv -i inventory/hosts.ini playbooks/site.yml
```
## Docker Installation Problems:
Verify that the target system supports Docker and that the repository and GPG key URLs are accessible.

## Contributing
Contributions are welcome! Please fork this repository, submit your changes via pull requests, and follow standard best practices for Ansible playbooks and roles.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

Happy automating!
