from flask import Flask, render_template
from flask import request
from flask import json
from flask import jsonify
from flask_googlemaps import GoogleMaps
from flask_googlemaps import Map
app = Flask(__name__)

GoogleMaps(app, key="AIzaSyCidFr8iYBBvsMPbal07w_PUuN6Xa0uEOA")

@app.route('/')
def homeview():
   return render_template('home.html')
   

@app.route('/map/')
def mapview():
    mymap = Map(
        identifier="mymap",
        lat=51.5154,
        lng=-0.1410,
        markers=[
          {
             'icon': 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
             'lat': 51.5154,
             'lng': -0.1410,
             'infobox': "<b>London Pub Crawl Generator</b>"
          },
          {
             'icon': 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
             'lat': 51.5154,
             'lng': -0.1410,
             'infobox': "<b>Hello World from other place</b>"
          }
        ]
    )
    return render_template('map.html', mymap=mymap)

if __name__ == "__main__":
    app.debug=True
    app.run(host='0.0.0.0', port=5000)