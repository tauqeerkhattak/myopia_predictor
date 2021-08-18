import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myopia_predictor/Screens/history.dart';
import 'package:myopia_predictor/Screens/home.dart';
import 'package:myopia_predictor/Screens/login.dart';
import 'package:myopia_predictor/Services/data.dart';

class CustomDrawer extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.35,
              child: Center(
                child: Text(
                  'Myopia Predictor',
                  style: TextStyle(
                    color: Data.primaryColor,
                    fontSize: 22,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(
              indent: 50,
              endIndent: 50,
              color: Data.primaryColor,
              thickness: 2.0,
            ),
            (user == null)
                ? InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Login();
                      }),
                );
              },
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.login,
                            color: Data.primaryColor,
                            size: 26,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Data.primaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                )
                : InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return History();
                  }
                ),);
              },
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.history,
                            color: Data.primaryColor,
                            size: 26,
                          ),
                          Text(
                            'History',
                            style: TextStyle(
                              color: Data.primaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
            if (user != null) InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Home();
                      }
                  ), (route) => false);
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Data.primaryColor,
                      size: 26,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Data.primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
