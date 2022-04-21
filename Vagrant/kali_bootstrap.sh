#!/bin/zsh

echo 'Updating system ...'
 apt update -y &&  apt upgrade -y

echo 'Installing additional tools via apt ...'
 apt install seclists -y
 apt install python3-impacket -y
 apt install flameshot -y
 apt install golang -y
 apt install gowitness -y
 apt install gobuster -y
 apt install eyewitness -y
 apt install terminator -y
 apt install cupp -y
 apt install trufflehog -y
 apt install bloodhound -y
 apt install exiftool -y
### run the following to initialize bloodhound ###
# neo4j console
### use a browser to access the neo4j console at http://localhost:7474, default login is neo4j:neo4j. Change password to something else. ###
### kill neo4j console and start bloodhound. ###

echo 'Downloading additional tools from github. They will be placed in /opt or in /home/$USERNAME/go/bin/ if they are a go package...'
 git clone https://github.com/carlospolop/PEASS-ng /opt/privesc/peass-ng
 git clone https://github.com/r3nt0n/bopscrk /opt/password_generation/bopscrk
 git clone https://github.com/initstring/cloud_enum /opt/OSINT/cloud/cloud_enum 
 git clone https://github.com/fox-it/BloodHound.py /opt/bloodhound
 go install github.com/ropnop/kerbrute@latest
#echo 'Creating symlinks for the github programs, the symlinks will be placed in /usr/local/bin ...'
# ln -s /opt/password_generation/bopscrk /usr/local/bin/bopscrk
# ln -s /opt/OSINT/cloud/cloud_enum /usr/local/bin/cloud_enum
echo 'Adding user go binary directory (/home/$USER/go/bin/)to PATH ...'
export PATH="/home/$USER/go/bin/:$PATH"

### install VNC server for connecting to kali over SSH ###
#  apt-get install vncserver
#  apt install xfce4 xfce4-goodies tightvncserver

echo 'Extracting rockyou gz...'
 gunzip /usr/share/wordlists/rockyou.txt.gz

echo 'Setting up database for metasploit ...'
systemctl start postgresql
msfdb init

# Generate random password
PASSWD=$(date --date="@313370$RANDOM" | md5sum | head -c 20)
echo "Changing the vagrant user's password to: $PASSWD"
echo -e "$PASSWD\n$PASSWD" | passwd vagrant

echo 'System ready!'
