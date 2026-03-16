from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///app.db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

# Model
class Product(db.Model):
    __tablename__ = "products"

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(200), nullable=False)
    description = db.Column(db.Text, default="")
    price = db.Column(db.Float, nullable=False)
    in_stock = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "price": self.price,
            "in_stock": self.in_stock,
            "created_at": self.created_at.isoformat(),
        }


# Create tables on startup
with app.app_context():
    db.create_all()


# Routes
@app.route("/")
def index():
    return jsonify({"message": "Products API", "version": "1.0"})


@app.route("/products", methods=["GET"])
def list_products():
    query = Product.query
    in_stock_param = request.args.get("in_stock")
    if in_stock_param is not None:
        if in_stock_param.lower() == "true":
            query = query.filter_by(in_stock=True)
        elif in_stock_param.lower() == "false":
            query = query.filter_by(in_stock=False)
    products = query.all()
    return jsonify([p.to_dict() for p in products])


@app.route("/products", methods=["POST"])
def create_product():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Request body is required"}), 400
    if not data.get("name"):
        return jsonify({"error": "name is required"}), 400
    if data.get("price") is None:
        return jsonify({"error": "price is required"}), 400

    product = Product(
        name=data["name"],
        description=data.get("description", ""),
        price=data["price"],
        in_stock=data.get("in_stock", True),
    )
    db.session.add(product)
    db.session.commit()
    return jsonify(product.to_dict()), 201


@app.route("/products/<int:product_id>", methods=["GET"])
def get_product(product_id):
    product = db.session.get(Product, product_id)
    if not product:
        return jsonify({"error": "Not found"}), 404
    return jsonify(product.to_dict())


@app.route("/products/<int:product_id>", methods=["PUT"])
def update_product(product_id):
    product = db.session.get(Product, product_id)
    if not product:
        return jsonify({"error": "Not found"}), 404

    data = request.get_json()
    if not data:
        return jsonify({"error": "Request body is required"}), 400
    if not data.get("name"):
        return jsonify({"error": "name is required"}), 400
    if data.get("price") is None:
        return jsonify({"error": "price is required"}), 400

    product.name = data["name"]
    product.description = data.get("description", "")
    product.price = data["price"]
    product.in_stock = data.get("in_stock", True)
    db.session.commit()
    return jsonify(product.to_dict())


@app.route("/products/<int:product_id>", methods=["PATCH"])
def partial_update_product(product_id):
    product = db.session.get(Product, product_id)
    if not product:
        return jsonify({"error": "Not found"}), 404

    data = request.get_json()
    if not data:
        return jsonify({"error": "Request body is required"}), 400

    if "name" in data:
        product.name = data["name"]
    if "description" in data:
        product.description = data["description"]
    if "price" in data:
        product.price = data["price"]
    if "in_stock" in data:
        product.in_stock = data["in_stock"]

    db.session.commit()
    return jsonify(product.to_dict())


@app.route("/products/<int:product_id>", methods=["DELETE"])
def delete_product(product_id):
    product = db.session.get(Product, product_id)
    if not product:
        return jsonify({"error": "Not found"}), 404
    db.session.delete(product)
    db.session.commit()
    return "", 204


if __name__ == "__main__":
    app.run(debug=True)
