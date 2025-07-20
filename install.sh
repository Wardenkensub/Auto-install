#!/bin/bash

echo "=== Octra Pre-Client Setup ==="

# Langkah-langkah setup
echo -e "\nCloning repository..."
git clone https://github.com/octra-labs/octra_pre_client.git || exit 1
cd octra_pre_client || exit 1

echo "Setting up Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

echo "Installing dependencies..."
pip install -r requirements.txt

echo "Copying wallet.json.example to wallet.json..."
cp wallet.json.example wallet.json

# Input dari user
read -p "Enter your PRIVATE KEY: " priv
read -p "Enter your OCTRA ADDRESS: " addr

# Ganti placeholder di wallet.json
sed -i "s/\"priv\": \"[^\"]*\"/\"priv\": \"$priv\"/" wallet.json
sed -i "s/\"addr\": \"[^\"]*\"/\"addr\": \"$addr\"/" wallet.json

echo -e "\n✅ wallet.json has been updated!"
echo "Here's the content:"
cat wallet.json

echo -e "\nTo start the client, run:"
echo "./run.sh"
