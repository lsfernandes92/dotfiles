# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Good reference site:
# https://macos-defaults.com/
#
# Run ./set-defaults.sh and you'll be good to go.

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################
sudo nvram SystemAudioVolume=" "
defaults write NSGlobalDomain AppleInterfaceStyle Dark
# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

###############################################################################
# Energy saving                                                               #
###############################################################################

# Sleep the display after 15 minutes
sudo pmset -a displaysleep 15

# Disable machine sleep while charging
sudo pmset -c sleep 0

# Set machine sleep to 5 minutes on battery
sudo pmset -b sleep 5

###############################################################################
# Dock                                                                        #
###############################################################################
defaults write com.apple.dock "tilesize" -int "33"
defaults write com.apple.dock "orientation" -string "bottom"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-time-modifier" -float "0" 
defaults write com.apple.dock "show-recentss" -bool "false"
defaults write com.apple.dock "mineffect" -string "scale"
defaults write com.apple.dock "static-only" -bool "true"

###############################################################################
# Screenshots                                                                 #
###############################################################################
defaults write com.apple.screencapture "disable-shadow" -bool "true"
defaults write com.apple.screencapture "include-date" -bool "false" 
defaults write com.apple.screencapture "location" -string "~/Desktop"
defaults write com.apple.screencapture "show-thumbnail" -bool "true"
defaults write com.apple.screencapture "type" -string "png"

###############################################################################
# Finder                                                                      #
###############################################################################
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1"

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Desktop                                                                     #
###############################################################################
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"
defaults write com.apple.finder "CreateDesktop" -bool "true"

###############################################################################
# Menu bar                                                                    #
###############################################################################
defaults write com.apple.menuextra.clock "FlashDateSeparators" -bool "false"
defaults write com.apple.menuextra.clock "ShowDate" -bool "false"
defaults write com.apple.menuextra.clock "ShowAMPM" -bool "true"
defaults write com.apple.menuextra.clock "ShowDayOfWeek" -bool "true"

###############################################################################
# Mouse                                                                       #
###############################################################################
defaults write NSGlobalDomain com.apple.mouse.linear -bool "true"
defaults write NSGlobalDomain com.apple.mouse.scaling -float "2"
defaults write com.apple.Terminal "FocusFollowsMouse" -bool "false"

###############################################################################
# Trackpad                                                                    #
###############################################################################
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "1"
defaults write com.apple.AppleMultitouchTrackpad "DragLock" -bool "true"
defaults write com.apple.AppleMultitouchTrackpad "Dragging" -bool "false"
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################
for app in "Dock" \
  "SystemUIServer" \
  "Terminal"\
	"Finder"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."