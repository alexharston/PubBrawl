from flask import Flask
from flask import request
app = Flask(__name__)

@app.route('/')
def title():
    return 'Test page'


@app.route('/map', methods=['GET', 'POST'])
def showmap():
    if request.method == 'POST':
        pass
    else:
        pass
