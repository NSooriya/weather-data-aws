import json
import requests
import boto3
import os
from datetime import datetime

def lambda_handler(event, context):
    city = "Chennai" 
    api_key = os.environ['WEATHER_API_KEY']
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('WeatherData')

    url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&units=metric"

    response = requests.get(url)
    data = response.json()

    if response.status_code == 200:
        item = {
            'city': city,
            'timestamp': datetime.utcnow().isoformat(),
            'temperature': str(data['main']['temp']),
            'weather': data['weather'][0]['description'],
        }

        table.put_item(Item=item)
        return {
            'statusCode': 200,
            'body': f"Data inserted: {item}"
        }
    else:
        return {
            'statusCode': response.status_code,
            'body': f"Error fetching weather data: {data}"
        }
