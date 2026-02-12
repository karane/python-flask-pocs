#!/bin/bash

BASE_URL="http://127.0.0.1:5000"

echo "== GET / (home with variable) =="
curl -s $BASE_URL/
echo -e "\n"

echo "== GET /inheritance (child overrides blocks) =="
curl -s $BASE_URL/inheritance
echo -e "\n"

echo "== GET /filters (built-in + custom filters) =="
curl -s $BASE_URL/filters
echo -e "\n"

echo "== GET /macros (reusable components) =="
curl -s $BASE_URL/macros
echo -e "\n"

echo "== GET /control-flow (if/else, for loops) =="
curl -s $BASE_URL/control-flow
echo -e "\n"
