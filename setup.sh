# Initializing the setup script
echo "Initializing the setup script..."
#sudo apt update && sudo apt upgrade -y

#### SETUP FILE STRUCTURE ####
echo "##############################################"
echo "            SETTING UP FILESYSTEM             "
echo "##############################################"
mkdir -p ./downloads
mkdir -p $HOME/Applications

#### INSTALL APPLICATIONS ####
echo "##############################################"
echo "           INSTALLING APPLICATIONS            "
echo "##############################################"

# Ghidra
echo "Installing Ghidra..."
wget -O ./downloads/Ghidra.zip "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.2.1_build/ghidra_11.2.1_PUBLIC_20241105.zip"
mkdir -p $HOME/Applications
unzip -q ./downloads/Ghidra.zip -d $HOME/Applications
mv $HOME/Applications/ghidra_* $HOME/Applications/Ghidra
chmod +x $HOME/Applications/Ghidra/ghidraRun
mkdir -p $HOME/.local/share/applications
sed -i "s/{HOME}/$(echo $HOME | sed 's/\//\\\//g')/g" ./init/ghidra/Ghidra.desktop
cp ./init/ghidra/Ghidra.desktop $HOME/.local/share/applications
chmod +x $HOME/.local/share/applications/Ghidra.desktop
cp ./init/ghidra/Ghidra.desktop $HOME/Desktop
chmod +x $HOME/Desktop/Ghidra.desktop
cp ./init/ghidra/ghidra_icon_white.png $HOME/Applications/Ghidra
sudo apt install openjdk-24-jdk -y

# End of the setup script
echo "Setup script complete!"