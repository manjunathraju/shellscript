#!/bin/bash

# Read the configuration file
while IFS= read -r server; do
  # Extract the server details from the configuration line
  hostname=$(echo "$server" | cut -d ',' -f 1)
  username=$(echo "$server" | cut -d ',' -f 2)
  password=$(echo "$server" | cut -d ',' -f 3)

  # Connect to the server via SSH and deploy the application
  echo "Deploying application to $hostname"
  sshpass -p "$password" ssh "$username@$hostname" <<EOF
    # Commands to execute on the remote server
    # For example:
    yum install -y git
    # Add any additional deployment commands here

    exit
EOF

  echo "Deployment completed for $hostname"
done < server.conf
