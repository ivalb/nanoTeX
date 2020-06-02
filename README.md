A custom installer for TeX Live (Beta version for testing only)
--------------------------------

<img src="https://github.com/ivalb/nanoTeX/blob/master/nanotex-icon.svg" alt="nanoTeX logo" align="right" width="260px" style="max-width:100%;margin:0px 0px" border="0">nanoTeX is a custom installer for TeX Live distribution. Its purpose is to provide a minimal LaTeX installation, which can be downloaded quickly and which takes up little space. The script allows you to install in the Home or in the current directory and to choose between a basic installation (recommended) or a full installation. 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

<h2>Acknowledgments</h2>

Thanks to Luigi Scarso and Massimiliano Dominici for their availability. In particular, I would like to remind you that the initial installer code for Linux was written by Luigi Scarso.  I would also like to express my special thanks to Tommaso Gordini, who has tested both installers, and particularly the one for Windows.

Installation (Linux)
-------------------------------------

(1) Download the repository from GitHub. Unzip the folder and open a Terminal window.

(2) Move inside the downloaded folder (You can rename the folder if you prefer):

      cd path/to/nanoTeX-Master

(3) Run the installer:
    
      sh install-nanotex.sh

(4) Follow the instructions and make your choice!    

<h5>Basic installation</h5>

In the case of the basic installation, a list of packages will be installed which are considered essential for most users, omitting the sources but including the documentation. For the packages installed subsequently, also the documentation is omitted by default. This choice can be changed directly in the TLShell options or from the command line with:

    tlmgr option docfiles 0

<h5>Full installation</h5>

In the case of a full installation, everything will be installed, including documentation and package sources (also for future package installations). This installation, with the exception of the installation folder, is identical to the default one provided by TeX Live. 


Installation instructions (Windows) !Note that this installer is not optimized at all, even if it seems to work!
-------------------------------------

(1) Download the repository from GitHub. Unzip the folder and open a Command Prompt window. Powershell is required.

(2) Move inside the downloaded folder and double click on nanotex-install-windows.bat

(4) Follow the instructions and make your choice!

