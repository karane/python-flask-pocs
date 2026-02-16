#!/bin/bash

BASE_URL="http://127.0.0.1:5000"

echo "== GET / =="
curl -i $BASE_URL/
echo -e "\n"

echo "== GET /register (renders form with CSRF token) =="
curl -i $BASE_URL/register
echo -e "\n"

echo "== GET /contact (renders form with CSRF token) =="
curl -i $BASE_URL/contact
echo -e "\n"

echo "== POST /register (no CSRF token — rejected) =="
curl -i -X POST $BASE_URL/register \
  -d "username=karane&email=karane@example.com&password=secret123&confirm_password=secret123"
echo -e "\n"

echo "== POST /api/register (valid) =="
curl -i -X POST $BASE_URL/api/register \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=karane&email=karane@example.com&password=secret123&confirm_password=secret123"
echo -e "\n"

echo "== POST /api/register (missing username) =="
curl -i -X POST $BASE_URL/api/register \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "email=karane@example.com&password=secret123&confirm_password=secret123"
echo -e "\n"

echo "== POST /api/register (invalid email) =="
curl -i -X POST $BASE_URL/api/register \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=karane&email=not-an-email&password=secret123&confirm_password=secret123"
echo -e "\n"

echo "== POST /api/register (password too short) =="
curl -i -X POST $BASE_URL/api/register \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=karane&email=karane@example.com&password=abc&confirm_password=abc"
echo -e "\n"

echo "== POST /api/register (passwords don't match) =="
curl -i -X POST $BASE_URL/api/register \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=karane&email=karane@example.com&password=secret123&confirm_password=wrong123"
echo -e "\n"

echo "== POST /api/contact (valid) =="
curl -i -X POST $BASE_URL/api/contact \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "name=karane&email=karane@example.com&subject=general&message=Hello this is a test message&agree_terms=y"
echo -e "\n"

echo "== POST /api/contact (missing required fields) =="
curl -i -X POST $BASE_URL/api/contact \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "name=karane"
echo -e "\n"

echo "== POST /api/contact (message too short) =="
curl -i -X POST $BASE_URL/api/contact \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "name=karane&email=karane@example.com&subject=support&message=Hi&agree_terms=y"
echo -e "\n"

echo "== GET /non-existing-route =="
curl -i $BASE_URL/does-not-exist
echo -e "\n"
