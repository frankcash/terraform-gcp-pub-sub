## Getting Google Default Credentials

```
Error: Error running plan: 1 error(s) occurred:

* provider.google: google: could not find default credentials. See https://developers.google.com/accounts/docs/application-default-credentials for more information.
```
To Fix:
```
export GOOGLE_CLOUD_KEYFILE_JSON=path/to/key/file/file.json
```

# Sending a Message

`gcloud pubsub topics publish QUEUE_NAME --message MESSAGE`