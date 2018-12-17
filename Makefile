release-mysql:
	cd containers/databases/mysql && \
	bash release.sh;

release:
	make release-mysql