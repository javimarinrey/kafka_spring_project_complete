
FROM eclipse-temurin:17-jdk
WORKDIR /app
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# Copiamos los scripts
#COPY wait-for-it.sh /app/
#COPY start.sh /app/

# Damos permisos de ejecución
#RUN chmod +x wait-for-it.sh start.sh

EXPOSE 8080
#ENTRYPOINT ["./wait-for-it.sh", "kafka-1:9092", "--", "./wait-for-it.sh", "eureka:8761", "--timeout=60", "--", "./start.sh"]
ENTRYPOINT ["java","-jar","/app/app.jar"]