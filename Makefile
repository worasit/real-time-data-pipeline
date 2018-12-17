release-mysql:
	cd containers/databases/mysql; pwd && \
	bash release.sh;

release:
	make release-mysql