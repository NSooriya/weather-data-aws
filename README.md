# Real-Time Weather Monitor on AWS

## Overview
This project demonstrates how to build a **real-time weather monitoring system** using **AWS services** and **Terraform** for infrastructure as code (IaC). It fetches live weather data from an external API and stores it in **DynamoDB** via an **AWS Lambda function**.

---

## Tech Stack
- **AWS Lambda** – serverless compute
- **Amazon DynamoDB** – NoSQL database for storing weather data
- **Terraform** – infrastructure as code to provision AWS resources
- **Python** – for Lambda function
- **OpenWeatherMap API** – to fetch weather data

---

## What It Does
- Accepts a city name (like *Chennai*) as input.
- Fetches live weather data (temperature, weather condition).
- Stores the data in a DynamoDB table with a timestamp.

---

## Architecture Diagram

```plaintext
User/Trigger
   ↓
AWS Lambda (Python) ───> OpenWeatherMap API
         ↓
    DynamoDB Table (WeatherData)
