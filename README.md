<p><a href="https://github.com/ivalb/FasTeX"><img src="https://github.com/ivalb/FasTeX/blob/master/fastex-icon.svg" alt="FasTeX logo" align="right" width="300px" style="max-width:100%;"></a></p>

A custom installer for TeX Live - Beta version for testing only
--------------------------------

FasTeX is a custom installer for TeX Live distribution. Its purpose is to provide a minimal TeX Live distribution, which can be downloaded quickly and which takes up little space. The script installs the TeX Live infrastructure only and a series of packages that are considered basic for each user. Furthermore, during installation the user can decide whether to install lists of particular packages, according to his needs. For example, a humanist might want to install packages to write in Greek, while a mathematician will need some classic mathematic packages. 
The installation omits downloading the documentation and the sources of the packages, which take up a lot of space and which are often never consulted. However, it is always possible to install individual packages later, using the TeX Live Manager program. 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Acknowledgments
-------------------------------------
Thanks to Luigi Scarso and Massimiliano Dominici for their availability. In particular, I would like to remind you that the initial installer code for Linux was written by Luigi Scarso.  I would also like to express my special thanks to Tommaso Gordini, who has tested both installers, and particularly the one for Windows.

Installation instructions (Linux)
-------------------------------------

(1) Download the repository from GitHub. Unzip the folder and open a Terminal window.

(2) Move inside the downloaded folder (You can rename the folder if you prefer):

      cd path/to/FasTeX-Master

(3) Run the installer:
    
      sh isntall-fastex.sh

(4) Follow the instructions and make your choice!
    

Installation instructions (Windows) !Note that this installer is not optimized at all, even if it seems to work!
-------------------------------------

(1) Download the repository from GitHub. Unzip the folder and open a Command Prompt window. Powershell is required.

(2) Move inside the downloaded folder and double click on fastax-install-windows.bat

(4) Follow the instructions and make your choice!

