#!/bin/bash

BASE_URL="http://127.0.0.1:5000"

echo "== GET / =="
curl -i $BASE_URL/
echo -e "\n"

echo "== POST /products (create Laptop) =="
curl -i -X POST $BASE_URL/products \
  -H "Content-Type: application/json" \
  -d '{"name": "Laptop", "description": "A powerful laptop", "price": 999.99, "in_stock": true}'
echo -e "\n"

echo "== POST /products (create Headphones) =="
curl -i -X POST $BASE_URL/products \
  -H "Content-Type: application/json" \
  -d '{"name": "Headphones", "description": "Noise cancelling", "price": 149.99, "in_stock": true}'
echo -e "\n"

echo "== POST /products (create USB Cable, out of stock) =="
curl -i -X POST $BASE_URL/products \
  -H "Content-Type: application/json" \
  -d '{"name": "USB Cable", "description": "USB-C to USB-A", "price": 9.99, "in_stock": false}'
echo -e "\n"


echo "== GET /products =="
curl -i $BASE_URL/products
echo -e "\n"

echo "== GET /products?in_stock=true =="
curl -i "$BASE_URL/products?in_stock=true"
echo -e "\n"

echo "== GET /products?in_stock=false =="
curl -i "$BASE_URL/products?in_stock=false"
echo -e "\n"

echo "== GET /products/1 =="
curl -i $BASE_URL/products/1
echo -e "\n"


echo "== PUT /products/1 (full update) =="
curl -i -X PUT $BASE_URL/products/1 \
  -H "Content-Type: application/json" \
  -d '{"name": "Gaming Laptop", "description": "High performance gaming laptop", "price": 1299.99, "in_stock": true}'
echo -e "\n"

echo "== PATCH /products/2 (partial update — price only) =="
curl -i -X PATCH $BASE_URL/products/2 \
  -H "Content-Type: application/json" \
  -d '{"price": 129.99}'
echo -e "\n"


echo "== DELETE /products/3 =="
curl -i -X DELETE $BASE_URL/products/3
echo -e "\n"

echo "== GET /products (product 3 should be deleted before) =="
curl -i $BASE_URL/products
echo -e "\n"

echo "== POST /products (missing name — 400) =="
curl -i -X POST $BASE_URL/products \
  -H "Content-Type: application/json" \
  -d '{"description": "No name provided", "price": 5.00}'
echo -e "\n"

echo "== GET /products/999 (404) =="
curl -i $BASE_URL/products/999
echo -e "\n"
