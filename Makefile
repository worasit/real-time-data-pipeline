run:
	mvn clean package && \
	java -jar target/real-time-data-pipeline-1.0-SNAPSHOT.jar ;


release-mysql:
	cd containers/databases/mysql && \
	bash release.sh;

release:
	yes | gcloud auth configure-docker && \
	make release-mysql;