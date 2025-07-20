#!/bin/bash

echo "=== Octra Pre-Client Setup ==="

# Clone & masuk folder
git clone https://github.com/octra-labs/octra_pre_client.git || exit 1
cd octra_pre_client || exit 1

# Setup venv & install requirements
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Salin template
cp wallet.json.example wallet.json

# Minta input
read -p "Enter your PRIVATE KEY: " priv
read -p "Enter your OCTRA ADDRESS: " addr

# Overwrite wallet.json langsung (hindari sed)
cat > wallet.json <<EOF
{
  "priv": "$priv",
  "addr": "$addr",
  "rpc": "https://octra.network"
}
EOF

echo -e "\n✅ wallet.json has been updated!"
cat wallet.json

echo -e "\nTo start the client, run this inside the octra_pre_client folder:"
echo "./run.sh"
