#!/bin/sh

# Wait for Vault to start
sleep 5

# Login with the root token
export VAULT_ADDR='http://127.0.0.1:8200'
vault login roott

vault auth enable aws

vault write auth/aws/config/client \
    access_key=AKIAYS2NXHAOUXPUDPJ7 \
    secret_key=yw1RYZz5BpQeXceVJM8w4TCFFjzke3i \
    region=ap-south-1

vault write auth/aws/role/my-role \
    auth_type=iam \
    bound_iam_principal_arn=arn:aws:iam::590184134685:role/r1 \
    policies=default \
    max_ttl=500h    

# Enable KV secrets engine (optional as KV is enabled by default in dev mode)
vault secrets enable -path=secret kv

# Create initial key-value pairs
vault kv put secret/myapp key.email=chinma@example.com key.password=mypassword key.username=devil

# Keep the container running
tail -f /dev/null
