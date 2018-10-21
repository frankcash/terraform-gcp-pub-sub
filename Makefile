login:
	gcloud auth login

logs:
	gcloud functions logs read --limit 50

zip:
	zip function/function.zip function/index.js
