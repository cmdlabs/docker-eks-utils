function _aws_reauth () {
    DURATION="${AWS_ROLE_DURATION:-3600}"
    SESSION_NAME="${AWS_ROLE_SESSION_NAME:-`date +%s`}"
    
    KST=(`aws sts assume-role --role-arn "$AWS_ROLE" \
            --role-session-name "$SESSION_NAME" \
            --duration-seconds $DURATION \
            --query '[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken,Credentials.Expiration]' \
            --output text`)

    EXPIRATION="$(date -d ${KST[3]} +%s)"

    echo "export AWS_ACCESS_KEY_ID=${KST[0]}"
    echo "export AWS_ACCESS_KEY=${KST[0]}"
    echo "export AWS_SECRET_ACCESS_KEY=${KST[1]}"
    echo "export AWS_SECRET_KEY=${KST[1]}"
    echo "export AWS_SESSION_TOKEN=${KST[2]}"
    echo "export AWS_SECURITY_TOKEN=${KST[2]}"
    echo "export AWS_EXPIRATION=${EXPIRATION}"
}
