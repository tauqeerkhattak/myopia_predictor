import 'package:flutter/cupertino.dart';

import '../Services/data.dart';

class CustomText extends StatelessWidget {

  final String text;

  CustomText ({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Data.secondaryColor,
      ),
    );
  }
}