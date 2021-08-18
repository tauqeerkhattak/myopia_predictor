import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myopia_predictor/Models/faq.dart';
import 'package:myopia_predictor/Services/data.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Myopia'),
        centerTitle: true,
        backgroundColor: Data.primaryColor,
      ),
      body: AboutBody(),
    );
  }
}

class AboutBody extends StatefulWidget {
  const AboutBody({Key? key}) : super(key: key);

  @override
  _AboutBodyState createState() => _AboutBodyState();
}

class _AboutBodyState extends State<AboutBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView(
        children: [
          FAQ(
            title: 'What is Myopia?',
            answer: Data.whatIsMyopia,
          ),
          FAQ(
            title: 'How to confirm Myopia?',
            answer: Data.confirmMyopia,
          ),
          FAQ(
            title: 'Symptoms of Myopia',
            answer: Data.symptomsOfMyopia,
          ),
          FAQ(
            title: 'Risk Factors',
            answer: Data.riskFactors,
          ),
          FAQ(
            title: 'Treatment',
            answer: Data.treatment,
          ),
          FAQ(
            title: 'Learn more about Myopia',
            answer: 'Learn all more about Myopia and all other vision problems at:\nhttps://www.aao.org/eye-health/diseases/myopia-nearsightedness.',
          ),
        ],
      ),
    );
  }
}
