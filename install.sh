#!/bin/bash

echo "=== Octra Pre-Client Setup ==="

# Clone repo dan masuk
git clone https://github.com/octra-labs/octra_pre_client.git || exit 1
cd octra_pre_client || exit 1

# Setup venv dan install
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Salin dan isi wallet
cp wallet.json.example wallet.json

read -p "Enter your PRIVATE KEY: " priv
read -p "Enter your OCTRA ADDRESS: " addr

cat > wallet.json <<EOF
{
  "priv": "$priv",
  "addr": "$addr",
  "rpc": "https://octra.network"
}
EOF

echo -e "\n✅ wallet.json has been updated!"
cat wallet.json

# Kembali ke folder awal & buat symlink
cd ..
ln -sf octra_pre_client/run.sh run.sh

echo -e "\n➡️ You can now run: ./run.sh"
