import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myopia_predictor/Models/custom_dialog.dart';
import 'package:myopia_predictor/Models/custom_text.dart';
import 'package:myopia_predictor/Screens/results.dart';
import 'package:myopia_predictor/Services/api.dart';
import 'package:myopia_predictor/Services/data.dart';
import 'package:numberpicker/numberpicker.dart';

class PredictMyopia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Myopia Predictor',
        ),
        centerTitle: true,
        backgroundColor: Data.primaryColor,
      ),
      body: PredictMyopiaBody(),
    );
  }
}

class PredictMyopiaBody extends StatefulWidget {
  const PredictMyopiaBody({Key? key}) : super(key: key);

  @override
  _PredictMyopiaBodyState createState() => _PredictMyopiaBodyState();
}

enum Genders { male, female }
enum Studying { yes, no }
enum UniversityStudent { freshman, sophomore, junior, senior }
enum Parents { zero, one, both }
enum Smoking { never, partly, addicted }
enum Glasses { yes, no }
enum GParentsM { none, one, two }
enum GParentsP { none, one, two }

class _PredictMyopiaBodyState extends State<PredictMyopiaBody> {

  Genders? gender;
  Studying? study;
  UniversityStudent? student;
  Parents? parent;
  Smoking? smoking;
  Glasses? glasses;
  GParentsP? gParentsP;
  GParentsM? gParentsM;
  int age = 16,
      numberOfSiblings = 0,
      eyeExamFrequency = 0,
      readingTime = 0,
      booksRead = 0,
      distanceBook = 10,
      indoorAct = 0,
      outdoorAct = 0,
      sleepingTime = 0,
      averageTimeExercising = 0;
  bool studying = false, _isSaving = false;
  int currentStep = 0;
  String timeToSleep = '', timeToWakeUp = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        isLoading: _isSaving,
        progressIndicator: Container(
          child: Image.asset('assets/images/ripple.gif',fit: BoxFit.fill,),
        ),
        child: Container(
          child: Theme(
            data: ThemeData(
              primarySwatch: Data.primaryColor,
            ),
            child: Stepper(
              steps: [
                Step(
                  title: CustomText(
                    text: 'Personal Information',
                  ),
                  subtitle: CustomText(
                    text:
                        'We will need some personal information from you first!',
                  ),
                  isActive: true,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Please select your gender: '),
                      RadioListTile(
                        dense: true,
                        title: Text('Male'),
                        value: Genders.male,
                        groupValue: gender,
                        onChanged: (Genders? value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('Female'),
                        value: Genders.female,
                        groupValue: gender,
                        onChanged: (Genders? value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Please select your age: ',
                      ),
                      NumberPicker(
                        value: age,
                        minValue: 0,
                        maxValue: 60,
                        haptics: true,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            age = newValue;
                          });
                        },
                      ),
                      CustomText(text: 'Are you a university student: '),
                      RadioListTile(
                        dense: true,
                        title: Text('Yes'),
                        value: Studying.yes,
                        groupValue: study,
                        onChanged: (Studying? value) {
                          setState(() {
                            study = value;
                            studying = true;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('No'),
                        value: Studying.no,
                        groupValue: study,
                        onChanged: (Studying? value) {
                          setState(() {
                            study = value;
                            studying = false;
                          });
                        },
                      ),
                      if (studying)
                        CustomText(
                          text: 'Which year do you study in: ',
                        ),
                      if (studying)
                        RadioListTile(
                          dense: true,
                          title: Text('Freshman'),
                          value: UniversityStudent.freshman,
                          groupValue: student,
                          onChanged: (UniversityStudent? value) {
                            setState(() {
                              student = value;
                            });
                          },
                        ),
                      if (studying)
                        RadioListTile(
                          dense: true,
                          title: Text('Sophomore'),
                          value: UniversityStudent.sophomore,
                          groupValue: student,
                          onChanged: (UniversityStudent? value) {
                            setState(() {
                              student = value;
                            });
                          },
                        ),
                      if (studying)
                        RadioListTile(
                          dense: true,
                          title: Text('Junior'),
                          value: UniversityStudent.junior,
                          groupValue: student,
                          onChanged: (UniversityStudent? value) {
                            setState(() {
                              student = value;
                            });
                          },
                        ),
                      if (studying)
                        RadioListTile(
                          dense: true,
                          title: Text('Senior'),
                          value: UniversityStudent.senior,
                          groupValue: student,
                          onChanged: (UniversityStudent? value) {
                            print(value);
                            setState(() {
                              student = value;
                            });
                          },
                        ),
                    ],
                  ),
                ),
                Step(
                  title: CustomText(
                    text: 'Hereditary Information',
                  ),
                  subtitle: CustomText(
                    text:
                        'Now we need data about your hereditary meaning about your family.',
                  ),
                  isActive: true,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Number of your parents wearing glasses: ',
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('None'),
                        value: Parents.zero,
                        groupValue: parent,
                        onChanged: (Parents? value) {
                          setState(() {
                            parent = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('One'),
                        value: Parents.one,
                        groupValue: parent,
                        onChanged: (Parents? value) {
                          setState(() {
                            parent = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('Both'),
                        value: Parents.both,
                        groupValue: parent,
                        onChanged: (Parents? value) {
                          setState(() {
                            parent = value;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Number of your grandparents wearing glasses: ',
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 5,
                        ),
                        child: CustomText(
                          text: 'From your father\'s side',
                        ),
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('None'),
                        value: GParentsP.none,
                        groupValue: gParentsP,
                        onChanged: (GParentsP? value) {
                          setState(() {
                            gParentsP = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('One'),
                        value: GParentsP.one,
                        groupValue: gParentsP,
                        onChanged: (GParentsP? value) {
                          setState(() {
                            gParentsP = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('Both'),
                        value: GParentsP.two,
                        groupValue: gParentsP,
                        onChanged: (GParentsP? value) {
                          setState(() {
                            gParentsP = value;
                          });
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 5,
                        ),
                        child: CustomText(
                          text: 'From your mother\'s side',
                        ),
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('None'),
                        value: GParentsM.none,
                        groupValue: gParentsM,
                        onChanged: (GParentsM? value) {
                          setState(() {
                            gParentsM = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('One'),
                        value: GParentsM.one,
                        groupValue: gParentsM,
                        onChanged: (GParentsM? value) {
                          setState(() {
                            gParentsM = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('Both'),
                        value: GParentsM.two,
                        groupValue: gParentsM,
                        onChanged: (GParentsM? value) {
                          setState(() {
                            gParentsM = value;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Number of your siblings wearing glasses: ',
                      ),
                      NumberPicker(
                        value: numberOfSiblings,
                        minValue: 0,
                        maxValue: 10,
                        haptics: true,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            numberOfSiblings = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Step(
                  title: CustomText(
                    text: 'Behavioral Information',
                  ),
                  subtitle: CustomText(
                    text:
                        'We require information about some of your behaviours as well.',
                  ),
                  isActive: true,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Tobacco smoking status:',
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('Never'),
                        value: Smoking.never,
                        groupValue: smoking,
                        onChanged: (Smoking? value) {
                          setState(() {
                            smoking = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('Partly'),
                        value: Smoking.partly,
                        groupValue: smoking,
                        onChanged: (Smoking? value) {
                          setState(() {
                            smoking = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('Addicted'),
                        value: Smoking.addicted,
                        groupValue: smoking,
                        onChanged: (Smoking? value) {
                          setState(() {
                            smoking = value;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Do you wear glasses: ',
                      ),
                      RadioListTile(
                        dense: true,
                        title:
                            Text('Yes, I wear them all the time or some times'),
                        value: Glasses.yes,
                        groupValue: glasses,
                        onChanged: (Glasses? value) {
                          setState(() {
                            glasses = value;
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text('No, I do not wear glasses anytime'),
                        value: Glasses.no,
                        groupValue: glasses,
                        onChanged: (Glasses? value) {
                          setState(() {
                            glasses = value;
                          });
                        },
                      ),
                      CustomText(text: 'Eye examination frequency (in months): '),
                      NumberPicker(
                        value: eyeExamFrequency,
                        minValue: 0,
                        maxValue: 30,
                        haptics: true,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            eyeExamFrequency = newValue;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Daily time spent reading (in hours):',
                      ),
                      NumberPicker(
                        value: readingTime,
                        minValue: 0,
                        maxValue: 24,
                        haptics: true,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            readingTime = newValue;
                          });
                        },
                      ),
                      CustomText(
                        text:
                            'Number of books read each week excluding curriculum: ',
                      ),
                      NumberPicker(
                        value: booksRead,
                        minValue: 0,
                        maxValue: 5,
                        haptics: true,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            booksRead = newValue;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Distance between books and your eyes (in inches): ',
                      ),
                      NumberPicker(
                        value: distanceBook,
                        minValue: 5,
                        maxValue: 40,
                        step: 5,
                        haptics: true,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            distanceBook = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Step(
                  title: CustomText(
                    text: 'Environment Information',
                  ),
                  subtitle: CustomText(
                    text:
                        'These are the information regarding your environment and how you interact with it',
                  ),
                  isActive: true,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Time spent in indoor activities (in hours): ',
                      ),
                      NumberPicker(
                        value: indoorAct,
                        minValue: 0,
                        maxValue: 24,
                        haptics: true,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            indoorAct = newValue;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Time spent in outdoor activities (in hours): ',
                      ),
                      NumberPicker(
                        value: outdoorAct,
                        minValue: 0,
                        maxValue: 24,
                        haptics: true,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            outdoorAct = newValue;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Average time you sleep every night: ',
                      ),
                      NumberPicker(
                        value: sleepingTime,
                        minValue: 0,
                        maxValue: 15,
                        haptics: true,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            sleepingTime = newValue;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Time when do you go to sleep at night: ',
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.time,
                        initialTime: TimeOfDay(hour: 22, minute: 0),
                        onChanged: (val) {
                          timeToSleep = val;
                        },
                      ),
                      CustomText(
                        text: 'Time when you wake up in the morning: ',
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.time,
                        initialTime: TimeOfDay(hour: 8, minute: 0),
                        onChanged: (val) {
                          timeToWakeUp = val;
                          print(timeToWakeUp);
                        },
                      ),
                      CustomText(
                        text: 'Average time spent exercising daily: ',
                      ),
                      NumberPicker(
                        value: averageTimeExercising,
                        minValue: 0,
                        maxValue: 5,
                        haptics: true,
                        step: 1,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Data.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        itemHeight: 80,
                        onChanged: (int newValue) {
                          setState(() {
                            averageTimeExercising = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
              currentStep: currentStep,
              type: StepperType.vertical,
              onStepContinue: () async {
                if (currentStep == 0) {
                  print('Working for Personal Information');
                  if (gender != null && study != null) {
                    if (currentStep != 2) {
                      setState(() {
                        currentStep++;
                      });
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: 'Empty values',
                            subtitle: 'Please fill all values before continuing.',
                            primaryActionText: 'Okay',
                            primaryAction: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  }
                } else if (currentStep == 1) {
                  print('Working for Hereditary Information');
                  if (parent != null) {
                    if (currentStep != 2) {
                      setState(() {
                        currentStep++;
                      });
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: 'Empty values',
                            subtitle: 'Please fill all the values first!',
                            primaryActionText: 'Okay',
                            primaryAction: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  }
                } else if (currentStep == 2) {
                  print('Working for Behavioral Information');
                  if (smoking != null && glasses != null) {
                    if (currentStep != 3) {
                      setState(() {
                        currentStep++;
                      });
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          title: 'Empty values',
                          subtitle: 'Please fill all the values first!',
                          primaryActionText: 'Okay',
                          primaryAction: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                } else if (currentStep == 3) {
                  print('Working for Environmental Information');
                  if (timeToSleep.isNotEmpty && timeToWakeUp.isNotEmpty) {
                    print('All Set!');
                    setState(() {
                      _isSaving = true;
                    });
                    String url = composeData();
                    print(url);
                    await getData(Uri.parse(url)).then((value) {
                      setState(() {
                        _isSaving = false;
                      });
                      print(value);
                      var jsonObject = jsonDecode(value);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Results(json: jsonObject,);
                        }
                      )).then((value) {
                        Navigator.pop(context);
                      });
                    }).catchError((onError) {
                      setState(() {
                        _isSaving = false;
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
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          title: 'Empty values',
                          subtitle: 'Please fill all the values first!',
                          primaryActionText: 'Okay',
                          primaryAction: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                }
              },
              onStepCancel: () {
                if (currentStep != 0) {
                  setState(() {
                    currentStep--;
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  String composeData() {
    int genderInt = 0,
        studyInt = 0,
        parentsInt = 0,
        gParentsInt = 0,
        smokingInt = 0,
        glassesInt = 0,
        timeWhenYouSleepInt = 0,
        timeWhenYouWakeUpInt = 0;

    // Gender Male = 0, Female = 1
    if (gender == Genders.male) {
      genderInt = 0;
    } else {
      genderInt = 1;
    }

    //Study Not Studying = 0, Freshman = 1, Sophomore = 2, Junior = 3, Senior = 4
    if (study == Studying.no) {
      studyInt = 0;
    } else {
      if (student == UniversityStudent.freshman) {
        studyInt = 1;
      } else if (student == UniversityStudent.sophomore) {
        studyInt = 2;
      } else if (student == UniversityStudent.junior) {
        studyInt = 3;
      } else if (student == UniversityStudent.senior) {
        studyInt = 4;
      }
    }

    //Parents zero = 0, one = 1, both = 2
    if (parent == Parents.zero) {
      parentsInt = 0;
    } else if (parent == Parents.one) {
      parentsInt = 1;
    } else if (parent == Parents.both) {
      parentsInt = 2;
    }

    //GrandParents
    if (gParentsP == GParentsP.none) {
      gParentsInt += 0;
    }
    else if (gParentsP == GParentsP.one) {
      gParentsInt += 1;
    }
    else if (gParentsP == GParentsP.two) {
      gParentsInt += 2;
    }
    if (gParentsM == GParentsM.none) {
      gParentsInt += 0;
    }
    else if (gParentsM == GParentsM.one) {
      gParentsInt += 1;
    }
    else if (gParentsM == GParentsM.two) {
      gParentsInt += 2;
    }

    //Smoking Never = 0, Partly = 1, Addicted = 2
    if (smoking == Smoking.never) {
      smokingInt = 0;
    }
    else if (smoking == Smoking.partly) {
      smokingInt = 1;
    }
    else if (smoking == Smoking.addicted) {
      smokingInt = 2;
    }

    //Glasses No = 0, Yes = 1
    if (glasses == Glasses.no) {
      glassesInt = 0;
    }
    else if (glasses == Glasses.yes) {
      glassesInt = 1;
    }

    //Sleeping Time
    int sleepingTimeInt = int.parse('$sleepingTime'+'00');

    //Time when you go to Sleep
    timeWhenYouSleepInt = int.parse(timeToSleep.replaceAll(':', ''));
    print(timeWhenYouSleepInt);

    //Time when you wake Up
    timeWhenYouWakeUpInt = int.parse(timeToWakeUp.replaceAll(':', ''));
    print(timeWhenYouWakeUpInt);

    return 'https://calm-escarpment-52632.herokuapp.com/?model=SVM&gender=$genderInt&age=$age&study=$studyInt&parents=$parentsInt&gparents=$gParentsInt&siblings=$numberOfSiblings&smoking=$smokingInt&glasses=$glassesInt&eyeExam=$eyeExamFrequency&indoorAct=$indoorAct&readingTime=$readingTime&books=$booksRead&bookDistance=$distanceBook&outdoorAct=$outdoorAct&sleepingTime=$sleepingTimeInt&goToSleep=$timeWhenYouSleepInt&wakeUpTime=$timeWhenYouWakeUpInt&exercise=$averageTimeExercising';
  }
}
