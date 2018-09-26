/*
AutoJoin Script for Undernet IRC Network
By QueenElsa                Version: 1.9
*/

;USAGE: Load this script into a blank new remotes file on your client.
;Script uses X's autoinvites for it's primary function. There are no 
;options to configure within this script. Everything is done through X.
;It may be expanded to include other bots and services, as this script
;is not complicated. 

;STAFF NOTE: If you're an Undernet Staff Member, a special version of 
;this script exists and may be available to you. Contact QueenElsa for 
;more information. 

on *:CONNECT:{ 
  if (!$window(@InviteMgmt)) { window -ike @InviteMgmt } 
}
on *:INVITE:*: { 
  if (!$network = UnderNet) { halt } 
  else { 
    if ($address($nick,2) == *!*@undernet.org) { 
      /join $chan
      echo -ke @InviteMgmt 9,3Trusted A network service invited you to join $chan $+ . Invite auto-accepted. 
      halt
    }
    else {
      echo -ke @InviteMgmt 4,5Unknown $nick invited you to join $chan $+ . Invited rejected. 
      halt
    }
  }
}
menu channel { 
  .X AutoInvite
  .. ON: { /msg X@channels.undernet.org modinfo $chan invite ON } 
  .. OFF: { /msg X@channels.undernet.org modinfo $chan invite OFF } 
} 
