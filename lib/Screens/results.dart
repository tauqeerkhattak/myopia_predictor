import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myopia_predictor/Models/custom_dialog.dart';
import 'package:myopia_predictor/Screens/login.dart';
import 'package:myopia_predictor/Services/data.dart';

class Results extends StatelessWidget {
  var json;

  Results({
    this.json,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        centerTitle: true,
        backgroundColor: Data.primaryColor,
      ),
      body: ResultsBody(
        json: json,
      ),
    );
  }
}

class ResultsBody extends StatefulWidget {
  var json;

  ResultsBody({this.json});

  @override
  _ResultsBodyState createState() => _ResultsBodyState(json: json);
}

class _ResultsBodyState extends State<ResultsBody> {
  var json;
  bool isLoading = false;
  bool isSaved = false;

  _ResultsBodyState({this.json});

  double roundOff() {
    double newAccuracy = double.parse(json['ModelAccuracy']) * 100;
    newAccuracy = double.parse(newAccuracy.toStringAsFixed(3));
    return newAccuracy;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: Container(
          child: Image.asset(
            'assets/images/ripple.gif',
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  (json['Myopia'] == '0')
                      ? 'You may not encounter Myopia in the near future'
                      : 'You may encounter myopia in the future, precaution is required!',
                  style: TextStyle(
                    color: Data.secondaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        (json['Myopia'] == '0') ? 'Non-Myopic' : 'Myopic',
                        style: TextStyle(
                          color: Data.primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                title: 'Information',
                                subtitle: (json['Myopia'] == '0')
                                    ? Data.nonMyopiaInfo
                                    : Data.myopiaInfo,
                                primaryActionText: 'Okay',
                                primaryAction: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 15,
                          ),
                          child: Icon(
                            Icons.info,
                            color: Data.primaryColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  (json['ModelUsed'] == 'Support Vector Machine')
                      ? 'Model Used: SVM'
                      : '',
                  style: TextStyle(
                    color: Data.secondaryColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  'Accuracy: ${roundOff()}%',
                  style: TextStyle(
                    color: Data.secondaryColor,
                  ),
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  if (!(isSaved)) {
                    setState(() {
                      isLoading = true;
                    });
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await FirebaseFirestore.instance
                          .collection('Prediction Data')
                          .doc(user.email)
                          .get()
                          .then((value) {
                        if (value.exists) {
                          FirebaseFirestore.instance
                              .collection('Prediction Data')
                              .doc(user.email)
                              .update({
                            'Data': FieldValue.arrayUnion([
                              {
                                'data': DateTime.now().toString(),
                                'prediction': (json['Myopia'] == '0')
                                    ? 'Non-Myopic'
                                    : 'Myopic',
                                'accuracy': roundOff(),
                                'model': json['ModelUsed'],
                              },
                            ]),
                          }).then(
                            (value) {
                              setState(() {
                                isLoading = false;
                                isSaved = true;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Success',
                                    subtitle:
                                        'Data saved successfully! You can view in History in main window.',
                                    primaryActionText: 'Okay',
                                    primaryAction: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          ).catchError(
                            (onError) {
                              setState(() {
                                isLoading = false;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Error',
                                    subtitle: onError.toString(),
                                    primaryActionText: 'Okay',
                                    primaryAction: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          FirebaseFirestore.instance
                              .collection('Prediction Data')
                              .doc(user.email)
                              .set({
                            'Data': FieldValue.arrayUnion([
                              {
                                'data': DateTime.now().toString(),
                                'prediction': (json['Myopia'] == '0')
                                    ? 'Non-Myopic'
                                    : 'Myopic',
                                'accuracy': roundOff(),
                                'model': json['ModelUsed'],
                              },
                            ]),
                          }).then(
                            (value) {
                              setState(() {
                                isLoading = false;
                                isSaved = true;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Success',
                                    subtitle:
                                        'Data saved successfully! You can view in History in main window.',
                                    primaryActionText: 'Okay',
                                    primaryAction: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          ).catchError(
                            (onError) {
                              setState(() {
                                isLoading = false;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Error',
                                    subtitle: onError.toString(),
                                    primaryActionText: 'Okay',
                                    primaryAction: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          );
                        }
                      });
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: 'Error',
                            subtitle: 'To save data, you must be logged in!',
                            primaryActionText: 'Login',
                            primaryAction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return Login();
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          title: 'Error',
                          subtitle: 'Data already saved!',
                          primaryActionText: 'Okay',
                          primaryAction: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Text(
                    'Save this session\'s data?',
                    style: TextStyle(
                      color: Data.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
