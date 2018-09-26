;Simple X command script 
;by: QueenElsa

;To install, open mIRC. At the top of the screen, click on Tools > Script Editor.
;Then click on the Remotes tab. After that, click on File > New.
;Copy and paste this script into the script editor. Then click the OK button.

;To use this script, right click in a blank area of the channel for channel settings.
;To use this script on a user, right click on the nick you wish to target.

menu channel { 
  X
  .Op myself: { .msg x@channels.undernet.org op $chan $me } 
  .Deop myself: { .msg x@channels.undernet.org deop $chan $me } 
  .Set the topic: { .msg x@channels.undernet.org topic $chan $$?="What should the new topic be?" }
}

menu nicklist { 
  X
  .Kick $$1: { .msg x@channels.undernet.org kick $chan $$1 $$?="Why are you kicking $$1 $+ ?" }
  .Ban $$1: { .msg x@channels.undernet.org ban $chan $$1 $$?="How long will $$1 be banned for?" 100 $$?="Why are you banning $$1 $+ ?" }
  .Voice $$1: { .msg x@channels.undernet.org voice $chan $$1 } 
  .Devoice $$1: { .msg x@channels.undernet.org devoice $chan $$1 } 
}
