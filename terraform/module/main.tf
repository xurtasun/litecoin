resource "aws_iam_role" "this" {
  name        = var.name
  path        = "/"
  description = "${var.name} role"

  assume_role_policy = data.aws_iam_policy_document.user_assume_role_policy.json
}

data "aws_iam_policy_document" "user_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::444444444444:${var.name}"]
    }
  }
}

data "aws_iam_policy_document" "sts_assumerole_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::444444444444:role/${var.name}"
    ]
  }
}

resource "aws_iam_policy" "sts_assumerole_policy" {
  name        = "sts_assumerole_policy"
  path        = "/"
  description = "sts_assumerole_policy"

  policy = data.aws_iam_policy_document.sts_assumerole_policy_document.json
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.sts_assumerole_policy.arn
}

resource "aws_iam_group" "this" {
  name = var.name
  path = "/"
}

resource "aws_iam_user" "this" {
  name = var.name
  path = "/"
}

resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.this.name

  groups = [
    aws_iam_group.this.name
  ]
}
