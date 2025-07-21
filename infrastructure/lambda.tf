resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_logs" {
  name       = "lambda_logs"
  roles      = [aws_iam_role.lambda_exec_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name = "LambdaPutItemPolicy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem"
        ]
        Resource = "arn:aws:dynamodb:us-east-1:886436965715:table/WeatherData"
      }
    ]
  })
}

resource "aws_lambda_function" "weather_monitor" {
  function_name = "weather_monitor"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
  filename      = "${path.module}/../lamba/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/../lamba/lambda_function.zip")

  environment {
    variables = {
      DYNAMO_TABLE = "WeatherData"
      WEATHER_API_KEY  = "OPEN_WEATHER_APIKEY"
    }
  }
}
