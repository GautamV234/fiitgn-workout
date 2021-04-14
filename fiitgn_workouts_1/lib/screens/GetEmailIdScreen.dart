import 'package:flutter/material.dart';
import '../models/Workouts_providers.dart';
import 'package:provider/provider.dart';
import './MainScreen.dart';

class GetEmailIdScreen extends StatefulWidget {
  static const routeName = 'getEmailIdScreen';
  @override
  _GetEmailIdScreenState createState() => _GetEmailIdScreenState();
}

class _GetEmailIdScreenState extends State<GetEmailIdScreen> {
  final textController = TextEditingController();
  String userEmailId = 'null';

  @override
  Widget build(BuildContext context) {
    final workoutDataProvider =
        Provider.of<WorkoutsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("FIITGN Workouts"),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Welcome to FIITGN Workouts',
              style: TextStyle(fontSize: 20),
            ),
            heightFactor: 11,
          ),
          Center(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter your iitgn mail id',
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              userEmailId = textController.text;
              workoutDataProvider.setUserEmailId(userEmailId);
              print(userEmailId);
              Navigator.pushReplacementNamed(context, MainScreen.routeName);
            },
            child: Text('Done'),
          )
        ],
      ),
    );
  }
}
