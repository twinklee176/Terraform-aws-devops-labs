provider "aws" {
  region = "ap-south-1"
}

# S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "twinkle-s3-demo-123456"
}

# SQS Queue
resource "aws_sqs_queue" "queue" {
  name = "object-events-queue"
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "lambda.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

# Lambda Basic Execution Role
resource "aws_iam_role_policy_attachment" "basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function
resource "aws_lambda_function" "lambda" {
  filename         = "lambda.zip"
  function_name    = "print-object-name"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256("lambda.zip")
}

# Lambda Permission for SQS
resource "aws_iam_role_policy" "sqs_policy" {
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ]

      Resource = aws_sqs_queue.queue.arn
    }]
  })
}

# SQS Policy
resource "aws_sqs_queue_policy" "policy" {
  queue_url = aws_sqs_queue.queue.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "s3.amazonaws.com"
      }

      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.queue.arn

      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_s3_bucket.bucket.arn
        }
      }
    }]
  })
}

# S3 Notification
resource "aws_s3_bucket_notification" "notify" {
  bucket = aws_s3_bucket.bucket.id

  queue {
    queue_arn = aws_sqs_queue.queue.arn
    events    = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_sqs_queue_policy.policy]
}

# SQS Trigger Lambda
resource "aws_lambda_event_source_mapping" "mapping" {
  event_source_arn = aws_sqs_queue.queue.arn
  function_name    = aws_lambda_function.lambda.arn
  batch_size       = 1
}
