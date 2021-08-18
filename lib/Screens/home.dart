import 'package:flutter/material.dart';
import 'package:myopia_predictor/Models/drawer.dart';
import 'package:myopia_predictor/Screens/predict_myopia.dart';

import '../Services/data.dart';
import 'about.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
      drawer: CustomDrawer(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.dehaze,
                  color: Data.primaryColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Myopia',
                    style: TextStyle(
                      color: Data.primaryColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                  Text(
                    'Predictor',
                    style: TextStyle(
                      color: Data.primaryColor,
                      fontSize: 35,
                      letterSpacing: 4.5,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Data.primaryColor,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(
                          10,
                        ),
                        child: Text(
                          'Predict me!',
                          style: TextStyle(
                            color: Data.primaryColor,
                            // fontSize: 25,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return PredictMyopia();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Data.primaryColor,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(
                          10,
                        ),
                        child: Text(
                          'About Myopia',
                          style: TextStyle(
                            color: Data.primaryColor,
                            // fontSize: 25,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return About();
                          }
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
