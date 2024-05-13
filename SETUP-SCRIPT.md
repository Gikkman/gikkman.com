This assumes a DigitalOcean droplet, but it should work with most Linux distros

# Before setup
Create a SSH key on your **home computer** (if you don't have one)
```bash
ssh-keygen -t ed25519 -f ~/.ssh/gikkman-com
```
Copy the content of the `gikkman-com.pub`, and add it to DigitalOcean SSH keys.

For ease of use in the future, you can add this to `$HOME/.ssh/config` on your **home computer**.
```
Host gikkman.com
  HostName gikkman.com
  User ssh-user
  Port 32222
```

# Inital steps
All of these actions will be performed as the `root` user.

Begin with setting some default stuff for the root user:
```bash
echo "export EDITOR=vim" >> $HOME/.bashrc
echo "set number" >> $HOME/.vimrc
```

## Create a user
This creates a user that we later will use for SSH and managing the server. This will create the user, and give it sudo rights. When asking about name, job and stuff, you can just leave them blank.
```bash
NEW_USER="ssh-user"
SSH_KEY="<paste the content of gikkman-com.pub>"
adduser $NEW_USER
usermod -aG sudo $NEW_USER
```
Then we add the content of your `gikkman-com.pub` to our new user's `$HOME/.ssh/authorized_keys`
```bash
mkdir -P /home/$NEW_USER/.ssh
echo "$SSH_KEY" > /home/$NEW_USER/.ssh/authorized_keys
chown -R $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh
```

## Setup SSH
Some basic SSH setup. This will change the port, and disable all login methods except SSH keys.
```bash
vim /etc/ssh/sshd_config
```
Then make the following changes
* `Port` : `22 -> 32222`
* `UsePAM` : `yes -> no`
* `PasswordAuthentication` : `yes -> no`
* `PermitRootLogin` : `yes -> no`

Then restart the SSH service
```bash
systemctl restart ssh.service 
```

Confirm you can ssh into the server from your **home computer**:
```
ssh ssh-agent@<droplet-ip> -p 32222 -i ~/.ssh/gikkman-com
```

## Setup UFW
Setting up Universal Firewall to block all traffic except on our SSH port:
```bash
ufw allow 32222/tcp
ufw enable
```
