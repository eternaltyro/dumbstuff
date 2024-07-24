# Lambda Function to Update Lambstatus


## Deployment package prep

```
pip install --target ./package urllib3
pushd package
zip -r9 ${OLDPWD}/function.zip .
popd
zip -g function.zip lambda_function.py
```
