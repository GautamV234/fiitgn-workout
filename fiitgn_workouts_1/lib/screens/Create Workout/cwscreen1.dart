// This Screen has code to take input for the name of the Workout
// Will later also ask for description and image and stuff
//

import 'package:fiitgn_workouts_1/models/Admin_db_model.dart';
import 'package:fiitgn_workouts_1/models/Workouts_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cwscreen2.dart';

class CWScreen1 extends StatefulWidget {
  static const routeName = '\CWScreen1';
  @override
  _CWScreen1State createState() => _CWScreen1State();
}

class _CWScreen1State extends State<CWScreen1> {
  final textController = TextEditingController();
  String access = 'Private';
  String workoutName = 'Null';
  @override
  Widget build(BuildContext context) {
    final adminDataProvider =
        Provider.of<GetAdminDataFromGoogleSheetProvider>(context);
    final workoutDataProvider =
        Provider.of<WorkoutsProvider>(context, listen: false);
    List adminEmailIds = adminDataProvider.getAdminEmailIds();
    if (adminEmailIds.contains(workoutDataProvider.userEmailId.trim())) {
      print("true");
    } else {
      print(adminEmailIds[1]);
      print(workoutDataProvider.userEmailId.trim());
    }
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter the name of Workout',
              ),
            ),
            heightFactor: 10,
          ),

          adminEmailIds.contains(workoutDataProvider.userEmailId.trim())
              ? Column(
                  children: [
                    Text(
                      'Who can view the workout?',
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            workoutName = textController.text;
                            access = 'Public';
                            Map<String, String> passingToCW2Map = Map();
                            passingToCW2Map['access'] = access;
                            passingToCW2Map['workoutName'] = workoutName;
                            Navigator.pushNamed(context, CWScreen2.routeName,
                                arguments: passingToCW2Map);
                          },
                          child: Text('Everyone'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            access = 'Private';
                            workoutName = textController.text;
                            Map<String, String> passingToCW2Map = Map();
                            passingToCW2Map['access'] = access;
                            passingToCW2Map['workoutName'] = workoutName;
                            Navigator.pushNamed(context, CWScreen2.routeName,
                                arguments: passingToCW2Map);
                            Navigator.pushNamed(context, CWScreen2.routeName,
                                arguments: passingToCW2Map);
                          },
                          child: Text('Only me'),
                        )
                      ],
                    )
                  ],
                )
              : RaisedButton(
                  onPressed: () {
                    workoutName = textController.text;
                    access = 'Private';
                    Map<String, String> passingToCW2Map = Map();
                    passingToCW2Map['access'] = access;
                    passingToCW2Map['workoutName'] = workoutName;
                    Navigator.pushNamed(context, CWScreen2.routeName,
                        arguments: passingToCW2Map);
                    Navigator.pushNamed(context, CWScreen2.routeName,
                        arguments: passingToCW2Map);
                  },
                  child: Text('Next'),
                ),
          // RaisedButton(
          //   onPressed: () {
          //     userEmailId = textController.text;
          //     workoutDataProvider.setUserEmailId(userEmailId);
          //     print(userEmailId);
          //     Navigator.pushReplacementNamed(context, MainScreen.routeName);
          //   },
          //   child: Text('Done'),
          // ),
        ],
      ),
    );
  }
}
