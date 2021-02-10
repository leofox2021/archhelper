#METHODS
function yay {

#CHECKIG IF NANO INSTALLED 
var1=0
outputvalue=$(which nano) 
if [[ $outputvalue = "/usr/bin/nano" ]] ; then 
var1=1
else
tput sgr0 
sudo pacman -S nano 
fi 

#ENABLING MULTILIB 
sudo sed -i '92 s/^#//g' /etc/pacman.conf
sudo sed -i '93 s/^#//g' /etc/pacman.conf

#INSTALLING YAY AND PAMAC  
tput setaf 5
echo "Installing Yay..."
tput sgr0
sudo pacman -S git base-devel
sudo git clone https://aur.archlinux.org/yay.git 
uservar=$USER
sudo chown -R $uservar /home/$uservar/yay 
cd yay
makepkg -si
tput sgr4 
echo "Done installing Yay!" 
}

function pamac {
tput setaf 5
echo "Installing Pamac..."
tput sgr0 
yay -S pamac 
tput setaf 4
echo "All done!" 
}

function nvidiainstaller {
#INSTALLING NVIDIA DRIVERS 
tput setaf 4
echo "Now let's install Nvidia dirvers.
But beforehand, answer some questions."
tput setaf 3 

#METHODS  
function nvidia_main {
tput sgr0
sudo pacman -S nvidia nvidia-utils opencl-nvidia nvidia-settings lib32-opencl-nvidia lib32-nvidia-utils
}

function nvidia_lts {
tput sgr0
sudo pacman -S nvidia-lts nvidia-utils opencl-nvidia nvidia-settings lib32-opencl-nvidia lib32-nvidia-utils
}

#VARS
hybrid=false 
custom=false
lts=false
modified=false
empty=1

#HYBRID QUESTION
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

#LTS KERNEL QUESTION  
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

#CUSTOM KERNEL QUESTION
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

#INTSALLATION 
if [[ $lts = true ]] ; then
nvidia_lts
else
nvidia_main 
fi

#EXTRA
if [[ $hybrid = true ]] ; then 
tput setaf 2 
echo "Installing additional packages for Nvidia Prime technology..."
tput sgr0
sudo pacman -S nvidia-prime 
yay -S optimus-manager optimus-manager-qt
sudo systemctl start optimus-manager
sudo systemctl enable optimus-manager
else
empty=1
fi 

if [[ $modified = true ]] ; then 
tput setaf 2
echo "Installing additional packages for custom kernel..."
tput sgr0 
sudo pacman -S nvidia-dkms
else
empty=2
fi

#GRRRAND FINALE
tput setaf 4
echo "All neccesary NVIDIA packages installed!"
tput sgr0
}

function wine_intel {
tput sgr0 
sudo pacman -S wine steam winetricks lutris vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader cabextract cups faudio lib32-acl lib32-faudio lib32-fontconfig lib32-freetype2 lib32-gettext lib32-giflib lib32-gnutls lib32-gst-plugins-base-libs lib32-gtk3 lib32-harfbuzz lib32-lcms2 lib32-libjpeg-turbo lib32-libldap lib32-libnl lib32-libpcap lib32-libpng lib32-libtasn1 lib32-libtiff lib32-libusb lib32-libxcomposite lib32-libxinerama lib32-libxrandr lib32-libxslt lib32-libxss lib32-mpg123 lib32-nspr lib32-nss lib32-opencl-icd-loader lib32-p11-kit lib32-sqlite lib32-v4l-utils lib32-vkd3d lib32-vulkan-icd-loader libimagequant lsof opencl-icd-loader python-distro python-evdev python-pillow sane vkd3d zenity icoutils xterm wget curl libudev0-shim python2 wxgtk-common wxgtk3 gnu-netcat lib32-libudev0-shim python2-wxpython3 vulkan-tools gamemode lib32-gamemode
tput setaf 4
echo "Done intsalling wine!"
}

function wine_amd {
tput sgr0 
sudo pacman -S wine steam winetricks lutris vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader cabextract cups faudio lib32-acl lib32-faudio lib32-fontconfig lib32-freetype2 lib32-gettext lib32-giflib lib32-gnutls lib32-gst-plugins-base-libs lib32-gtk3 lib32-harfbuzz lib32-lcms2 lib32-libjpeg-turbo lib32-libldap lib32-libnl lib32-libpcap lib32-libpng lib32-libtasn1 lib32-libtiff lib32-libusb lib32-libxcomposite lib32-libxinerama lib32-libxrandr lib32-libxslt lib32-libxss lib32-mpg123 lib32-nspr lib32-nss lib32-opencl-icd-loader lib32-p11-kit lib32-sqlite lib32-v4l-utils lib32-vkd3d lib32-vulkan-icd-loader libimagequant lsof opencl-icd-loader python-distro python-evdev python-pillow sane vkd3d zenity icoutils xterm wget curl libudev0-shim python2 wxgtk-common wxgtk3 gnu-netcat lib32-libudev0-shim python2-wxpython3 vulkan-tools gamemode lib32-gamemode
tput setaf 4
echo "Done intsalling wine!"
}

function anythingelse {
tput setaf 4 
echo "Anything else? (Enter YES or NO)" 
read input 
if [[ $input = yes ]] ; then 
menu 
else 
exit 
fi 
} 

function menu {
tput setaf 3
echo "Programs to install:"
tput setaf 2
sleep 0.1
echo "1 - Yay Helper"
sleep 0.1
echo "2 - Pamac"
sleep 0.1
echo "3 - Nvidia drivers"
sleep 0.1
echo "4 - Gaming essentials (Intel)"
sleep 0.1
echo "5 - Gaming essentials (AMD)"
sleep 0.1
echo "6 - Install all (Intel)"
sleep 0.1
echo "7 - Install all (Intel + Nvidia)"
sleep 0.1 
echo "8 - Install all (Intel + AMD)"
sleep 0.1
echo "9 - Install all (AMD)"
tput setaf 4 
echo "What would you like to install? (1-9)"

tput sgr0 
read input 

if [[ $input = "1" ]] ; then 
yay 
anythingelse

 elif [[ $input = "2" ]] ; then 
 pamac
 anythingelse
 
  elif [[ $input = "3" ]] ; then 
  nvidiainstaller
  anythingelse
  
   elif [[ $input = "4" ]] ; then 
   wine_intel
   anythingelse
   
    elif [[ $input =  "5" ]] ; then 
    wine_amd
    anythingelse
    
     elif [[ $input = "6" ]] ; then 
     yay 
     pamac 
     wine_intel
     
      elif [[ $input = "7" ]] ; then 
      yay 
      pamac 
      nvidiainstaller
      wine_intel
      
       elif [[ $input = "8" ]] ; then 
       yay 
       pamac 
       wine_intel
       sudo pacman -S vulkan-radeon
       
        elif [[ $input = "9" ]] ; then 
        yay 
        pamac 
        wine_amd  
        
else 
 tput setaf 3 
echo "You should enter a valid number! (1-9)"
sleep 1 
menu 
fi
}

function entermenu {
tput sgr0 
read input 
if [[ $input = "archhelper" ]] ; then 
tput setaf 4
echo "Some easter eggs we've got here!
But let's get serious bro..."
entermenu
else
menu
fi 
}



#MAIN 
tput setaf 4 
sleep 0.1
echo "Hi there! This is my script to help you ease your Arch usage!"
sleep 0.1
echo "This script can help you install various unseful components to your system." 
sleep 0.1
echo "Press enter to proceed to the menu"
sleep 0.1
echo "(Also avoid running the script as SUDO as it may cause problems with installation)"

entermenu 





