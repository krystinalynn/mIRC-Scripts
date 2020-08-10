on *:LOAD: { 
  window -ke @ChanMan
  echo -t @ChanMan WHOIS Channel Manager • Version 2.1
  echo -t @ChanMan By: QueenElsa
  echo -t @ChanMan Special thanks to: Entropy, for his critical role in bringing this back to life.
  echo @ChanMan -------------------------------------------------------------------------------------------------------------
  echo -t @ChanMan Commands List
  echo -t @ChanMan /chanman add <bad|good|network|secret|watch> <#channel> - Adds the specified channel to the given list. 
  echo -t @ChanMan /chanman del <bad|good|network|secret|watch> - Opens notepad allowing you to manually remove channels.
  echo -t @ChanMan Have fun! 
  echo -t @ChanMan 7It is now safe to close this window. ;) 
}

menu channel { 
  Channel Manager
  .Add
  ..Bad: { /write BadChan.txt $chan | echo -ta *** Channel Manager: $chan has been added to the bad channels list. }
  ..Good: { /write GoodChan.txt $chan | echo -ta *** Channel Manager: $chan has been added to the good channels list. } 
  ..Network: { /write NetworkChan.txt $chan | echo -ta *** Channel Manager: $chan has been added to the network channels list. }
  ..Secret: { /write SecretChan.txt $chan | echo -ta *** Channel Manager: $chan has been added to the secret channels list. }
  ..Watch: { /write WatchChan.txt $chan | echo -ta *** Channel Manager: $chan has been added to the watched channels list. }
}

alias chanman { 
  if (!$1) { echo -ta *** Syntax: /chanman <add|del|list> [params] } 
  if ($1 == add) { 
    if (!$2) { echo -ta *** Syntax: /chanman add <bad|good|network|secret|watch> <#channel> } 
    if (($2 == bad) || ($2 == b)) { /write BadChan.txt $3 | echo -ta *** Channel Manager: $3 has been added to the bad channels list. } 
    if (($2 == good) || ($2 == g)) { /write GoodChan.txt $3 | echo -ta *** Channel Manager: $3 has been added to the good channels list. } 
    if (($2 == network) || ($2 == n)) { /write NetworkChan.txt $3 | echo -ta *** Channel Manager: $3 has been added to the network channels list. } 
    if (($2 == secret) || ($2 == s)) { /write SecretChan.txt $3 | echo -ta *** Channel Manager: $3 has been added to the secret channels list. } 
    if (($2 == watch) || ($2 == w)) { /write WatchChan.txt $3 | echo -ta *** Channel Manager: $3 has been added to the watched channels list. } 
  }
  if ($1 == del) { 
    if (!$2) { echo -ta *** Syntax: /chanman del <bad|good|network|secret|watch> | echo -ta *** Note: You must manually delete the channel(s) from the file. } 
    if (($2 == bad) || ($2 == b)) { echo -ta *** Channel Manager: Opening bad channels list. Delete the bad channel(s) and save the file. | /run Notepad.exe BadChan.txt }
    if (($2 == good) || ($2 == g)) { echo -ta *** Channel Manager: Opening good channels list. Delete the good channel(s) and save the file. | /run Notepad.exe GoodChan.txt } 
    if (($2 == network) || ($2 == n)) { echo -ta *** Channel Manager: Opening network channels list. Delete the network channel(s) and save the file. | /run Notepad.exe NetworkChan.txt }
    if (($2 == secret) || ($2 == s)) { echo -ta *** Channel Manager: Opening secret channels list. Delete the secret channel(s) and save the file. | /run Notepad.exe SecretChan.txt } 
    if (($2 == watch) || ($2 == w)) { echo -ta *** Channel Manager: Opening watch channels list. Delete the watch channel(s) and save the file. | /run Notepad.exe WatchChan.txt }
  }
}

RAW 301:*: { 
  if ($network == UnderNet) { 
    haltdef 
    .timerisaway -om 1 150 echo -at * $2 is away: $3- 
  }
}

RAW 311:*: { 
  if ($network == UnderNet) { 
    haltdef
    .timerhostmask -om 1 150 echo -at * $2 is $2 $+ ! $+ $3 $+ @ $+ $4 $5 $6-  }
}

RAW 312:*: { 
  if ($network == UnderNet) { 
    haltdef
    if ($3 == $server) { .timerisonserver -om 1 150 echo -at * $2 is using: $3 $4- [You are on the same server as $2] } 
    else { 
      .timerisonserver -om 1 150 echo -at * $2 using: $3 $4-
    }
  }
}

RAW 313:*: { 
  if ($network == UnderNet) { 
    haltdef
    .timeroper -om 1 150 echo -at * $2 $3-
  }
}

RAW 317:*: { 
  if ($network == UnderNet) { 
    haltdef 
    .timeridlesignon -om 1 150 echo -at * $2 has been idle: $duration($3) $+ , signed on: $duration($calc($ctime - $4))
  } 
}

RAW 330:*: { 
  if ($network == UnderNet) { 
    haltdef 
    .timerloggedin -om 1 150 echo -at * $2 is logged in as: $3
  }
}

RAW 338:*: { 
  if ($network == UnderNet) { 
    haltdef
    .timerisactually -om 1 150 echo -at * $2 is actually: $3
  }
}

; WHOIS CHANNELS - by entropy 2020
RAW 319:*: { 
  if ($network == UnderNet) {

    set -u3 %cm_319 %cm_319 $remove($3-,+,%,@,&,~,!,?)

    var %cm_nick $2
    var %cm_gc 1
    var %cm_bc 1
    var %cm_nc 1
    var %cm_sc 1
    var %cm_wc 1
    var %whois_bc
    var %whois_gc
    var %whois_nc
    var %whois_sc
    var %whois_wc

    while ($gettok(%cm_319, %cm_gc, 32) != $null) {
      if ($read(GoodChan.txt, wn, $v1)) { 
        var %b = $v1
        if (!$istok(%whois_gc,%b,32)) { %whois_gc = %whois_gc %b }
      }
      inc %cm_gc
    }
    while ($gettok(%cm_319, %cm_bc, 32) != $null) { 
      if ($read(BadChan.txt, wn, $v1)) { 
        var %b = $v1
        if (!$istok(%whois_bc,%b,32)) { %whois_bc = %whois_bc %b }
      }
      inc %cm_bc
    }
    while ($gettok(%cm_319, %cm_nc, 32) != $null) { 
      if ($read(NetworkChan.txt, wn, $v1)) { 
        var %b = $v1
        if (!$istok(%whois_nc,%b,32)) { %whois_nc = %whois_nc %b }

      }
      inc %cm_nc
    }
    while ($gettok(%cm_319, %cm_sc, 32) != $null) { 
      if ($read(SecretChan.txt, wn, $v1)) { 
        var %b = $v1
        if (!$istok(%whois_sc,%b,32)) { %whois_sc = %whois_sc %b }
      }
      inc %cm_sc
    }
    while ($gettok(%cm_319, %cm_wc, 32) != $null) { 
      if ($read(WatchChan.txt, wn, $v1)) { 
        var %b = $v1
        if (!$istok(%whois_wc,%b,32)) { %whois_wc = %whois_wc %b }
      }
      inc %cm_wc
    }
    if (%whois_bc == $null) { var %whois_bc none } 
    if (%whois_gc == $null) { var %whois_gc none } 
    if (%whois_nc == $null) { var %whois_nc none } 
    if (%whois_sc == $null) { var %whois_sc none } 
    if (%whois_wc == $null) { var %whois_wc none }
    .timeronchans -om 1 250 echo -at * $2 is on: $eval(%cm_319,0)
    .timeronbc -om 1 250 echo -at * %cm_nick is on bad channels:4 $unsafe( %whois_bc )
    .timerongc -om 1 250 echo -at * %cm_nick is on good channels:3 $unsafe( %whois_gc )
    .timeronnc -om 1 250 echo -at * %cm_nick is on network channels:6 $unsafe( %whois_nc )
    .timeronsc -om 1 250 echo -at * %cm_nick is on secret channels:14 $unsafe( %whois_sc )
    .timeronwc -om 1 250 echo -at * %cm_nick is on watchlist channels:7 $unsafe( %whois_wc )
    halt
  }
}

RAW 318:*: { 
  if ($network == UnderNet) { 
    haltdef 
    .timerendofwhois -om 1 350 echo -at * End of $2 /WHOIS list.
  }
}
