#!/bin/bash

echo "=== Octra Pre-Client Setup ==="
echo "By : Kenji subagja"

# Clone repo 
git clone https://github.com/octra-labs/octra_pre_client.git || exit 1
cd octra_pre_client || exit 1

# Setup virtual environment dan install dependensi
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 
cp wallet.json.example wallet.json

# Input PRIVATE KEY and ADDRESS
read -p "Enter your PRIVATE KEY B64 : " priv
read -p "Enter your OCTRA ADDRESS   : " addr

# submit wallet
cat > wallet.json <<EOF
{
  "priv": "$priv",
  "addr": "$addr",
  "rpc": "https://octra.network"
}
EOF

echo -e "\n✅ wallet.json has been updated!"
cat wallet.json

echo "➡️ To run the client:"
echo "cd octra_pre_client && ./run.sh"
