# Use the official Vault image from HashiCorp
FROM hashicorp/vault:latest

# Expose Vault's default port
EXPOSE 8200

# Copy the initialization script
COPY initialize-vault.sh /initialize-vault.sh

# Make the script executable
RUN chmod +x /initialize-vault.sh

# Start Vault in development mode and run the initialization script
CMD ["sh", "-c", "vault server -dev -dev-root-token-id=roott -dev-listen-address=0.0.0.0:8200 & /initialize-vault.sh"]
