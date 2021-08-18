import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myopia_predictor/Models/background.dart';
import 'package:myopia_predictor/Models/custom_dialog.dart';
import 'package:myopia_predictor/Screens/home.dart';
import 'package:myopia_predictor/Screens/register.dart';
import 'package:myopia_predictor/Services/data.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: Container(
          child: Image.asset('assets/images/ripple.gif',fit: BoxFit.fill,),
        ),
        child: Background(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Data.primaryColor,
                        fontSize: 36,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Email: ',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email can\'t be empty!';
                      } else if (!(value.contains('@'))) {
                        return 'Please enter a valid email!';
                      } else if (!(value.contains('.com'))) {
                        return 'Please enter a valid email!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password can\'t be empty!';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(fontSize: 12, color: Data.primaryColor,),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          isLoading = true;
                        });
                        String email = emailController.text;
                        String password = passwordController.text;
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password)
                            .then((value) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return Home();
                          }), (route) => false);
                        }).catchError((error) {
                          setState(() {
                            isLoading = false;
                          });
                          print(error.code);
                          if (error.code == 'invalid-password') {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Error',
                                    subtitle: 'Invalid Password',
                                    primaryAction: () {
                                      Navigator.pop(context);
                                    },
                                    primaryActionText: 'Okay',
                                  );
                                },);
                          } else if (error.code == 'user-not-found') {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Error',
                                    subtitle:
                                        'Email not found in our database!',
                                    primaryAction: () {
                                      Navigator.pop(context);
                                    },
                                    primaryActionText: 'Okay',
                                  );
                                });
                          }
                          else {
                            setState(() {
                              isLoading = false;
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Error',
                                    subtitle: error.code,
                                    primaryActionText: 'Okay',
                                    primaryAction: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                }
                            );
                          }
                        });
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                      ),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(0),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: new LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()))
                    },
                    child: Text(
                      "Don't Have an Account? Sign up",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Data.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
