function musik --wraps='mpd && ncmpcpp' --wraps='mpd && ncmpcpp && killall mpd' --description 'alias musik=mpd && ncmpcpp && killall mpd'
  mpd && ncmpcpp && killall mpd $argv
        
end
