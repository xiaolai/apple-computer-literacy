#!/bin/zsh
PACAGES="git wget tree mas appcleaner onyx cleanmymac bettertouchtool alfred blackhole-64ch sublime-text visual-studio-code typora google-chrome firefox microsoft-edge brave-browser opera tor-browser surge android-studio audacity baidunetdisk calibre dropbox keka microsoft-remote-desktop miniconda obs openaudible sketch skitch spotify thunder transmission vlc webcatalog wechat"

for p in $PACAGES; do
	if (echo $(brew list)  | fgrep -q $p); then
		echo "$p has already installed."
	else
		brew install $p
		# echo "$p installed successfully."
	fi
done;

