#!/bin/bash

BASE_URL="http://127.0.0.1:5000"

curl $BASE_URL/
echo

curl $BASE_URL/users/karane
echo

curl $BASE_URL/posts/1
echo

curl "$BASE_URL/search?q=flask"
echo

curl $BASE_URL/api/info
echo

curl -i $BASE_URL/health
