#!/bin/bash

# Initializing the setup script
echo "Initializing the setup script..."
echo "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

#### SETUP FILE STRUCTURE ####
echo "##############################################"
echo "            SETTING UP FILESYSTEM             "
echo "##############################################"
echo "Creating 'downloads' directory..."
mkdir -p ./downloads
echo "Creating 'Applications' directory in the home folder..."
mkdir -p $HOME/Applications

#### INSTALL APPLICATIONS ####
echo "##############################################"
echo "           INSTALLING APPLICATIONS            "
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

echo "Customizing 'Ghidra.desktop' to include the '07 - Reverse Engineering' category..."
sed -i "s/{HOME}/$(echo $HOME | sed 's/\//\\\//g')/g" ./init/ghidra/Ghidra.desktop
sed -i "s/Categories=.*/Categories=07-ReverseEngineering;Development;/g" ./init/ghidra/Ghidra.desktop

echo "Copying 'Ghidra.desktop' to local applications menu and desktop..."
cp ./init/ghidra/Ghidra.desktop $HOME/.local/share/applications
chmod +x $HOME/.local/share/applications/Ghidra.desktop
cp ./init/ghidra/Ghidra.desktop $HOME/Desktop
chmod +x $HOME/Desktop/Ghidra.desktop

echo "Installing 'Ghidra.desktop' to the applications menu..."
xdg-desktop-menu install --novendor $HOME/.local/share/applications/Ghidra.desktop

echo "Creating '07-ReverseEngineering.directory' for the app menu..."
mkdir -p $HOME/.local/share/desktop-directories
cat << EOF > $HOME/.local/share/desktop-directories/07-ReverseEngineering.directory
[Desktop Entry]
Name=07 - Reverse Engineering
Icon=preferences-system
Type=Directory
EOF

echo "Copying Ghidra icon to the Ghidra application directory..."
cp ./init/ghidra/ghidra_icon_white.png $HOME/Applications/Ghidra

echo "Installing OpenJDK 24..."
sudo apt install openjdk-24-jdk -y

# End of the setup script
echo "##############################################"
echo "        SETUP SCRIPT COMPLETED SUCCESSFULLY    "
echo "##############################################"
