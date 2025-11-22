
Proyecto ejemplo Kafka KRaft + Spring Boot (Eureka, Gateway, Producer, Consumer)

Instrucciones rápidas:
1. Instala Maven y Docker.
2. Ejecuta `make build` (o `./scripts/build_and_up.sh`) para construir jars y levantar containers.
3. Comprueba Eureka en http://localhost:8761
4. Produce mensajes con POST http://localhost:8081/produce (body raw string)
5. Consumer los recibirá y procesará.

Notas:
- Crea el topic `mi-topic` con particiones=12 y replication=3 antes de producir:
  ```sh
  kafka-topics.sh --create --bootstrap-server kafka-1:9092 --replication-factor 3 --partitions 12 --topic mi-topic
  ```
- Ajusta recursos JVM en los Dockerfiles si es necesario.


Para actualizar un contenedor:
```sh
make deploy-consumer
make deploy-producer
```

Compila TODOS los microservicios

Reconstruye imágenes solo si hay cambios

No interrumpe Kafka

Levanta cada contenedor con health checks

```sh
make deploy-all
```
