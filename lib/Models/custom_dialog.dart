import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Services/data.dart';

class CustomDialog extends StatelessWidget {

  final String title, subtitle,primaryActionText;
  final primaryAction;

  CustomDialog({
    required this.title,
    required this.subtitle,
    required this.primaryActionText,
    required this.primaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Data.primaryColor,
        ),
      ),
      content: Text(subtitle),
      actions: [
        TextButton(
          child: Text(
            primaryActionText,
            style: TextStyle(
              color: Data.primaryColor,
            ),
          ),
          onPressed: primaryAction,
        ),
      ],
    );
  }
}