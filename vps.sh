#!/bin/bash
function update () {
        apt update
        apt upgrade -y
        apt install nano -y
        apt install bash-completion -y
        apt install python3-certbot-apache -y
        apt install git -y
        apt install build-essential -y
        apt install nano -y
		apt install software-properties-common
        apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
		add-apt-repository "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.liquidtelecom.com/repo/10.4/ubuntu $(lsb_release -cs) main"
		apt update
		aliases
}

cd
bashrc=".bashrc"

function aliases () {
        if grep -q "alias agu='apt update'" "$bashrc"; then

                echo "already added alias"

        else

                echo "alias agu='apt update'" >> $HOME/.bashrc
                echo "alias added"
        fi

        if grep -q "alias agup='apt upgrade -y'" "$bashrc"; then

                echo "already added alias"

        else

                echo "alias agup='apt upgrade -y'" >> $HOME/.bashrc
                echo "alias 2 added"
        fi
        hosts
}
#echo "alias agu='apt update'" >> $HOME/.bashrc
#echo "alias agup='apt upgrade -y'" >> $HOME/.bashrc

function hosts () {
tee -a ./sethost.sh > /dev/null <<EOT
#!/bin/bash
hostnamectl set-hostname kodiblog.de
EOT

chmod +x ./sethost.sh
chown root:root ./sethost.sh
crontab -l > bootup
echo "@reboot sh /root/sethost.sh" >> bootup
crontab bootup
rm bootup

#echo ""
#echo ""

#echo "INSTALL PLESK?"
#read installquery
#if "$installquery" = "y"; then
#	cd
#	wget https://autoinstall.plesk.com/plesk-installer
#	chmod +x ./plesk-installer
#	./
final
}

function final (){

echo "All functions executed. Rebooting in 10 seconds."
sleep 10
reboot

}
update
