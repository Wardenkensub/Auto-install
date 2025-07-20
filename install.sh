#!/bin/bash

echo "=== Octra Pre-Client Setup ==="

# Clone & masuk ke folder
git clone https://github.com/octra-labs/octra_pre_client.git || exit 1
cd octra_pre_client || exit 1

# Setup venv
python3 -m venv venv
source venv/bin/activate

# Install dependensi
pip install -r requirements.txt

# Minta input user
read -p "Enter your PRIVATE KEY: " priv
read -p "Enter your OCTRA ADDRESS: " addr

# Buat wallet.json langsung
cat > wallet.json <<EOF
{
  "priv": "$priv",
  "addr": "$addr",
  "rpc": "https://octra.network"
}
EOF

echo -e "\n✅ wallet.json has been updated!"
cat wallet.json

# Cek apakah run.sh tersedia
if [ -f "run.sh" ]; then
  echo -e "\nTo start the client, run:"
  echo "./run.sh"
else
  echo -e "\n⚠️ 'run.sh' not found in this repo."
fi
