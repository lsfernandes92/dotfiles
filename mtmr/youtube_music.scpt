if application "Google Chrome" is running then
  tell application "Google Chrome"
      set youtubeTab to missing value
      -- Check if YouTube Music is open in any tab
      repeat with aWindow in windows
          repeat with aTab in tabs of aWindow
              if URL of aTab contains "music.youtube.com" then
                  set youtubeTab to aTab
                  exit repeat
              end if
          end repeat
          if youtubeTab is not missing value then exit repeat
      end repeat

      -- If YouTube Music tab is found, get the title
      if youtubeTab is not missing value then
          set tabTitle to name of youtubeTab
          -- Return track and artist by extracting from the tab title
         if tabTitle contains " - YouTube Music" then
            set AppleScript's text item delimiters to " - YouTube Music"
            set trackInfo to text item 1 of tabTitle

            return trackInfo
          else
              return "No track playing"
          end if
      else
          return "YouTube Music tab not found"
      end if
  end tell
else
  return "Google Chrome is not running"
end if
