#!/bin/bash

echo "🚀 Starting Auto Installer for ocs01-test..."

# Install Rust
echo "📦 Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Clone ocs01-test repo
echo "📥 Cloning ocs01-test repo..."
git clone https://github.com/octra-labs/ocs01-test.git
cd ocs01-test || { echo "❌ Failed to enter directory"; exit 1; }

# Build the binary
echo "🔨 Building with cargo..."
cargo build --release

# Copy execution interface file
echo "📂 Copying exec_interface.json..."
cp EI/exec_interface.json . || { echo "❌ Failed to copy exec_interface.json"; exit 1; }

# Setup wallet.json
echo "📝 Setting up wallet.json..."
cat <<EOF > wallet.json
{
  "priv": "\$priv",
  "addr": "\$addr",
  "rpc": "https://octra.network"
}
EOF

echo "✅ File wallet.json created. Please open it and replace \$priv and \$addr with your actual private key and Octra address."
echo ""
echo "🗂️ Next Steps:"
echo "- Copy the compiled binary: ./target/release/ocs01-test to your CLI folder."
echo "- Ensure exec_interface.json is also in the same folder as the binary."
echo ""
echo "🎉 Done!"
