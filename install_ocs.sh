#!/bin/bash

echo "🚀 Starting Auto Installer for ocs01-test..."
echo "By Kenji Subagja"

# Step 1: Install Rust
echo "📦 Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Step 2: Clone repo
echo "📥 Cloning ocs01-test repo..."
git clone https://github.com/octra-labs/ocs01-test.git
cd ocs01-test || { echo "❌ Failed to enter directory"; exit 1; }

# Step 3: Build binary
echo "🔨 Building with cargo..."
cargo build --release

# Step 4: Copy exec_interface.json
echo "📂 Copying exec_interface.json..."
cp EI/exec_interface.json . || { echo "❌ Failed to copy exec_interface.json"; exit 1; }

# Step 5: Prompt user for PRIVATE KEY B64 and ADDRESS OCT
echo "🔐 Now enter your wallet credentials."
read -p "Enter your PRIVATE KEY B64: " privkey
read -p "Enter your ADDRESS OCT: " octaddr

# Step 6: Create wallet.json
echo "📝 Creating wallet.json..."
cat <<EOF > wallet.json
{
  "priv": "$privkey",
  "addr": "$octaddr",
  "rpc": "https://octra.network"
}
EOF

echo "✅ wallet.json created successfully."

# Step 7: Run the binary directly
echo "🚀 Running ocs01-test..."
./target/release/ocs01-test
