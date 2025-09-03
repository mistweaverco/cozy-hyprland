#!/usr/bin/env bash

# Cozy Hyprland Installation Script

set -e

curr_dir=$(pwd)

echo "🚀 Setting up Cozy Hyprland ..."

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo "❌ This script should not be run as root"
   exit 1
fi

# Check for required packages
echo "📦 Checking required packages..."
missing_packages=()

required_packages=(
  "qt6-svg"
  "qt6-multimedia-ffmpeg"
  "qt6-virtualkeyboard"
  "blueberry"
  "pacman-contrib"
  "wl-screenrec"
  "wf-recorder"
  "hyprsunset"
  "ttf-cascadia-mono-nerd"
  "wofi"
  "dhcp"
  "iwd"
  "hyprlock"
  "swaybg"
  "hypridle"
  "wl-clip-persist"
  "fcitx5"
  "mako"
  "swayosd"
  "satty"
  "hyprshot"
  "pamixer"
  "wiremix"
  "impala"
  "blueberry"
  "waybar"
  "nvim"
  "grim"
  "slurp"
  "wl-clipboard"
  "hyprpicker"
  "btop"
  "power-profiles-daemon"
)

for pkg in "${required_packages[@]}"; do
    if ! pacman -Q "$pkg" &> /dev/null; then
        missing_packages+=("$pkg")
    fi
done

if [[ ${#missing_packages[@]} -gt 0 ]]; then
    echo "⚠️  Missing required packages: ${missing_packages[*]}"
    echo "   Install with: pamac install ${missing_packages[*]}"
    exit 1
else
    echo "✅ All required packages are installed"
fi

echo "🔧 Copying configuration files..."
sudo mkdir -p /usr/share/sddm/themes/cozy
sudo cp -rf config/sddm/themes/cozy/. /usr/share/sddm/themes/cozy/
echo ""

echo "🔧 Copying fonts..."
sudo cp -r /usr/share/sddm/themes/cozy/fonts/{redhat,redhat-vf} /usr/share/fonts/
echo "Updating font cache..."
fc-cache -fv
echo ""

echo "🔗 Creating symlinks for configuration files..."
ln -s "$curr_dir/config/hypr" ~/.config/hypr
ln -s "$curr_dir/config/mako" ~/.config/mako
ln -s "$curr_dir/config/swayosd" ~/.config/swayosd
ln -s "$curr_dir/config/waybar" ~/.config/waybar
echo ""

echo ""
echo "🎉 Installation complete!"
echo ""
