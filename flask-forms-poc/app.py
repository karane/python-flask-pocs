from flask import Flask, render_template, redirect, url_for, flash, request, jsonify
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, TextAreaField, SelectField, BooleanField, Form
from wtforms.validators import DataRequired, Email, Length, EqualTo

app = Flask(__name__)
app.config["SECRET_KEY"] = "dev-secret-key"


# Forms

class RegistrationForm(FlaskForm):
    username = StringField("Username", validators=[
        DataRequired(),
        Length(min=3, max=20)
    ])
    email = StringField("Email", validators=[
        DataRequired(),
        Email()
    ])
    password = PasswordField("Password", validators=[
        DataRequired(),
        Length(min=6)
    ])
    confirm_password = PasswordField("Confirm Password", validators=[
        DataRequired(),
        EqualTo("password", message="Passwords must match")
    ])


class ContactForm(FlaskForm):
    name = StringField("Name", validators=[DataRequired()])
    email = StringField("Email", validators=[DataRequired(), Email()])
    subject = SelectField("Subject", choices=[
        ("general", "General Inquiry"),
        ("support", "Support"),
        ("feedback", "Feedback")
    ])
    message = TextAreaField("Message", validators=[
        DataRequired(),
        Length(min=10, max=500)
    ])
    agree_terms = BooleanField("I agree to the terms", validators=[
        DataRequired()
    ])


# Routes

@app.route("/")
def home():
    return render_template("home.html")


@app.route("/register", methods=["GET", "POST"])
def register():
    form = RegistrationForm()

    if form.validate_on_submit():
        flash(f"Account created for {form.username.data}!", "success")
        return redirect(url_for("home"))

    return render_template("register.html", form=form)


@app.route("/contact", methods=["GET", "POST"])
def contact():
    form = ContactForm()

    if form.validate_on_submit():
        flash(f"Message sent from {form.name.data}!", "success")
        return redirect(url_for("home"))

    return render_template("contact.html", form=form)


# API-style form handling
@app.route("/api/register", methods=["POST"])
def api_register():
    form = RegistrationForm(meta={"csrf": False})

    if form.validate_on_submit():
        return jsonify({
            "message": "User registered",
            "user": {
                "username": form.username.data,
                "email": form.email.data
            }
        }), 201

    return jsonify({"errors": form.errors}), 400


@app.route("/api/contact", methods=["POST"])
def api_contact():
    form = ContactForm(meta={"csrf": False})

    if form.validate_on_submit():
        return jsonify({
            "message": "Contact form submitted",
            "data": {
                "name": form.name.data,
                "email": form.email.data,
                "subject": form.subject.data,
                "message": form.message.data
            }
        }), 201

    return jsonify({"errors": form.errors}), 400


if __name__ == "__main__":
    app.run(debug=True)
