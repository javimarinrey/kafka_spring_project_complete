
#!/bin/bash
set -e
#mvn -f eureka-server/pom.xml -DskipTests clean package
#mvn -f gateway/pom.xml -DskipTests clean package
mvn -f producer/pom.xml -DskipTests clean package
mvn -f consumer/pom.xml -DskipTests clean package
docker compose up --build -d kafka-1 kafka-2 kafka-3
#docker compose up --build -d producer consumer
