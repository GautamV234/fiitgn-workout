import 'package:provider/provider.dart';
// import './screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import './models/Exercise_db_model.dart';
import './models/Admin_db_model.dart';
import './screens/SplashScreen.dart';
import './screens/GetEmailIdScreen.dart';
import './screens/MainScreen.dart';
import './models/Workouts_providers.dart';
import './screens/AllWorkoutsScreen.dart';
import './screens/Create Workout/cwscreen1.dart';
import './screens/Create Workout/cwscreen2.dart';
import './screens/FollowedWorkoutsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GetExerciseDataFromGoogleSheetProvider(),
        ),
        ChangeNotifierProvider.value(
          value: GetAdminDataFromGoogleSheetProvider(),
        ),
        ChangeNotifierProvider.value(
          value: WorkoutsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'FIITGN Workouts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          AllWorkoutsScreen.routeName: (ctx) => AllWorkoutsScreen(),
          GetEmailIdScreen.routeName: (ctx) => GetEmailIdScreen(),
          MainScreen.routeName: (ctx) => MainScreen(),
          CWScreen1.routeName: (ctx) => CWScreen1(),
          CWScreen2.routeName: (ctx) => CWScreen2(),
          FollowedWorkoutsScreen.routeName: (ctx) => FollowedWorkoutsScreen(),
        },
      ),
    );
  }
}
