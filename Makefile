run-mysql:
	cd containers/databases/mysql && \
    bash run.sh;

run-schema-registry-producer-app:
	 mvn clean compile package && \
	 cp target/generated-sources/com/nongped/poc/avro/Payment.java src/main/resources/com.nongped.poc.avro/Payment.java && \
	 mvn exec:java -Dexec.mainClass=com.nongped.poc.schemaregistry.ProducerExample;

run-schema-registry-consumer-app:
	mvn clean compile package && \
    	 cp target/generated-sources/com/nongped/poc/avro/Payment.java src/main/resources/com.nongped.poc.avro/Payment.java && \
    	 mvn exec:java -Dexec.mainClass=com.nongped.poc.schemaregistry.ConsumerExample;

run-app:
	mvn clean package && \
	java -jar target/real-time-data-pipeline-1.0-SNAPSHOT.jar;

release-mysql:
	cd containers/databases/mysql && \
	bash release.sh;

release:
	yes | gcloud auth configure-docker && \
	make release-mysql;

