from flask import Flask
from flask import request
app = Flask(__name__)

@app.route('/')
def title():
    return homepage.html


@app.route('/map', methods=['GET', 'POST'])
def showmap():
    return "This is where the map should go."
    if request.method == 'POST':
        pass
    elif request.method == 'GET':
        return 'This is where the map should be.'
    else:
        pass