
.PHONY: all build docker-compose up clean

all: build docker-compose

build:
	mvn -f eureka-server/pom.xml -DskipTests package
	mvn -f gateway/pom.xml -DskipTests package
	mvn -f producer/pom.xml -DskipTests package
	mvn -f consumer/pom.xml -DskipTests package

docker-compose:
	docker-compose up --build -d

up:
	docker-compose up -d

clean:
	rm -rf eureka-server/target gateway/target producer/target consumer/target
	docker-compose down -v


deploy-consumer:
	@echo "🔧 Compilando consumer..."
	cd consumer && mvn clean package -DskipTests

	@echo "🐳 Construyendo imagen Docker de consumer..."
	docker compose build consumer

	@echo "🚀 Reiniciando solo el contenedor consumer..."
	docker compose up -d consumer

	@echo "✨ Consumer desplegado sin afectar al resto."

deploy-producer:
	@echo "🔧 Compilando producer..."
	cd producer && mvn clean package -DskipTests

	@echo "🐳 Construyendo imagen Docker de producer..."
	docker compose build producer

	@echo "🚀 Reiniciando solo el contenedor producer..."
	docker compose up -d producer

	@echo "✨ Producer desplegado sin afectar al resto."

deploy-all:
	@echo "🔧 Compilando todos los servicios..."
	mvn -DskipTests -pl consumer,producer,gateway,eureka -am clean package

	@echo "🐳 Construyendo imágenes Docker..."
	docker compose build consumer producer gateway eureka

	@echo "🚀 Desplegando todo sin afectar Kafka..."
	docker compose up -d consumer producer gateway eureka

	@echo "✨ Todos los servicios desplegados exitosamente."
