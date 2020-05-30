#!/bin/bash
#
# This is file install-fastex.sh, version 0.1 beta 2020-05-26
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#####################################################
#
#            SETUP FILES AND FOLDERS
#
#####################################################
#----------------------------------------------------
# Set the variable for the installation directory
#----------------------------------------------------
year=2020
alias zenq='zenity --question --icon-name=info --width=500 --height=300 --title="FasTeX $year Installation" --ok-label="YES" --cancel-label="NO"'
alias zeni='zenity --info --width=500 --height=300 --title="FasTeX $year Installation"'
#----------------------------------------------------
# Create the installation direcotry
#----------------------------------------------------
# If ~/fastex/$year exists:
#(
zenq --ok-label="Current Directory" --cancel-label="Home Directory" --text="Where do you want to install Fastex?"
if [ $? = 0 ]  ;then
base=`pwd`
else
base=$HOME/fastex
fi
baseyear=$base/$year
basedoc=$base/doc
basepath=$base/$year/bin

if [ -d "$baseyear" ]; then
zenq --text="A folder '$baseyear already exists.\n\
You are probably attempting to reinstall FasTeX $year.\n\
By pressing 'YES' the folder will be overwritten and all its contents will be lost. By clicking on "NO" the installation process will be terminated.\n\n\
Do you want to procede?"
# If 'YES':
  if [ $? = 0 ]  ;then
    rm -r $baseyear
    rm -rf $basedoc
    mkdir -p $baseyear
    mkdir -p $basedoc
# If 'NO':
  else
zeni --text="You have chosen to exit the installation.\n\n\n\n\ GOODBYE!!!"
  exit
fi
else
# If ~/fastex/$year does not exist:
  mkdir -p $baseyear
  mkdir -p $basedoc
fi
#----------------------------------------------------
# Download the installer from the nearest CTAN mirror: 
#----------------------------------------------------
echo "# Downloading the installer from a CTAN mirror..."
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -C $baseyear --strip-components=1 -xzf install-tl-unx.tar.gz
#----------------------------------------------------
# Copy the auxiliary files in the installation directory:
#----------------------------------------------------
cp *.txt $baseyear
cp fastex.profile.linux $baseyear
cp TLMGRbase.desktop $baseyear
cp fastex-icon-2020.svg $baseyear
cp fastex-icon.svg $basedoc
#----------------------------------------------------
# Move to the installation directory:
#----------------------------------------------------
cd $baseyear
#----------------------------------------------------
# Edit and rename fastex.profile.linux:
#----------------------------------------------------
perl -i -pe "s{<BASE>}{$baseyear}" fastex.profile.linux
mv fastex.profile.linux fastex.profile
#----------------------------------------------------
# Create /user and /share directories
#----------------------------------------------------
mkdir user
mkdir share
#####################################################
#
#                  INSTALLATION
#
#####################################################
echo "# Installing TeX Live infrastructure. This process can take several minutes depending on your connection speed."
plat=`./install-tl -print-platform`
./install-tl -no-gui -profile=./fastex.profile
export PATH=$baseyear/bin/$plat:$PATH
#----------------------------------------------------
# Install a minimal set of packages
#----------------------------------------------------
cat pkgs-minimal.txt pkgs-languages.txt pkgs-classes.txt pkgs-mathematics.txt > pkgs-all.txt
echo "# Installing a minimal set of packages. This process can take several minutes depending on your connection speed."
tlmgr install latex-bin luahbtex tlshell $(cat pkgs-all.txt | tr '\n' ' ')
#----------------------------------------------------
# Installing suftesi
#----------------------------------------------------
zenq --text="Do you want to install the suftesi class?"
if [ $? = 0 ]  ;then
echo "# Installing suftesi class. This process can take several minutes depending on your connection speed."
tlmgr install $(cat pkgs-suftesi.txt | tr '\n' ' ')
fi
#----------------------------------------------------
# Remove auxiliary files:
#----------------------------------------------------
rm pkgs-*.txt 
rm fastex.profile
rm install-tl
#####################################################
#
#                PATH SETTING
#
#####################################################
echo "# Path settings."
TEXT="PATH=$baseyear/bin/$plat:\$PATH"
if [ -f $HOME/.bash_aliases ]; then
zenq --text="The .bash_aliases file in your Home will be edited.\n\n\
All lines containing the string '$base' will be removed and replaced with the current installation path:\n\
PATH=$baseyear/bin/$plat:\$PATH\n\n\
Do you want to procede?\n\n\n\
If you think you don't have to use the Terminal to compile LaTeX files you can skip this step. You will need to set the correct path for executables directly in the editor:\n\
$baseyear/bin/$plat"
# If 'YES':
  if [ $? = 0 ]  ;then
#sed -i "\|$base|d" ~/.profile
#echo "$TEXT" >> ~/.profile
sed -i "\|$basepath|d" ~/.bash_aliases
echo "$TEXT" >> ~/.bash_aliases
# If 'NO':
else
zeni --text="If you want to use 'tlmgr' and other commands provided by TeX Live remember to set the correct path for each session, with this command:\n\PATH=\"\$baseyear/bin/x86_64-linux:\$PATH\""
fi
else
echo "$TEXT" >> ~/.bash_aliases
fi
#####################################################
#
#             CREATE TLMGR LAUNCHER
#
#####################################################
File=/etc/lsb-release
if grep -q Mint "$File"; then
echo "# Creating a TeX Live Manager launcher"
zenq --text="You are installing on Linux Mint. A TeX Live Manager launcher can be created in the $baseyear folder. Do you want to proceed?"
  if [ $? = 0 ]  ;then
perl -i -pe "s{<BASE>}{$baseyear}" TLMGRbase.desktop
perl -i -pe "s{TLMGRbase}{TeX Live Manager}" TLMGRbase.desktop
fi
fi
#####################################################
#
#                SET FOLDER ICON
#
#####################################################
echo "# Setting the fodler icon"
cd ..
gio set -t string $year metadata::custom-icon file://$baseyear/fastex-icon-$year.svg
cd ..
gio set -t string $base metadata::custom-icon file://$basedoc/fastex-icon.svg

cd $base
if [ $base = `pwd` ]]; then
rm -f fastex-icon.svg
rm -f fastex-icon.ico
rm -f Desktop.ini
rm -f *.txt
rm -f fastex.profile.*
rm -f install-*
rm -f wget-log
rm -f TLMGRbase.desktop
rm -rf .git
rm -f .gitignore
fi

echo "# Finishing installation"
echo "# Fastex $year successfully installed!"

#) |
#zenity --progress \
#  --title="FasTeX $year installation" \
#  --pulsate \
#  --width=500 --height=300



