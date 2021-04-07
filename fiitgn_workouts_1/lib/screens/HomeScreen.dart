import 'package:flutter/material.dart';
import '../models/Exercise_db_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExerciseDbModel> listOfExerciseFromDb = [];

  @override
  void initState() {
    super.initState();
    final exerciseDataProvider =
        Provider.of<GetDataFromGoogleSheetProvider>(context);

    exerciseDataProvider.getListOfExercises();
    listOfExerciseFromDb = exerciseDataProvider.listExercises;
  }
  // TODO: implement initState

  @override
  Widget build(BuildContext context) {
    print(listOfExerciseFromDb);
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
    );
  }
}
