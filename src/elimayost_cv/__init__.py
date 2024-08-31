
from flask import Flask, render_template, send_from_directory

app = Flask(__name__)

@app.route("/")
@app.route("/skills")
def skills():
    return render_template('skills.html')

@app.route("/employment")
def employment():
    return render_template('employment.html')

@app.route("/education")
def education():
    return render_template('education.html')

@app.route("/interests")
def interests():
    return render_template('interests.html')

@app.route("/pdf")
def pdf():
    return send_from_directory('pdf', 'elimayost-cv.pdf')

def main():
    app.run(host="0.0.0.0", port=8000)
