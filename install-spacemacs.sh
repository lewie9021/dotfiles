# Setup and download the relevant files.
cp .spacemacs ~/.spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# Run Emacs to trigger the Spacemacs installation.
emacs --insecure

# Install dependencies for the JavaScript layer.
sudo npm install tern jshint -g
