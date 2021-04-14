import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WorkoutModel {
  final String creatorId;
  final String workoutId;
  final String workoutName;
  final String access;
  final String creationDate;
  final List<String> listOfFollowersId;
  final List<String> listOfExercisesId;
  final String description;
  final String imageUrl;

  WorkoutModel({
    @required this.creatorId,
    @required this.workoutId,
    @required this.workoutName,
    @required this.access,
    @required this.creationDate,
    @required this.listOfExercisesId,
    @required this.listOfFollowersId,
    this.description,
    this.imageUrl,
  });

  // factory WorkoutModel.fromJson(dynamic json) {
  //   return WorkoutModel(
  //       emailId: "${json['id']}",
  //       uniqueId: "${json['url']}",
  //       name: "${json['name']}");
  // }

  // Method to make GET parameters.
  // Map toJson() => {
  //       'id': emailId,
  //       'name': name,
  //       'url': uniqueId,
  //     };
  //

}
