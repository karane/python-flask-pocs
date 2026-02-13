from flask import Flask, request, jsonify

app = Flask(__name__)


# Global Error Handlers

@app.errorhandler(400)
def bad_request(error):
    return jsonify({
        "error": "Bad Request",
        "message": str(error)
    }), 400

@app.errorhandler(404)
def not_found(error):
    return jsonify({
        "error": "Not Found",
        "message": "Resource not found"
    }), 404

@app.errorhandler(500)
def internal_error(error):
    return jsonify({
        "error": "Internal Server Error",
        "message": "Something went wrong"
    }), 500



# Basic routes

@app.route("/")
def home():
    return "Hello Flask", 200

@app.route("/health")
def health():
    return jsonify({"status": "UP"}), 200



# GET

@app.route("/users/<username>", methods=["GET"])
def get_user(username):
    return jsonify({
        "username": username
    }), 200



# POST
@app.route("/users", methods=["POST"])
def create_user():
    data = request.get_json(silent=True)

    if not data:
        return jsonify({
            "error": "Invalid JSON"
        }), 400

    if "username" not in data:
        return jsonify({
            "error": "username is required"
        }), 400

    return jsonify({
        "message": "User created",
        "user": {
            "username": data["username"]
        }
    }), 201



# PUT

@app.route("/users/<username>", methods=["PUT"])
def update_user(username):
    data = request.get_json(silent=True)

    if not data:
        return jsonify({
            "error": "Invalid JSON"
        }), 400

    if "email" not in data:
        return jsonify({
            "error": "email is required"
        }), 400

    return jsonify({
        "message": "User updated",
        "user": {
            "username": username,
            "email": data["email"]
        }
    }), 200



# DELETE

@app.route("/users/<username>", methods=["DELETE"])
def delete_user(username):
    return jsonify({
        "message": f"User '{username}' deleted"
    }), 200


if __name__ == "__main__":
    app.run(debug=True)
