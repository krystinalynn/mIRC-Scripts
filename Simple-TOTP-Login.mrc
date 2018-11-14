/undernet { 
  set %loc_un YOUR_USERNAME
  set %loc_pw YOUR_PASSWORD
  if (!$1) { /server -m ix.undernet.org 6667 +x! %loc_un loc_pw $?="What is your TOTP code?" }
  else { /server -m ix.undernet.org 6667 +x! %loc_un %loc_pw $1 }
  unset %loc* 
}
