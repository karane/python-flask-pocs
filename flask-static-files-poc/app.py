from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
def home():
    return render_template("home.html")


@app.route("/image")
def image_page():
    return render_template("image.html")


@app.route("/javascript")
def javascript_page():
    return render_template("javascript.html")


if __name__ == "__main__":
    app.run(debug=True)
