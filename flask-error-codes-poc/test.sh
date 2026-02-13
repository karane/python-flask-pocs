#!/bin/bash

BASE_URL="http://127.0.0.1:5000"

echo "== GET / =="
curl -i $BASE_URL/
echo -e "\n"

echo "== GET /health =="
curl -i $BASE_URL/health
echo -e "\n"

echo "== GET /users/karane =="
curl -i $BASE_URL/users/karane
echo -e "\n"

echo "== POST /users (valid) =="
curl -i -X POST $BASE_URL/users \
  -H "Content-Type: application/json" \
  -d '{"username": "karane"}'
echo -e "\n"

echo "== POST /users (missing username) =="
curl -i -X POST $BASE_URL/users \
  -H "Content-Type: application/json" \
  -d '{}'
echo -e "\n"

echo "== POST /users (invalid JSON) =="
curl -i -X POST $BASE_URL/users \
  -H "Content-Type: application/json" \
  -d '{invalid_json}'
echo -e "\n"

echo "== PUT /users/karane (valid) =="
curl -i -X PUT $BASE_URL/users/karane \
  -H "Content-Type: application/json" \
  -d '{"email": "karane@example.com"}'
echo -e "\n"

echo "== PUT /users/karane (missing email) =="
curl -i -X PUT $BASE_URL/users/karane \
  -H "Content-Type: application/json" \
  -d '{}'
echo -e "\n"

echo "== DELETE /users/karane =="
curl -i -X DELETE $BASE_URL/users/karane
echo -e "\n"

echo "== GET /non-existing-route =="
curl -i $BASE_URL/does-not-exist
echo -e "\n"
