release-mysql:
	cd containers/databases/mysql && \
	bash release.sh;

release:
	yes | gcloud auth configure-docker && \
	make release-mysql;