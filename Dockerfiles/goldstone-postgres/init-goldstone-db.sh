#!/bin/bash

pass="'$GOLDSTONE_PASSWORD'"
gosu postgres postgres --single -E <<- EOF
    CREATE USER goldstone PASSWORD $pass;
    CREATE DATABASE goldstone_docker;
    GRANT ALL PRIVILEGES ON DATABASE goldstone_docker TO goldstone;
    ALTER USER goldstone CREATEDB;
EOF

