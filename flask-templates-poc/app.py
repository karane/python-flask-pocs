from flask import Flask, render_template

app = Flask(__name__)


@app.template_filter("reverse_words")
def reverse_words(s):
    return " ".join(s.split()[::-1])



# Routes

@app.route("/")
def home():
    return render_template("home.html", name="Karane")


@app.route("/inheritance")
def inheritance():
    return render_template("inheritance.html")


@app.route("/filters")
def filters():
    return render_template("filters.html",
        text="hello world from flask",
        items=["python", "flask", "jinja2"],
        long_text="This is a very long text that should be truncated by the filter"
    )


@app.route("/macros")
def macros():
    users = [
        {"name": "Alice", "email": "alice@example.com"},
        {"name": "Bob", "email": "bob@example.com"},
        {"name": "Charlie", "email": "charlie@example.com"},
    ]
    return render_template("macros_page.html", users=users)


@app.route("/control-flow")
def control_flow():
    return render_template("control_flow.html",
        logged_in=True,
        username="Karane",
        items=["Flask", "Jinja2", "Werkzeug"]
    )


if __name__ == "__main__":
    app.run(debug=True)
