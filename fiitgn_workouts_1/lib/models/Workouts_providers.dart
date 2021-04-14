import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/WorkoutModel.dart';
import '../models/Exercise_db_model.dart';

class WorkoutsProvider with ChangeNotifier {
  String _userEmailId;
  String _usersCurrentWorkout;

  // final databaseReference = Firestore.instance;

  // TO DO
  // get the lists of workouts for users
  //
  // let user create a workout
  //
  // show the followers for the workouts
  //
  // let user follow a workout
  //
  // let users use specific workouts
  //
  // let workout creators invite people for workout
  //

  List<WorkoutModel> _workoutsList = [];

  // set user email id;
  //
  setUserEmailId(String emailId) {
    _userEmailId = emailId;
    print("user email id set");
  }

  List<WorkoutModel> get workoutList {
    return [..._workoutsList];
  }

  String get userEmailId {
    return _userEmailId;
  }

  showAllExercises() {
    final exerciseDataProvider = GetExerciseDataFromGoogleSheetProvider();
    List exercises = exerciseDataProvider.listExercises;
  }

  createWorkoutAndAddToDB(String creatorId, String workoutName, String access,
      List<String> listOfExercisesId, List<String> listOfFollowersId) async {
    // finding the time of creation
    final time = DateTime.now();
    final String dateOfCreationOfWorkout = time.toIso8601String();

    const url =
        "https://fiitgn-workouts-default-rtdb.firebaseio.com/Workouts.json";

    return http
        .post(
      url,
      body: json.encode(
        {
          'creatorId': creatorId,
          'creationDate': dateOfCreationOfWorkout,
          'workoutName': workoutName,
          'access': access,
          'listOfExercisesId': listOfExercisesId,
          'listOfFollowersId': listOfFollowersId,
        },
      ),
    )
        .then(
      (response) {
        var workoutId = json.decode(response.body)['name'];
        print(workoutId);
        WorkoutModel newWorkout = WorkoutModel(
            creatorId: creatorId,
            workoutId: workoutId,
            creationDate: dateOfCreationOfWorkout,
            workoutName: workoutName,
            access: access,
            listOfExercisesId: listOfExercisesId,
            listOfFollowersId: listOfFollowersId);
        _workoutsList.add(newWorkout);
        notifyListeners();
        // print(newWorkout.listOfExercisesId);
      },
    ).catchError(
      (error) {
        print(error);
      },
    );
    //  get the list of all exercises
  }

  Future<void> showAllWorkouts() async {
    const url =
        "https://fiitgn-workouts-default-rtdb.firebaseio.com/Workouts.json";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map;
      final List<WorkoutModel> loadedList = [];

      extractedData.forEach(
        (statId, statValue) {
          final List<String> tempListExerciseId = [];
          final List<String> tempListFollowersId = [];
          List x = statValue['listOfExercisesId'];
          x.forEach((element) {
            tempListExerciseId.add(element.toString());
          });
          List y = statValue['listOfFollowersId'];
          y.forEach((element) {
            tempListFollowersId.add(element.toString());
          });
          loadedList.add(
            WorkoutModel(
              creatorId: statValue['creatorId'],
              workoutId: statId,
              workoutName: statValue['workoutName'],
              access: statValue['access'],
              creationDate: statValue['creationDate'],
              listOfExercisesId: tempListExerciseId,
              listOfFollowersId: tempListFollowersId,
            ),
          );
        },
      );
      List<WorkoutModel> filteredList = [];
      loadedList.forEach(
        (element) {
          if (element.access == 'Public' ||
              (element.access == 'Private' &&
                  element.listOfFollowersId.contains(_userEmailId))) {
            filteredList.add(element);
          }
        },
      );
      _workoutsList = filteredList;
      notifyListeners();
      // return _workoutsList;
    } catch (e) {
      print(e);
    }
  }

  Future<void> followWorkout(WorkoutModel workout, String workoutId) async {
    final url =
        "https://fiitgn-workouts-default-rtdb.firebaseio.com/Workouts/$workoutId.json";
    List followers = workout.listOfFollowersId;
    followers.add(_userEmailId);
    try {
      await http.patch(url,
          body: json.encode({
            'access': workout.access,
            'creationDate': workout.creationDate,
            'creatorId': workout.creatorId,
            'workoutName': workout.workoutName,
            'listOfExercisesId': workout.listOfExercisesId,
            'listOfFollowersId': followers,
          }));
      print("follower list has been updated");
      WorkoutModel updatedWorkout = WorkoutModel(
        creatorId: workout.creatorId,
        workoutId: workout.workoutId,
        workoutName: workout.workoutName,
        access: workout.access,
        creationDate: workout.creationDate,
        listOfExercisesId: workout.listOfExercisesId,
        listOfFollowersId: followers,
      );
      int index =
          _workoutsList.indexWhere((element) => element.workoutId == workoutId);
      _workoutsList[index] = updatedWorkout;
      print(_workoutsList[index].listOfFollowersId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> unFollowWorkout(WorkoutModel workout, String workoutId) async {
    final url =
        "https://fiitgn-workouts-default-rtdb.firebaseio.com/Workouts/$workoutId.json";
    List followers = workout.listOfFollowersId;
    followers.remove(_userEmailId);
    try {
      await http.patch(url,
          body: json.encode({
            'access': workout.access,
            'creationDate': workout.creationDate,
            'creatorId': workout.creatorId,
            'workoutName': workout.workoutName,
            'listOfExercisesId': workout.listOfExercisesId,
            'listOfFollowersId': followers,
          }));
      print("user has been unfollowed");
      WorkoutModel updatedWorkout = WorkoutModel(
        creatorId: workout.creatorId,
        workoutId: workout.workoutId,
        workoutName: workout.workoutName,
        access: workout.access,
        creationDate: workout.creationDate,
        listOfExercisesId: workout.listOfExercisesId,
        listOfFollowersId: followers,
      );
      int index =
          _workoutsList.indexWhere((element) => element.workoutId == workoutId);
      _workoutsList[index] = updatedWorkout;
      print(_workoutsList[index].listOfFollowersId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<WorkoutModel> followedWorkouts() {
    List<WorkoutModel> followedWorkoutsList = [];
    _workoutsList.forEach((element) {
      if (element.listOfFollowersId.contains(_userEmailId)) {
        followedWorkoutsList.add(element);
      }
      // return followedWorkoutsList;
    });
    return followedWorkoutsList;
  }
}
