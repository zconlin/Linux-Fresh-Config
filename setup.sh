#!/bin/bash

#### SET UP FILE STRUCTURE ####
echo "##############################################"
echo "INITIALIZING THE SETUP SCRIPT"
echo "##############################################"
echo "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

#### SET UP FILE STRUCTURE ####
echo ""
echo "##############################################"
echo "SETTING UP FILESYSTEM"
echo "##############################################"
echo "Creating 'downloads' directory..."
mkdir -p ./downloads
echo "Creating 'Applications' directory in the home folder..."
mkdir -p $HOME/Applications

#### INSTALL APPLICATIONS ####
echo ""
echo "##############################################"
echo "INSTALLING APPLICATIONS"
echo "##############################################"

# Ghidra
echo "Starting Ghidra installation..."
echo "Downloading Ghidra zip file to './downloads'..."
wget -O ./downloads/Ghidra.zip "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.2.1_build/ghidra_11.2.1_PUBLIC_20241105.zip"

echo "Extracting Ghidra to '$HOME/Applications'..."
unzip -q ./downloads/Ghidra.zip -d $HOME/Applications

echo "Renaming extracted folder to 'Ghidra'..."
mv $HOME/Applications/ghidra_* $HOME/Applications/Ghidra

echo "Setting execute permissions for 'ghidraRun'..."
chmod +x $HOME/Applications/Ghidra/ghidraRun

echo "Creating '.local/share/applications' directory if not already present..."
mkdir -p $HOME/.local/share/applications

echo "Customizing 'Ghidra.desktop' file with user home directory..."
sed -i "s/{HOME}/$(echo $HOME | sed 's/\//\\\//g')/g" ./init/ghidra/Ghidra.desktop

echo "Copying 'Ghidra.desktop' to local applications menu and desktop..."
cp ./init/ghidra/Ghidra.desktop $HOME/.local/share/applications
chmod +x $HOME/.local/share/applications/Ghidra.desktop
cp ./init/ghidra/Ghidra.desktop $HOME/Desktop
chmod +x $HOME/Desktop/Ghidra.desktop

echo "Copying Ghidra icon to the Ghidra application directory..."
cp ./init/ghidra/ghidra_icon_white.png $HOME/Applications/Ghidra

echo "Installing OpenJDK 24..."
sudo apt install openjdk-24-jdk -y

#### SET UP ZSHRC ####
echo ""
echo "##############################################"
echo "SETTING UP ZSHRC"
echo "##############################################"

# Adding ntfy to zshrc if not already present
if ! grep -q "curl -d \"\${1:-Command finished executing}\" ntfy.sh/z-command-notification" ~/.zshrc; then
  echo "Creating notify alias."
  NOTIFY_FUNC='
  notify() {
    curl -d "${1:-Command finished executing}" ntfy.sh/z-command-notification
  }
  '
  echo "Adding notify function to .zshrc..."
  echo "$NOTIFY_FUNC" >> ~/.zshrc
else
  echo "The notify function is already present in your .zshrc."
fi

# Sourcing .zshrc
source ~/.zshrc

# End of the setup script
echo ""
echo "##############################################"
echo "SETUP SCRIPT COMPLETED SUCCESSFULLY"
echo "Reload your .zshrc with: source ~/.zshrc"
echo "##############################################"
echo ""