# Flask Static Files - POC

## How to Run
```bash
python -m venv venv
source venv/bin/activate

pip install -r requirements.txt
python app.py

./test.sh
```

## Testing in the Browser

Start the app with `python app.py`, then visit:

- http://localhost:5000/ — Home page with `url_for` examples
- http://localhost:5000/image — Page serving a static image
- http://localhost:5000/javascript — Page loading a static JS file

Static assets are served directly at:

- http://localhost:5000/static/css/style.css
- http://localhost:5000/static/js/app.js
- http://localhost:5000/static/images/flask-logo.svg
