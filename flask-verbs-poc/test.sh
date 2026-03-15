#!/bin/bash

BASE_URL="http://127.0.0.1:5000"

echo "== GET / =="
curl $BASE_URL/
echo -e "\n"

echo "== GET /health =="
curl -i $BASE_URL/health
echo -e "\n"

echo "== GET /users/karane =="
curl $BASE_URL/users/karane
echo -e "\n"

echo "== POST /users =="
curl -X POST $BASE_URL/users \
  -H "Content-Type: application/json" \
  -d '{"username": "karane"}'
echo -e "\n"

echo "== POST /users (missing username) =="
curl -X POST $BASE_URL/users \
  -H "Content-Type: application/json" \
  -d '{}'
echo -e "\n"

echo "== PUT /users/karane =="
curl -X PUT $BASE_URL/users/karane \
  -H "Content-Type: application/json" \
  -d '{"email": "karane@example.com"}'
echo -e "\n"

echo "== DELETE /users/karane =="
curl -X DELETE $BASE_URL/users/karane
echo -e "\n"
