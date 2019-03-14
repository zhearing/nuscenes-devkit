sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.7

pip install virtualenvwrapper

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    VIRTUAL_ENV_LOCATION=/usr/local/bin/virtualenvwrapper.sh
elif [ -f ~/.local/bin/virtualenvwrapper.sh ]; then
    VIRTUAL_ENV_LOCATION=~/.local/bin/virtualenvwrapper.sh
else
    echo "virtualenvwrapper.sh not found"
fi

if [ -f ~/.bashrc ]; then
    BASH_PROFILE=~/.bashrc
elif [ -f ~/.bash_profile ]; then
    BASH_PROFILE=~/.bash_profile
fi

grep -qxF "export WORKON_HOME=$HOME/.virtualenvs" $BASH_PROFILE || \
echo "export WORKON_HOME=$HOME/.virtualenvs" >> $BASH_PROFILE

grep -qxF "source $VIRTUAL_ENV_LOCATION" $BASH_PROFILE || \
echo "source $VIRTUAL_ENV_LOCATION" >> $BASH_PROFILE

source $BASH_PROFILE
source $VIRTUAL_ENV_LOCATION

mkvirtualenv nuscenes --python=python3.7
workon nuscenes

POSTACTIVATE=~/.virtualenvs/nuscenes/bin/postactivate

pip install -r requirements.txt

grep -qxF "export PYTHONPATH=\"${PYTHONPATH}:${PWD}/python-sdk\"" $POSTACTIVATE || \
echo "export PYTHONPATH=\"${PYTHONPATH}:${PWD}/python-sdk\"" >> $POSTACTIVATE

grep -qxF "export NUSCENES\"/data/sets/nuscenes/\"" $POSTACTIVATE || \
echo "export NUSCENES=\"/data/sets/nuscenes/\"" >> $POSTACTIVATE
