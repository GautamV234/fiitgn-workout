import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';
import './GetEmailIdScreen.dart';
import 'package:provider/provider.dart';
import '../models/Admin_db_model.dart';
import '../models/Exercise_db_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(Duration(seconds: 5), () async {
  //     Navigator.pushNamed(context, GetEmailIdScreen.routeName);
  //     // final prefs = await SharedPreferences.getInstance();
  //     // final signedInStatus = prefs.getBool('signedInStatus');
  //   });
  // }

  var isInit = true;
  @override
  void didChangeDependencies() async {
    print("dependencies were changed");
    Timer(
      Duration(seconds: 1),
      () async {
        if (isInit) {
          final exerciseDataProvider =
              Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
                  listen: false);
          final adminDataProvider =
              Provider.of<GetAdminDataFromGoogleSheetProvider>(context,
                  listen: false);
          try {
            await exerciseDataProvider.getListOfExercises();
            print("b");
            await adminDataProvider.getListOfAdmins();
            print("a");
          } catch (e) {
            print("Error");
          }
          print(adminDataProvider.listAdmin[0].name);
          print(adminDataProvider.listAdmin[0].emailId);
          Navigator.pushReplacementNamed(context, GetEmailIdScreen.routeName);
        }
        isInit = false;
      },
    );
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height / 10,
            //   width: MediaQuery.of(context).size.width / 5,
            //   child: Image.asset(
            //     "assets/iitgnlogo-emblem.png",
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 25.7125,
                  MediaQuery.of(context).size.width / 51.425,
                  MediaQuery.of(context).size.width / 25.7125,
                  0),
              child: Text(
                "FIITGN Workouts",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 7,
                    color: Colors.black),
              ),
            ),
            TypewriterAnimatedTextKit(
              onTap: () {
                // print("Tap Event");
              },
              text: [
                'loading',
              ],
              textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                  color: Colors.grey),
            ),
            // CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
