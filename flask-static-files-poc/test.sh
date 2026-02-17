#!/bin/bash

BASE_URL="http://127.0.0.1:5000"

echo "== GET / (home with url_for examples) =="
curl -s $BASE_URL/
echo -e "\n"

echo "== GET /image (image page) =="
curl -s $BASE_URL/image
echo -e "\n"

echo "== GET /javascript (js page) =="
curl -s $BASE_URL/javascript
echo -e "\n"

echo "== GET /static/css/style.css =="
curl -s -w "\nHTTP %{http_code}" $BASE_URL/static/css/style.css
echo -e "\n"

echo "== GET /static/js/app.js =="
curl -s -w "\nHTTP %{http_code}" $BASE_URL/static/js/app.js
echo -e "\n"

echo "== GET /static/images/flask-logo.svg =="
curl -s -w "\nHTTP %{http_code}" $BASE_URL/static/images/flask-logo.svg
echo -e "\n"
