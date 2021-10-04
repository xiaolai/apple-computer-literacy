#!/bin/zsh
# This script wasn't tested yet.

softwareupdate --install-rosetta

arch -x86_64 brew install miniconda

conda init "$(basename "${SHELL}")"

source $HOME/.zshrc

conda create -n jupyter python ipython jupyterlab nodejs

conda activate jupyter

touch $HOME/./jupyter/jupyter_lab_config.py
cat <<EOF > $HOME/./jupyter/jupyter_lab_config.py
c.LabApp.open_browser = False
c.ServerApp.open_browser = False
c.ServerApp.password_required = False
c.ServerApp.allow_remote_access = False
c.ServerApp.root_dir = '~/'
c.ServerApp.token = ''
EOF

touch $(brew --prefix)/bin/jupyterservice
cat <<EOF > $(brew --prefix)/bin/jupyterservice
#!/bin/zsh
PATH="$(brew --prefix)/Caskroom/miniconda/base/bin:$PATH"
eval "$(conda 'shell.zsh' hook)"
conda activate jupyter
cd $HOME
$(brew --prefix)/Caskroom/miniconda/base/envs/jupyter/bin/python -m jupyter lab
EOF

chmod +x /opt/homebrew/bin/jupyterservice

touch $HOME/Library/LaunchAgents/com.jupyter.lab.plist
cat <<EOF >$HOME/Library/LaunchAgents/com.jupyter.lab.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>local.job</string>
	<key>ProgramArguments</key>
	<array>
		<string>/opt/homebrew/bin/jupyterservice</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>StandardErrorPath</key>
	<string>/tmp/local.job.err</string>
	<key>StandardOutPath</key>
	<string>/tmp/local.job.out</string>
</dict>
</plist>
EOF

launchctl load $HOME/Library/LaunchAgents/com.jupyter.lab.plist

cat <<EOF >> $HOME/Library/LaunchAgents/com.jupyter.lab.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>local.job</string>
	<key>ProgramArguments</key>
	<array>
		<string>/opt/homebrew/bin/jupyterservice</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>StandardErrorPath</key>
	<string>/tmp/local.job.err</string>
	<key>StandardOutPath</key>
	<string>/tmp/local.job.out</string>
</dict>
</plist>
EOF

cat <<EOF >> $HOME/.zshrc
# for jupyter
alias jpu="launchctl unload ~/Library/LaunchAgents/com.jupyter.lab.plist"
alias jpl="launchctl load ~/Library/LaunchAgents/com.jupyter.lab.plist"
alias jpr="jpu && jpl"
EOF

npm install nativefier -g 
cd ~/Applications
nativefier "http://localhost:8888" -n Jupyterlab -i https://github.com/xiaolai/apple-computer-literacy/raw/main/images/jupyterlab-app-icon.png

open /Applications/Jupyterlab.app
