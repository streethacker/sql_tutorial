#! /bin/bash

# What this script does?

#############################################
# +-------+     ssh tunnel       +-------+  #
# |       |----------------------|       |  #
# |client |    mysql connection  | vps   |  #
# |       |----------------------|       |  #
# +-------+                      +-------+  #
#############################################

# Pay attention to the comments start with keyword **Caution**


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RST='\033[0m'

is_ready_homebrew()
{
    # Validate Homebrew installation
    command -v brew >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}Homebrew not found, trying to install Homebrew...${RST}"
        # Not installed? Try install it
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        # Re-validate Homebrew installation
        command -v brew >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "${RED}fail to install Homebrew!${RST}"
            return 1
        fi
    fi
    return 0
}

is_ready_ssh_copy_id()
{
    # Validate ssh-copy-id installation
    command -v ssh-copy-id >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}ssh-copy-id not found, trying to install ssh-copy-id...${RST}"
        # Not installed? Install ssh-copy-id using homebrew
        brew install ssh-copy-id
        # Re-validate ssh-copy-id installation
        command -v ssh-copy-id >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "${RED}fail to install ssh-copy-id!${RST}"
            return 1
        fi
    fi
    return 0
}

is_ready_mycli()
{
    command -v mycli >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}mycli not found, trying to install mycli...${RST}"
        brew install mycli
        command -v mycli >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "${RED}fail to install mycli!${RST}"
            return 1
        fi
    fi
    return 0
}

ssh_key_gen()
{
    # Return success if RSA Pub/Private keys prepared
    if [ -f ~/.ssh/sql_learn/id_rsa ] && [ -f ~/.ssh/sql_learn/id_rsa.pub ]; then
        echo -e "${YELLOW}rsa key pairs already exists!${RST}"
        return 0
    fi
    # Backup the ssh key files, if exists
    if [ -d ~/.ssh ]; then
        cp -R ~/.ssh /tmp/ssh_key_backup
        if [ ! -d /tmp/ssh_key_backup ]; then
            echo -e "${RED}fail to backup ssh key files, as a result, no ssh keys would be generated!${RST}"
            return 1
        fi
    fi
    # Generate new ssh key files
    mkdir -p ~/.ssh/sql_learn
    ssh-keygen -t rsa -C "tom@mail.com" -f ~/.ssh/sql_learn/id_rsa -P ""        # Caution: replace tom@mail.com to your own email address
    # Validate the success of generation
    if [ ! -f ~/.ssh/sql_learn/id_rsa ] || [ ! -f ~/.ssh/sql_learn/id_rsa.pub ]; then
        echo -e "${RED}fail to generate ssh keys!${RST}"
        return 1
    fi
    return 0
}

copy_pubkey_to_server()
{
    # Validate existence of ~/.ssh/sql_learn/id_rsa.pub
    if [ ! -f ~/.ssh/sql_learn/id_rsa.pub ]; then
        echo -e "${RED}pub key not found in ~/.ssh/sql_learn/id_rsa.pub, as a result, no pub key would be copy to server${RST}"
        return 1
    fi
    # Copy pub key to remote server
    ssh-copy-id -i ~/.ssh/sql_learn/id_rsa.pub tom@remote_ip        # Caution: replace tom to your username and remote_ip to your vps IP
    # Validate ssh-copy-id success
    scp -i ~/.ssh/sql_learn/id_rsa tom@remote_ip:tom_home/.ssh/authorized_keys /tmp/authorized_keys   # Caution: replace tom to your username and remote_id to your vps IP, tom_home is tom's home directory on the vps
    if [ ! -f /tmp/authorized_keys ]; then
        echo -e "${RED}fail to copy pub key to the server!${RST}"
        return 1
    fi
    # Clear local authorized_keys
    rm -rf /tmp/authorized_keys
    return 0
}

one_click_install()
{
    is_ready_homebrew
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Homebrew installed!${RST}"
    fi
    is_ready_ssh_copy_id
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}ssh-copy-id installed!${RST}"
    fi
    is_ready_mycli
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}mycli installed!${RST}"
    fi
    ssh_key_gen
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}pub/private keys generated!${RST}"
    fi
    copy_pubkey_to_server
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}pub key copied to remote server!${RST}"
    fi
}

before_start_tunnel()
{
    local flag=0
    for cmd in brew ssh-copy-id mycli; do
        command -v ${cmd} >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "${RED}${cmd} is required, but not found!${RST}"
            ((flag++))
        fi
    done
    if [ ${flag} -gt 0 ]; then
        echo -e "${RED}requirements not found, try run one_click_install to fix this!${RST}"
        return 1
    fi
    return 0
}

start_ssh_tunnel()
{
    if [ ! $(ps -ef | awk '/[s]sh -C -f/{print $2}') ]; then
        before_start_tunnel
        if [ $? -ne 0 ]; then
            echo -e "${RED}requirements validation failed!${RST}"
            echo -e "${RED}exit!${RST}"
            return 1
        fi
        echo -e "all prepared! initializing connection to remote server..."
        # Caution: replace the following mysql_port to your mysql server's listen port(default 3306), replace tom to your username and remote_id to your vps IP
        ssh -C -f -N -g -M -S /tmp/ssh-tunnel-session -L 3309:127.0.0.1:mysql_port tom@remote_ip -i ~/.ssh/sql_learn/id_rsa 
        if [ ! $(ps -ef | awk '/[s]sh -C -f/{print $2}') ]; then
            echo -e "${RED}fail to initialize connection!${RST}"
            echo -e "${RED}exit!${RST}"
            return 1
        fi
    fi
    echo -e "${GREEN}connection initialized!${RST}"
    return 0
}

close_ssh_tunnel()
{
    echo -e "closing connection..."
    if [ -f /tmp/ssh-tunnel-session ]; then
        ssh -S /tmp/ssh-tunnel-session -O exit tom@remote_ip  # Caution: replace tom to your username and remote_id to your vps IP
    fi
    sleep 1s
    if [ $(ps -ef | awk '/[s]sh -C -f/{print $2}') ]; then
        ps -ef | awk '/[s]sh -C -f/{print $2}' | xargs -I {} sudo kill -9 {}
    fi
    sleep 3s
    if [ ! $(ps -ef | awk '/[s]sh -C -f/{print $2}') ]; then
        rm -rf /tmp/ssh-tunnel-session
        echo -e "${GREEN}connection closed${RST}"
    else
        echo -e "${RED}fail to close connection, try run close_ssh_tunnel again!${RST}"
        echo -e "${RED}exit!${RST}"
        return 1
    fi
    return 0
}

connectTo()
{
    start_ssh_tunnel
    if [ $? -eq 0 ]; then
        # Caution: replace the following mysql_login_user/mysql_login_passport according to your mysql server's login account
        mycli -u mysql_login_user -p mysql_login_passport -h 127.0.0.1 -P 3309
        close_ssh_tunnel
    fi
}
