export APP_NAME=mage

if
  [ -f /usr/src/app/package.json ]
then
  export APP_NAME="$(node -e "console.log(require('/usr/src/app/package.json').name)")"
fi

export PS1="\[$(tput setaf 4)\]\h \[$(tput setaf 2)\]${APP_NAME} \[$(tput setaf 5)\](${NODE_ENV}) \[$(tput sgr0)\]\$ "
