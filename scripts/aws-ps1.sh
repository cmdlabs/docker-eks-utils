# Functions
function _aws_token_expiration () {
    if [ $AWS_EXPIRATION ]; then
        AWS_EXPIRATION_DIFF=$(expr $AWS_EXPIRATION - $(date +%s))
        if [ $AWS_EXPIRATION_DIFF -le 0 ]; then
            return 1
        else
            AWS_TOKEN_EXPIRATION_HR=$(expr $AWS_EXPIRATION_DIFF / 3600)
            AWS_TOKEN_EXPIRATION_MIN=$(expr $AWS_EXPIRATION_DIFF % 3600 / 60)
            AWS_TOKEN_EXPIRATION_SEC=$(expr $AWS_EXPIRATION_DIFF % 60)
            printf "%02d:%02d:%02d" $AWS_TOKEN_EXPIRATION_HR $AWS_TOKEN_EXPIRATION_MIN $AWS_TOKEN_EXPIRATION_SEC
            return 0
        fi
    fi
}

function _aws_token_prompt () {
    RED=$'\033[0;31m'
    GREEN=$'\033[0;32m'
    RESET=$'\033[0m'
    OPEN_ESC=$'\001'
    CLOSE_ESC=$'\002'

    if [ $AWS_ASSUMED_ROLE ]; then
        EXPIRATION=$(_aws_token_expiration)
        EXPIRATION_STATUS=$?
        AWS_ROLE_NAME=$(echo $AWS_ROLE | cut -d / -f 2)
        if [ $EXPIRATION_STATUS -eq 0 ]; then
            AWS_PS1="[${OPEN_ESC}${GREEN}${CLOSE_ESC} $AWS_PROFILE_NAME / $AWS_ROLE_NAME : $EXPIRATION ${OPEN_ESC}${RESET}${CLOSE_ESC}]"
        else
            AWS_PS1="[${OPEN_ESC}${RED}${CLOSE_ESC} $AWS_PROFILE_NAME / $AWS_ROLE_NAME : Expired ${OPEN_ESC}${RESET}${CLOSE_ESC}]"
        fi
        echo "${AWS_PS1}"
    fi
}