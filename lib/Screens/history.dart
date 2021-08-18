import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myopia_predictor/Services/data.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        backgroundColor: Data.primaryColor,
      ),
      body: HistoryBody(),
    );
  }
}

class HistoryBody extends StatefulWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  _HistoryBodyState createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  
  User? user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Prediction Data').doc(user!.email).snapshots(),
        builder: (BuildContext context, AsyncSnapshot <DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            List <dynamic> data = List.castFrom(snapshot.data!.get('Data'));
            print(data.length);
            return ListView(
              children: List.generate(data.length, (index) {
                return Card(
                  elevation: 10.0,
                  shadowColor: Data.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: EdgeInsets.only(top: 15,left: 15,right: 15,),
                  child: ListTile(
                    title: Text(
                      data[index]['prediction'],
                      style: TextStyle(
                        color: Data.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {

                      },
                    ),
                    subtitle: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15,),
                                child: Text(
                                  'Accuracy: ',
                                  style: TextStyle(
                                    color: Data.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15,),
                                child: Text(
                                  '${data[index]['accuracy']}%',
                                  style: TextStyle(
                                    color: Data.secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15,),
                                child: Text(
                                  'Model Used: ',
                                  style: TextStyle(
                                    color: Data.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15,),
                                child: Text(
                                  data[index]['model'],
                                  style: TextStyle(
                                    color: Data.secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,bottom: 15,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15,),
                                child: Text(
                                  'Date: ',
                                  style: TextStyle(
                                    color: Data.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15,),
                                child: Text(
                                  data[index]['data'].toString().split(' ')[0],
                                  style: TextStyle(
                                    color: Data.secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}



