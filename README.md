
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

Si estuvieras mapeando un directorio local, usa este comando en el host:
sudo chown -R 1000:1000 ./data/kafka1

Crear topic:
```sh
docker exec -it kafka-1 /opt/kafka/bin/kafka-topics.sh \
--bootstrap-server kafka-1:9092 \
--create \
--topic test-topic \
--partitions 1 \
--replication-factor 1
```
```sh
docker exec -it kafka-1 /opt/kafka/bin/kafka-topics.sh \
--bootstrap-server kafka-1:9092 \
--create \
--topic mi-topic \
--partitions 12 \
--replication-factor 3
```
Lista topic:
```sh
docker exec -it kafka-1 /opt/kafka/bin/kafka-topics.sh \
--bootstrap-server kafka-1:9092 \
--list
```

Enviar mensaje (Producer):
```sh
docker exec -it kafka-1 /opt/kafka/bin/kafka-console-producer.sh \
  --bootstrap-server kafka-1:9092 \
  --topic mi-topic
```

curl -X POST http://localhost:8081/produce      -H "Content-Type: application/json"      -d '{"message": "Hola"}'

Leer mensaje (Consumer):
```sh
docker exec -it kafka-1 /opt/kafka/bin/kafka-console-consumer.sh \
--bootstrap-server kafka-1:9092 \
--topic mi-topic \
--from-beginning
```

Borrar topic
```sh
docker exec -it kafka-1 /opt/kafka/bin/kafka-topics.sh \
  --bootstrap-server kafka-1:9092 \
  --delete \
  --topic mi-topic
```

Verificar que se ha borrado topic
```sh
docker exec -it kafka-1 /opt/kafka/bin/kafka-topics.sh \
--bootstrap-server kafka-1:9092 \
--list
```

Ver particiones
```sh
docker exec -it kafka-1 /opt/kafka/bin/kafka-console-consumer.sh \
--bootstrap-server kafka-1:9092,kafka-2:9092,kafka-3:9092 \
--topic mi-topic \
--from-beginning \
--property print.partition=true \
--property print.offset=true
```

Nota sobre replicación y brokers

Con replication-factor=3 y 12 particiones:
Cada partición tiene 3 réplicas repartidas en los 3 brokers.
Solo la réplica líder envía mensajes al consumer.
Si quieres ver qué broker es el líder de cada partición:
```sh
docker exec -it kafka-1 /opt/kafka/bin/kafka-topics.sh \
--bootstrap-server kafka-1:9092 \
--describe \
--topic mi-topic
```
