# Initializing the setup script
echo "Initializing the setup script..."

#### SETUP FILE STRUCTURE ####
echo "##############################################"
echo "            SETTING UP FILESYSTEM             "
echo "##############################################"
mkdir ./downloads
mkdir $HOME/Applications

# .bash_profile and .bashrc
cat ./setup_files/bash/.bash_profile_additions >> $HOME/.bash_profile
cat ./setup_files/bash/.bashrc_additions >> $HOME/.bashrc

source $HOME/.bash_profile
source $HOME/.bashrc

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
mkdir $HOME/.local/share/applications
sed -i "s/{HOME}/$(echo $HOME | sed 's/\//\\\//g')/g" ./setup_files/ghidra/Ghidra.desktop
cp ./setup_files/ghidra/Ghidra.desktop $HOME/.local/share/applications
cp ./setup_files/ghidra/ghidra_icon_white.png $HOME/Applications/Ghidra