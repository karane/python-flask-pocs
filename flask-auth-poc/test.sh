#!/bin/bash

BASE_URL="http://127.0.0.1:5000"
COOKIE_JAR="/tmp/auth_poc_cookies.txt"

# Kill anything on port 5000, reset state
fuser -k 5000/tcp 2>/dev/null; sleep 0.5
rm -f $COOKIE_JAR
rm -f instance/app.db

# Start fresh Flask server
source venv/bin/activate
flask run &>/tmp/flask_auth_poc.log &
FLASK_PID=$!

# Wait until server is ready
for i in $(seq 1 10); do
  curl -s $BASE_URL/ &>/dev/null && break
  sleep 0.5
done

trap "kill $FLASK_PID 2>/dev/null" EXIT

echo "== GET / (unauthenticated) =="
curl -i $BASE_URL/
echo -e "\n"

echo "== POST /register (create alice) =="
curl -i -X POST $BASE_URL/register \
  -H "Content-Type: application/json" \
  -d '{"username": "alice", "email": "alice@example.com", "password": "secret123"}'
echo -e "\n"

echo "== POST /register (create bob) =="
curl -i -X POST $BASE_URL/register \
  -H "Content-Type: application/json" \
  -d '{"username": "bob", "email": "bob@example.com", "password": "secret456"}'
echo -e "\n"

echo "== POST /register (duplicate username — 409) =="
curl -i -X POST $BASE_URL/register \
  -H "Content-Type: application/json" \
  -d '{"username": "alice", "email": "alice2@example.com", "password": "secret789"}'
echo -e "\n"

echo "== POST /login (wrong password — 401) =="
curl -i -X POST $BASE_URL/login \
  -H "Content-Type: application/json" \
  -d '{"username": "alice", "password": "wrongpassword"}'
echo -e "\n"

echo "== POST /login (alice — success, saves cookie) =="
curl -i -X POST $BASE_URL/login \
  -c $COOKIE_JAR \
  -H "Content-Type: application/json" \
  -d '{"username": "alice", "password": "secret123"}'
echo -e "\n"

echo "== GET /me (with cookie — returns alice) =="
curl -i $BASE_URL/me \
  -b $COOKIE_JAR
echo -e "\n"

echo "== GET /users (with cookie — list users) =="
curl -i $BASE_URL/users \
  -b $COOKIE_JAR
echo -e "\n"

echo "== GET / (with cookie — authenticated: true) =="
curl -i $BASE_URL/ \
  -b $COOKIE_JAR
echo -e "\n"

echo "== GET /me (without cookie — 401) =="
curl -i $BASE_URL/me
echo -e "\n"

echo "== POST /logout (with cookie) =="
curl -i -X POST $BASE_URL/logout \
  -b $COOKIE_JAR \
  -c $COOKIE_JAR
echo -e "\n"

echo "== GET /me (after logout — 401) =="
curl -i $BASE_URL/me \
  -b $COOKIE_JAR
echo -e "\n"
