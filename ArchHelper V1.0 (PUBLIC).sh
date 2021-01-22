
#start 
sleep 2
tput setaf 4 #blue
echo "Hello, welcome to the script!
"
sleep 2s
echo "This script will help you install various useful elements to your system including" 
sleep 3s
tput setaf 2 #green
echo "- Yay Helper"
sleep 1s
echo "- Pamac"
sleep 1s
echo "- Nvidia drivers"
sleep 1s
echo "- Wine and its dependencies"
sleep 2s

holyfuck=1

function nanomethod {
tput setaf 4 
echo "Installing NANO..."
tput sgr0
sleep 1
sudo pacman -S nano 
}

#nano question
tput setaf 4 
echo "Before we start, let's do something
First of all, do you have NANO installed? [Type yes or no]"
tput sgr0 
read input
if [[ $input = "no" ]] ; then 
nanomethod
else
holyfuck=0
sleep 1 
tput setaf 4
echo "Alright..."
tput sgr0 
sleep 1
fi 

#nano description
echo "Now I'm going to open the pacman config 
You should uncomment the following 2 lines:"
tput setaf 2 
echo "[Multilib]
Include = /etc/pacaman.d/mirrorlist"
sleep 3
tput setaf 4

#opening nano
function opennano {
echo "Type anything to open the config!"
tput sgr0 
read input 
if [[ $input = "arch linux is better than windows" ]] ; then 
sleep 1 
tput setaf 4
echo "Alright, cool Arch boy, I got that..."
sleep 0.5
echo "But let's get serious..."
sleep 1
tput setaf 4
opennano
else
tput sgr0 
sudo nano /etc/pacman.conf 
sleep 1
tput sgr0
sudo pacman -Syyu
tput setaf 4
echo "You are handsome!"
sleep 1
fi
}

opennano 
#input condition
tput setaf 4 #blue
echo "
Everything is ready to go...
So lets start?
First of all we will install Yay Helper
You will be asked your password a couple of times during the installation"
tput setaf 3 #orange
echo "Enter YES if you want to start or EXIT to abort the script" 

#1st input

function startscript {
tput sgr0
read input
tput sgr0 #white 
if [[ $input = "yes" ]];then
tput setaf 3 #orange 
echo "Ok, starting!"
tput sgr0 #white 
sleep 1s

#2nd input
else
if [[ $input = "exit" ]]; then exit
else
tput setaf 4
echo "Type YES or EXIT!"
startscript
fi 
fi
}

startscript

#installing yay and pamac 
tput setaf 5
echo "Installing Yay..."
tput sgr0
sudo pacman -S git base-devel
sudo git clone https://aur.archlinux.org/yay.git
sleep 1 
tput setaf 4 
echo "Enter your exact username"
tput sgr0
read input 
sudo chown -R $input /home/$input/yay 
cd yay
makepkg -si
yay -Syu
sleep 2
tput setaf 5
echo "Installing Pamac..."
tput sgr0 
yay -S pamac 
sleep 2
tput setaf 4
echo "All done!"

#installing nvidia drivers 
tput setaf 4
echo "Now let's install Nvidia dirvers.
But beforehand, answer some questions."
sleep 1
tput setaf 3 

#methods 
function nvidia_main {
tput sgr0
sudo pacman -S nvidia nvidia-utils opencl-nvidia nvidia-settings lib32-opencl-nvidia lib32-nvidia-utils
}

function nvidia_lts {
tput sgr0
sudo pacman -S nvidia-lts nvidia-utils opencl-nvidia nvidia-settings lib32-opencl-nvidia lib32-nvidia-utils
}


hybrid=false 
custom=false
lts=false
modified=false
empty=1

#question 1
tput setaf 3
echo "Do you have hybrid GPU? (Intel-Nvidia)"
tput sgr0 
read input 
if [[ $input = "yes" ]]; then
tput setaf 4 
echo "Hybrid GPU detected!"
hybrid=true
else 
hybrid=false
tput setaf 4
echo "Got that!"
fi 

#question 3 
function question {
tput setaf 3
echo "Is it LTS kernel or not?"
tput sgr0
read input 
if [[ $input = "yes" ]] ; then
tput setaf 4
lts=true
echo "Hmmm, LTS kernel, seems reasonable..."
else 
tput setaf 4
echo "Great choice!"
lts=false
modified=true
fi 
}

#question 2 
tput setaf 3
echo "Do you use any custom kernel?" 
tput sgr0
read input
if [[ $input = "yes" ]] ; then 
tput setaf 3
custom=true
tput setaf 4
echo "Custom kernel detected!"
question 
else 
tput setaf 4
custom=false
echo "Alright..."
fi

#check flags
tput setaf 7
sleep 1
echo "Hybrid:" $hybrid
sleep 0.2
echo "Custom:" $custom
sleep 0.2
echo "LTS:" $lts
sleep 0.2
echo "Modified:" $modified
sleep 1
tput sgr0

#Installation
if [[ $lts = true ]] ; then
nvidia_lts
else
nvidia_main 
fi

#extra
if [[ $hybrid = true ]] ; then 
tput setaf 2 
echo "Installing additional packages for Nvidia Prime technology..."
tput sgr0
sleep 1
sudo pacman -S nvidia-prime 
yay -S optimus-manager optimus-manager-qt
else
empty=1
fi 

if [[ $modified = true ]] ; then 
tput setaf 2
echo "Installing additional packages for custom kernel..."
tput sgr0 
sleep 1
sudo pacman -S nvidia-dkms
else
empty=2
fi

sleep 2
tput setaf 4
echo "All neccesary NVIDIA packages installed!"
tput sgr0


#installing wine
sleep 2
tput setaf 4 
echo "Next up is WINE and gaming components"
sleep 1
tput sgr0 
sudo pacman -S wine winetricks lutris vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader cabextract cups faudio lib32-acl lib32-faudio lib32-fontconfig lib32-freetype2 lib32-gettext lib32-giflib lib32-gnutls lib32-gst-plugins-base-libs lib32-gtk3 lib32-harfbuzz lib32-lcms2 lib32-libjpeg-turbo lib32-libldap lib32-libnl lib32-libpcap lib32-libpng lib32-libtasn1 lib32-libtiff lib32-libusb lib32-libxcomposite lib32-libxinerama lib32-libxrandr lib32-libxslt lib32-libxss lib32-mpg123 lib32-nspr lib32-nss lib32-opencl-icd-loader lib32-p11-kit lib32-sqlite lib32-v4l-utils lib32-vkd3d lib32-vulkan-icd-loader libimagequant lsof opencl-icd-loader python-distro python-evdev python-pillow sane vkd3d zenity icoutils xterm wget curl libudev0-shim python2 wxgtk-common wxgtk3 gnu-netcat lib32-libudev0-shim python2-wxpython3 vulkan-tools gamemode lib32-gamemode
sleep 1
