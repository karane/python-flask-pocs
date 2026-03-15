from flask import Flask, request, jsonify

app = Flask(__name__)

# Basic routes
@app.route("/")
def home():
    return "Hello Flask"

@app.route("/health")
def health():
    return jsonify({"status": "UP"}), 200

@app.route("/users/<username>")
def get_user(username):
    return jsonify({
        "username": username
    })

# Create a user
@app.route("/users", methods=["POST"])
def create_user():
    data = request.get_json()

    if not data or "username" not in data:
        return jsonify({"error": "username is required"}), 400

    return jsonify({
        "message": "User created",
        "user": {
            "username": data["username"]
        }
    }), 201

# Update a user
@app.route("/users/<username>", methods=["PUT"])
def update_user(username):
    data = request.get_json()

    if not data or "email" not in data:
        return jsonify({"error": "email is required"}), 400

    return jsonify({
        "message": "User updated",
        "user": {
            "username": username,
            "email": data["email"]
        }
    })

# Delete a user
@app.route("/users/<username>", methods=["DELETE"])
def delete_user(username):
    return jsonify({
        "message": f"User '{username}' deleted"
    }), 200

if __name__ == "__main__":
    app.run(debug=True)
