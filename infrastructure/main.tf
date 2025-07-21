provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "weather_data" {
  name           = "WeatherData"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "city"
  range_key      = "timestamp"

  attribute {
    name = "city"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  tags = {
    Name    = "WeatherMonitor"
    Purpose = "Store weather readings"
  }
}
