from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello Flask"

@app.route("/users/<username>")
def get_user(username):
    return f"User: {username}"

@app.route("/posts/<int:post_id>")
def get_post(post_id):
    return f"Post ID: {post_id}"

@app.route("/search")
def search():
    term = request.args.get("q", "not provided")
    return f"Search term: {term}"

@app.route("/api/info")
def info():
    return jsonify({
        "app": "Flask Hello World",
        "version": "1.0.0"
    })

@app.route("/health")
def health():
    return jsonify({"status": "UP"}), 200

if __name__ == "__main__":
    app.run(debug=True)
