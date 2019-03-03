source /etc/profile
source /root/.aws-ps1.sh
source /root/.kube-ps1.sh
source /root/.aws-reauth.sh

#Shell Command Completion
complete -C '/usr/bin/aws_completer' aws
source <(kubectl completion bash)

#AWS Reauth Function
function reauth () {
    eval $(_aws_reauth)
}

#Kube-PS1 Cluster Parsing Function
function _kube_ps1_parse_cluster () {
    if [[ $1 == arn* ]]; then
        echo $1 | cut -d / -f2
    else
        echo $1
    fi
}

#Kube-PS1 Overrides
KUBE_PS1_PREFIX='[ '
KUBE_PS1_SUFFIX=' ]'
KUBE_PS1_CTX_COLOR='blue'
KUBE_PS1_SYMBOL_ENABLE='false'
KUBE_PS1_DIVIDER=' : '
KUBE_PS1_CLUSTER_FUNCTION=_kube_ps1_parse_cluster

#Prompt
PS1='$(_aws_token_prompt)$(kube_ps1)\n\001\033[01;34m\002\w\001\033[00m\002\$ '

#Aliases
alias k='kubectl'
alias kctx='kubectx'
alias kns='kubens'