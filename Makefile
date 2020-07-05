config:
	echo "Initial setting to run setup.."
	echo "prepare ansible"	
	echo "pip install --user -r ../ansible/requirements.txt"

setup:
	brew install tmux
 	brew install fzf
 	brew install tldr 
 	brew install ccat 
	$(brew --prefix)/opt/fzf/install

