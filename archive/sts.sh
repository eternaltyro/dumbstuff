aws sts assume-role --serial-number arn:aws:iam::<AWS_ACCOUNT_ID>:mfa/<USER_NAME?>  --role-arn arn:aws:iam::<AWS_ACCOUNT_ID>:role/terraform-assumeRole --role-session-name $1 --output json --token-code $2

