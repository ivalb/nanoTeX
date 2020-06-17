#!/bin/bash
#
# This is file install-nanotex-mac.sh, version 0.1 beta 2020-05-26
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#-------------------------------------------------------------------------------

year=2020
read -p "
# ---- STEP 1 ----------------------------------------------
| Where do you want to install nanoTeX? 
| Press [c]+[enter] to install in the current directory. 
| Press [h]+[enter] for home directory." INSTDIR
# -----------------------------------------------------------
if [ "$INSTDIR" = "c" ]; then
  base=`pwd`
else
  base=$HOME/nanotex
fi
baseyear=$base/$year

if [ -d "$baseyear" ]; then
read -p "
# ---- STEP 2 ----------------------------------------------
| A folder '$baseyear' already exists. 
| You are probably attempting to reinstall nanoTeX $year. 
| By pressing [y]+[enter] the folder will be overwritten 
| and all its contents will be lost. 
| By pressing [n]+[enter] the installation process will be terminated. 
| Do you want to procede?" CONTROLDIR
# -----------------------------------------------------------
# If 'YES':
if [ "$CONTROLDIR" = "y" ]; then
    rm -r $baseyear
    mkdir -p $baseyear
# If 'NO':
  else
echo "
# You have chosen to exit the installation.
| ************************
| *****              *****
| *****   GOODBYE!   *****
| *****              *****
| ************************"
  exit
fi
else
# If $baseyear does not exist:
  mkdir -p $baseyear
fi
  mkdir $base/texmf
#----------------------------------------------------
# Download installer
#----------------------------------------------------
echo ""
echo "# ---- INSTALLATION STARTS ---------------------------"
echo "# Downloading the installer from a CTAN mirror..."
curl -LO http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -C $baseyear --strip-components=1 -xzf install-tl-unx.tar.gz
#tar -zxf install-tl-unx.tar.gz -C $baseyear
#----------------------------------------------------
# Setup folder
#----------------------------------------------------
cp *.txt $baseyear
cp nanotex.profile.linux $baseyear
cd $baseyear
#----------------------------------------------------
# INSTALLATION 
#----------------------------------------------------
read -p "
# ---- STEP 3 ----------------------------------------------
| Do you want to perform a basic or full installation? 
| A full installation will require several GB, 
| while the basic installation will be around 300 MB. 
| I recommend the basic installation because 
| you can always add missing packages later. 
| Press [f]+[enter] for FULL.
| Press [c]+[enter] for CUSTOM." FULLCUSTOM
# -----------------------------------------------------------
if [ "$FULLCUSTOM" = "f" ]; then
# FULL
perl -i -pe "s{<BASE>}{$baseyear}" nanotex.profile.linux
perl -i -pe "s{<BASEU>}{$base}" nanotex.profile.linux
mv nanotex.profile.linux nanotex.profile
echo ""
echo "# Installing TeX Live full."
echo "# This process can take several minutes" 
echo "# depending on your connection speed."
plat=`./install-tl -print-platform`
./install-tl -no-gui -profile=./nanotex.profile
export PATH=$baseyear/bin/$plat:$PATH
else
# CUSTOM
perl -i -pe "s{<BASE>}{$baseyear}" nanotex.profile.linux

perl -i -pe "s{autobackup 1}{autobackup 0}" nanotex.profile.linux
perl -i -pe "s{srcfiles 1}{srcfiles 0}" nanotex.profile.linux
perl -i -pe "s{scheme-full}{scheme-infraonly}" nanotex.profile.linux
perl -i -pe "s{<BASEU>}{$base}" nanotex.profile.linux
mv nanotex.profile.linux nanotex.profile
echo ""
echo "# Installing TeX Live custom."
echo "# This process can take several minutes" 
echo "# depending on your connection speed."
plat=`./install-tl -print-platform`
./install-tl -no-gui -profile=./nanotex.profile
export PATH=$baseyear/bin/$plat:$PATH
#----------------------------------------------------
# Install a minimal set of packages
#----------------------------------------------------
cat pkgs-minimal.txt pkgs-languages.txt pkgs-classes.txt pkgs-mathematics.txt pkgs-fonts.txt > pkgs-all.txt
echo ""
echo "# Installing a minimal set of packages." 
echo "# This process can take several minutes" 
echo "# depending on your connection speed."
tlmgr install latex-bin luahbtex tlshell $(cat pkgs-all.txt | tr '\n' ' ')
#----------------------------------------------------
# Installing suftesi
#----------------------------------------------------
read -p "
# ---- STEP 4 ----------------------------------------------
| Do you want to install the 'suftesi' class 
| and all its dependecies (documentation included)? 
| Press [y]+[enter] for YES.
| Press [n]+[enter] for NO." SUFTESI
# -----------------------------------------------------------
if [ "$SUFTESI" = "y" ]; then
echo ""
echo "# Installing suftesi class." 
echo "# This process can take several minutes" 
echo "# depending on your connection speed."
tlmgr install --with-doc $(cat pkgs-suftesi.txt | tr '\n' ' ')
fi
#----------------------------------------------------
# No documentation for future package installations? 
#----------------------------------------------------
tlmgr option docfiles 0
fi
#----------------------------------------------------
# Remove auxiliary files:
#----------------------------------------------------
rm pkgs-*.txt
rm nanotex.profile*
rm install-tl

cd $base
if [ $base = `pwd` ]; then
rm -f *.txt
rm -f nanotex.profile*
rm -f install-*
rm -rf .git
rm -f .gitignore
fi

echo ""
echo "| Finishing installation"
echo "| nanoTeX $year successfully installed!"


