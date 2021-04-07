import 'package:flutter/material.dart';
import '../models/Exercise_db_model.dart';
import 'package:provider/provider.dart';
import '../models/Admin_db_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseReference = Firestore.instance;
  void getData() {
    databaseReference
        .collection("Workouts")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  var isInit = true;
  List<AdminDbModel> listOfAdminsFromDb = [];
  List<ExerciseDbModel> listOfExerciseFromDb = [];
  @override
  void didChangeDependencies() async {
    print("dependencies were changed");
    if (isInit) {
      final exerciseDataProvider =
          Provider.of<GetDataFromGoogleSheetProvider>(context);
      final adminDataProvider =
          Provider.of<GetAdminDataFromGoogleSheetProvider>(context);
      await exerciseDataProvider.getListOfExercises();
      print("b");
      await adminDataProvider.getListOfAdmins();
      print("a");
      listOfExerciseFromDb = exerciseDataProvider.listExercises;
      listOfAdminsFromDb = adminDataProvider.listAdmin;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    isInit = false;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   final exerciseDataProvider =
  //       Provider.of<GetDataFromGoogleSheetProvider>(context);

  //   exerciseDataProvider.getListOfExercises();
  //   listOfExerciseFromDb = exerciseDataProvider.listExercises;
  // }
  // TODO: implement initState

  @override
  Widget build(BuildContext context) {
    print(listOfExerciseFromDb);
    print(listOfAdminsFromDb);
    getData();
    print("abcabc");
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
    );
  }
}
