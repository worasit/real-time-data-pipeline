release-mysql:
	cd containers/databases/mysql && \
	bash release.sh;

release:
	gcloud auth configure-docker && echo 'Y' && \
	make release-mysql;