---
layout: post
title: Setting up server environment with Ansible
excerpt: A guide for setting up your server for Ruby on Rails application with Ansible
date: 2015-03-19 14:20:00 +03:00
name: 2015-03-19-setting-up-server-environment-with-ansible
tags: ansible ruby-on-rails ruby bluepill nginx puma capistrano postgresql redis
type: post
author: Victor

published: true
footer_related_posts: false

comments: true
---

### Introduction

In this post I will explain how to simply and fast setup the server
environment and deploy the Ruby on Rails application with Ansible and Capistrano.

Our application will use:
 * [Rbenv v1.0.0](https://github.com/rbenv/rbenv) for managing Ruby versions
 * [Ruby v2.2.2](https://github.com/ruby/ruby/tree/ruby_2_2)
 * [Ruby on Rails v4.2.3](https://github.com/rails/rails)
 * [Ansible v1.9.4](https://www.ansible.com/) - a radically simple IT automation system
 * [Bluepill v0.1.1](https://github.com/bluepill-rb/bluepill) - simple process monitoring tool
 * [NGINX v1.9.9](http://nginx.org/) - an HTTP and reverse proxy server
 * [Puma v3.2.0](https://github.com/puma/puma) - a simple, fast, threaded,
and highly concurrent HTTP 1.1 server for Ruby/Rack applications
 * [Capistrano v3.4.0](https://github.com/capistrano/capistrano) - Remote multi-server automation tool
 * [Redis v3.0.7](https://redis.io/]) -  an open source (BSD licensed), in-memory data structure store for cache server
 * [PostgreSQL v9.4.4](https://www.postgresql.org/)

### Server setup with Ansible  

But why do we need Ansible? Ansible it's a Python application that useful for automation
process of routine tasks such as server management and tuning.
I guess, every web-developer has had some difficulties in deploying the
environment for applications. We have a powerful deployment tool Capistrano,
but before using it we should prepare our new server instance.
It's not a difficult but boring process. And also our project could have dependencies
with special versions. And possibly, we will need to manage a dozens of
servers with the same environment with little differences, it's not a trivial task.

Today we have several tools to make life easier for system administrators.
For example -  [Chef](https://www.chef.io/chef/), [Ansible](https://www.ansible.com/),
[Puppet](https://puppet.com/), [Salt](https://github.com/saltstack/salt).
These products are using by DevOps-engineers for auto-management of server configurations.
A big profit of Ansible that you don't need to install any extra applications (dependencies)
on the server, because it already has the Python installed.  

At the base of this tool is a playbook (in chef it's a cookbook). It's a YAML file,
that contains a list of tasks that required to execute. Ansible is using for configuring
servers by famous companies such as Twitter, Electronic Arts, Evernote and GoPro.  
Declarativity and simplicity of playbooks is one of the strongest sides of this tool.
A special form of file is using for the list of hosts on which the playbooks will be cast:

```yaml
[webservers]
host1's address
host2's address
host2's address
```

There is a declaration of group between square brackets. Groups could have a child groups.
A simple playbook (playbook.yml) execution command could look like this:

```bash
ansible-playbook -i hosts playbook.yml  
```  

### Presets

**Important:**  you can use any VPS server.

#### Create a new server

You can use any hosting service: Digital Ocean, AWS etc. After creation of new server
instance you will need to get it IP address.
Check the server via SSH with the SSH pub key that you provided for server on droplets page.

```bash
ssh root@ip
```

If you will see 'Welcome to Ubuntu 14.04.1 LTS', than everything all right, go to the next step.

#### Upgrade the system packages

Login to system as root and run the commands:

```bash
sudo apt-get update
sudo apt-get upgrade
```

After the process complete we can exit from server. We will not login to server manually any more (in this tutorial).

#### SSH-keys generation

We will need two pairs of keys. With the first one you (and Capistrano) will
get  authorized to server from your local machine. With the second one you will provide
the access from server to git repository. Keep the password empty for both key pairs.

Run the command for the first pair (need to generate key on the local machine):

```bash
ssh-keygen -t rsa -b 2048
```

You can the path and name for key. And set the access for key:

```bash
chmod 600 key_name
```

Later with Ansible scripts we will copy the public key `key_name.pub` to file
`authorized_keys` on the remote server to `/home/user/.ssh` folder for deployer
user with which credentials we will authorized on the remote server.

#### Ansible installation on the local machine

Run this commands:

```bash
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

Instructions for another platforms can be found  [here](http://docs.ansible.com/ansible/latest/intro_installation.html#installation)

Check the version:

```bash
ansible --version
-> ansible 1.9.4
```

Congratulations, all preparations have completed, we can start the job.

### Playbooks for Ansible

Create a folder `config/provision` in our project's directory. Create `playbook.yml` file in `provision` folder and other files according to this:

```
- config
  - provision
    - roles
    - vars
      bluepill_plbk.yml
      database_plbk.yml
      playbook.yml
      redis_plbk.yml
      user_plbk.yml
      webserver_plbk.yml
      webservers
```

The source code for config files will be represented below. As you can find,
in these files present special constructions \{\{  \}\}- it's dynamic insertions of variables (Ansible provide this). You can declare variables for example in `playbook.yml` and use them inside of other config files.

**Another part of this guide will be published soon...**

All sources and templates could be found here: [https://github.com/happyjedi/Guides/tree/master/Ansible/provision](https://github.com/happyjedi/Guides/tree/master/Ansible/provision)    
