#!/bin/bash

# fetch DB password from Secrets Manager
DB_PASS=$(aws secretsmanager get-secret-value \
    --region us-west-2 \
    --secret-id "rds!db-758a8aea-d5eb-47a0-831f-3208756759c1" \
    --query SecretString --output text | jq -r .password)

# export password so Docker Compose can see it
export DB_PASSWORD="$DB_PASS"
export DB_USER="admin"
export DB_HOST="book-portal-db.clw4aeawcfat.us-west-2.rds.amazonaws.com"
export DB_NAME="book_portal"

#start containers
docker compose up -d

#clean up
unset DB_PASS