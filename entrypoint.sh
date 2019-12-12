#!/bin/bash 

set -x

export user=${user:-$UID}
export group=${group:-$user}
export name=${name:-user}

export shell=${shell:-bash}

export ARGS=${@:-${shell}}

export QT_X11_NO_MITSHM=1

echo ARGS: $ARGS

if (( user != 0 )); then
    export HOME=/home/${name}
    export workdir=${workdir:-${HOME}}

    MKHOME=$([[ -d ${HOME} ]] && echo "" || echo "-m" )

    sudo useradd -d ${HOME} -U ${MKHOME} -u ${user} ${name}
    SUDO="-u $name"
fi

sudo ${SUDO} -i bash -c "export QT_X11_NO_MITSHM=1 && cd ${workdir} && ${ARGS}"




