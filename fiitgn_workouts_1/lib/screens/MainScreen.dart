import 'package:fiitgn_workouts_1/screens/Create%20Workout/cwscreen1.dart';
import 'package:flutter/material.dart';
import './AllWorkoutsScreen.dart';
import 'Create Workout/cwscreen1.dart';
import './FollowedWorkoutsScreen.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '\MainScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: ListView(
        children: [
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, CWScreen1.routeName);
              },
              child: Text(
                'Create Workout',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, AllWorkoutsScreen.routeName);
              },
              child: Text(
                'View All Workouts',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, FollowedWorkoutsScreen.routeName);
              },
              child: Text(
                'Workouts You Follow',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                'Start Workout',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                'Schedule Your Workout',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
