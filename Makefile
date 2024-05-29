postgres:
	docker run --name postgres16 -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=mysecret -d postgres:16-alpine

createdb:
	docker exec -it postgres16 createdb --username=root --owner=root mybank

dropdb:
	docker exec -it postgres16 dropdb mybank

migrateup:
	migrate -path db/migration -database "postgresql://root:mysecret@localhost:5433/mybank?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:mysecret@localhost:5433/mybank?sslmode=disable" --verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb dropdb migrateup migratedown sqlc