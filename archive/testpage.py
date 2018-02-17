from flask import Flask, render_template
from flask import request
from flask import json
from flask import jsonify
from flask_googlemaps import GoogleMaps
from flask_googlemaps import Map
import requests 
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

@app.route('/test/')
def testview():

    GOOGLE_MAPS_API_URL = 'http://maps.googleapis.com/maps/api/geocode/json'
    params = {
    'address': 'Oxford Street, London, United Kingdom',
    'sensor': 'false',
    'region': 'uk'
    }

    # Do the request and get the response data
    req = requests.get(GOOGLE_MAPS_API_URL, auth=( 'AIzaSyCidFr8iYBBvsMPbal07w_PUuN6Xa0uEOA'))
    res = req.json()

    # Use the first result
    result = res['results'][0]

    geodata = dict()
    geodata['lat'] = result['geometry']['location']['lat']
    geodata['lng'] = result['geometry']['location']['lng']
    geodata['address'] = result['formatted_address']

    print('{address}. (lat, lng) = ({lat}, {lng})'.format(**geodata))
    # 221B Baker Street, London, Greater London NW1 6XE, UK. (lat, lng) = (51.5237038, -0.1585531)
    return render_template('test.html')
   
if __name__ == "__main__":
    app.debug=True
    app.run(host='0.0.0.0', port=5000)