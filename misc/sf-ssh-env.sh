#!/bin/bash
echo "Set alias for sailfish emulator/ mers ssh login"
echo "see sf-ssh*"

alias sf-ssh-engine-mersdk='ssh -p 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/engine/mersdk mersdk@localhost' 
alias sf-ssh-engine-root='ssh -p 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/engine/root root@localhost' 
alias sf-ssh-emulator-root='ssh -p 2223 -i ~/SailfishOS/vmshare/ssh/private_keys/SailfishOS_Emulator/root root@localhost'
alias sf-ssh-emulator-nemo='ssh -p 2223 -i ~/SailfishOS/vmshare/ssh/private_keys/SailfishOS_Emulator/nemo nemo@localhost'