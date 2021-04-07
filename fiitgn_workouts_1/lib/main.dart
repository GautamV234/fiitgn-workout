import 'package:provider/provider.dart';
import './screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import './models/Exercise_db_model.dart';
import './models/Admin_db_model.dart';

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
          value: GetDataFromGoogleSheetProvider(),
        ),
        ChangeNotifierProvider.value(
          value: GetAdminDataFromGoogleSheetProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
