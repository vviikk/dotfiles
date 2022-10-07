#!/bin/bash

# cd into this folder
cd ~/dotfiles/bootstrap/macos

# Jason Rudolph's Keyboard 
# check if ~/.keyboard directory exists
if [[ -d ~/.keyboard ]]; then
	echo "Jason Rudolph's Keyboard exists"
else
	git clone https://github.com/jasonrudolph/keyboard.git ~/.keyboard
	cd ~/.keyboard
	script/setup
fi

# Check if Brewfile exists
if [[ -f Brewfile ]]; then
	echo "Brewfile exists... provisioning"
	# Install all brew bundles
	brew bundle
	# For FirefoxPWA
	sudo mkdir -p "/Library/Application Support/Mozilla/NativeMessagingHosts"
  sudo ln -sf "/opt/homebrew/opt/firefoxpwa/share/firefoxpwa.json" "/Library/Application Support/Mozilla/NativeMessagingHosts/firefoxpwa.json"

	# Setup ZSH & Starship
	pushd ~/dotfiles
	stow zsh
	curl -sS https://starship.rs/install.sh | sh
	cd antibody && ./install.sh
	popd
else
	echo "Brewfile not found"
fi

# # Neovim / Spaceneovim
# # brew install neovim && \                     
# # sudo pip3 install neovim && \
# # sudo pip3 install --upgrade neovim && \
# # ../nvim/install-spaceneovim.sh

# Remove Apple Nonsense from dock
# brew install --cask hpedrorodrigues/tools/dockutil
dockutil --remove Launchpad
dockutil --remove Safari
dockutil --remove Mail
dockutil --remove Contacts
dockutil --remove Calendar
dockutil --remove Notes
dockutil --remove Reminders
dockutil --remove Maps
dockutil --remove Photos
dockutil --remove Messages
dockutil --remove FaceTime
dockutil --remove Pages
dockutil --remove Numbers
dockutil --remove Keynote
dockutil --remove Music
dockutil --remove News
dockutil --remove Podcasts
dockutil --remove "App Store"

# Enable key repeat on vscode & vscode insiders for Vscodevim
defaults delete com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
defaults delete com.microsoft.VSCode ApplePressAndHoldEnabled
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Remove date from MacOS Menubar as I use ItsyCal
defaults write com.apple.menuextra.clock IsAnalog -bool true

# Stop Chrome asking every time to open 3rd party links
defaults write com.google.Chrome ExternalProtocolDialogShowAlwaysOpenCheckbox -bool true

# Enable AAC codec for bluetooth audio
sudo defaults write bluetoothaudiod "Enable AAC codec" -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Check for software updates daily, not just once per week (Only for use on my personal machine)
# defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Madrid" > /dev/null

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the Pictures/Screenshots
mkdir -p ${HOME}/Pictures/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# Bottom right screen corner → Start screen saver
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0
