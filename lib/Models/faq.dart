import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myopia_predictor/Services/data.dart';

class FAQ extends StatelessWidget {

  final String title, answer;

  FAQ({required this.title, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        this.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Data.primaryColor,
        ),
      ),
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            this.answer,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}