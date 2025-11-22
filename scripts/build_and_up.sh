
#!/bin/bash
set -e
mvn -f eureka-server/pom.xml -DskipTests package
mvn -f gateway/pom.xml -DskipTests package
mvn -f producer/pom.xml -DskipTests package
mvn -f consumer/pom.xml -DskipTests package
docker-compose up --build -d
