# docker-bedrock-base

Dockerised version of the Bedrock Wordpress installation with some preselected plugins

The purpose of this project is to be a base install of Wordpress for quick development of small client sites. Common plugins will be pre installed and a component based template will be included as a starting point for template structure and post types.

This includes a version of bedrock as part of the repo. Go check it out, it's super cool [Bedrock](https://roots.io/bedrock/)

## Todo

- work out best way to handle DB migration and backup
- composer container
  - mount project root
  - for running composer update
  - create commands for update and install etc.

## Requirements
- docker
- kitematic (not required but helpful)

## New Install

- Download the zip of master branch
- Extract to location of project
- Copy local .env
- Copy over ssl certs into ```config/keys```
- ```docker-compose build project```
- ```docker-compose up -d```

### Notes

You'll need to enable show hidden files on a Mac

All commands are run from within the root of the project

Use the following on Mac if you have problems with files not running as sometimes OSX changes the line endings and everything dies
```RUN cat /usr/local/bin/runtime.sh | tr "\r" "\n" > /usr/local/bin/runtime.sh```

## Existing project setup

To include info on migrating db's etc.

## Useful commands

delete docker cache (removes all running containers and images)
```
docker rm $(docker ps -a -q)

docker rmi $(docker images -q)
```
