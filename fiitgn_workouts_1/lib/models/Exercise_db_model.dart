import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ExerciseDbModel {
  final String exerciseId;
  final String exerciseName;
  final String imageUrl;
  final String description;
  final String category; //TO DO Make an Enum of category types

  ExerciseDbModel({
    @required this.exerciseId,
    @required this.exerciseName,
    @required this.imageUrl,
    @required this.description,
    @required this.category,
  });

  factory ExerciseDbModel.fromJson(dynamic json) {
    return ExerciseDbModel(
        exerciseId: "${json['id']}",
        exerciseName: "${json['name']}",
        imageUrl: "${json['url']}",
        description: "${json['description']}",
        category: "${json['category']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'id': exerciseId,
        'name': exerciseName,
        'url': imageUrl,
        'description': description,
        'category': category,
      };
}

class GetExerciseDataFromGoogleSheetProvider with ChangeNotifier {
  List<ExerciseDbModel> _listExercises = List<ExerciseDbModel>();
  static const URL =
      "https://script.google.com/macros/s/AKfycbx2H4v8xaSWlnTq3WKaVHw-Z_2eBh6M0yFufxGwm-diDYcKfJPzHZjI9zi23Z1G0YSF/exec";
  Future<List<ExerciseDbModel>> getListOfExercises() async {
    await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      _listExercises =
          jsonFeedback.map((json) => ExerciseDbModel.fromJson(json)).toList();
      notifyListeners();
    });
  }

  List<ExerciseDbModel> get listExercises {
    return [..._listExercises];
  }
}

// class _MyAppState extends State<MyApp> {
//   // ignore: deprecated_member_use
//   List<ExerciseData> exercises = List<ExerciseData>();

//   @override
//   void initState() {
//     super.initState();

//     GetData().getFeedbackList().then((exercises) {
//       setState(() {
//         this.exercises = exercises;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sheet Data'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: ListView.builder(
//           itemCount: exercises.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Text(
//                         "${exercises[index].name} - ${exercises[index].description}"),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class RunDataProvider with ChangeNotifier {
//   String _uid;
//   String _token;

//   List<RunModel> _yourRunsList = [
//     // RunModel(
//     //   uid: 'gautam.pv@iitgn.ac.in',
//     //   dateOfRun: 'Thu, Oct 22, 2020',
//     //   avgSpeed: '8',
//     //   distanceCovered: '2.8',
//     //   startTime: '17:36',
//     //   timeOfRunHrs: '00',
//     //   timeOfRunMin: '24',
//     //   timeOfRunSec: '23',
//     //   listOfLatLng: [
//     //     {'latitude': 2, 'longitude': 3}
//     //   ],
//     //   intialLatitude: 2,
//     //   initialLongitude: 3,
//     // ),
//     // RunModel(
//     //   uid: 'gautam.pv@iitgn.ac.in',
//     //   dateOfRun: 'Thu, Oct 22, 2020',
//     //   avgSpeed: '6.8',
//     //   distanceCovered: '3.8',
//     //   startTime: '18:33',
//     //   timeOfRunHrs: '00',
//     //   timeOfRunMin: '29',
//     //   timeOfRunSec: '33',
//     //   listOfLatLng: [
//     //     {'latitude': 2, 'longitude': 3}
//     //   ],
//     //   initialLongitude: 3,
//     //   intialLatitude: 2,
//     // ),
//   ];

// //  var x =  _yourRunsList[0];

//   void setToken(String token) {
//     _token = token;
//   }

//   void setUid(String userUid) {
//     _uid = userUid;
//     print('uid has been set');
//     notifyListeners();
//     print("uid is $_uid");
//   }

//   Future<void> getRunStatsFromDb() async {
//     // print(_uid);
//     // print(_token);
//     final url =
//         'https://authentications-c0299.firebaseio.com/RunData.json?auth=$_token&orderBy="uid"&equalTo="$_uid"';
//     try {
//       final response = await http.get(url);
//       final extractedData = json.decode(response.body) as Map<String, dynamic>;
//       final List<RunModel> loadedList = [];
//       // print(extractedData['-MMvLcgO2K3wHZkueZcV']['listOfLatLng'].runtimeType);
//       extractedData.forEach((statId, statVal) {
//         loadedList.add(
//           new RunModel(
//             databaseID: statId,
//             uid: statVal['uid'],
//             dateOfRun: statVal['dateOfRun'],
//             avgSpeed: statVal['avgSpeed'],
//             distanceCovered: statVal['distanceCovered'],
//             startTime: statVal['startTime'],
//             timeOfRunSec: statVal['timeOfRunSec'],
//             timeOfRunMin: statVal['timeOfRunMin'],
//             timeOfRunHrs: statVal['timeOfRunHrs'],
//             listOfLatLng: statVal['listOfLatLng'],
//             initialLongitude: statVal['initialLongitude'],
//             initialLatitude: statVal['initialLatitude'],
//           ),
//         );

//         // print(loadedList[0].avgSpeed);
//         // print(loadedList[0].databaseID);
//         // print(loadedList[0].dateOfRun);
//         // print(loadedList[0].distanceCovered);
//         // print(loadedList[0].initialLatitude);
//         // print(loadedList[0].initialLongitude);

//         _yourRunsList = loadedList;
//         _yourRunsList.sort((a, b) {
//           return b.dateOfRun.compareTo(a.dateOfRun);
//         });
//         notifyListeners();
//       });
//       print("Loaded List is ready");
//       print(json.decode(response.body));
//     } catch (e) {
//       throw (e);
//     }
//   }

//   List<RunModel> get yourRunsList {
//     return [..._yourRunsList];
//   }

//   Future<void> addNewRunData(
//     // uid is already passed through the provider
//     String dateOfRun,
//     String avgSpeed,
//     String distanceCovered,
//     String startTime,
//     String timeOfRunHrs,
//     String timeOfRunMin,
//     String timeOfRunSec,
//     List<Map<String, double>> listOfLatLng,
//     double initialLatitude,
//     double initialLongitude,
//   ) {
//     print("The Uid Is " + _uid);
//     final url =
//         'https://authentications-c0299.firebaseio.com/RunData.json?auth=$_token';
//     return http
//         .post(
//       url,
//       body: json.encode(
//         {
//           'uid': _uid,
//           'dateOfRun': dateOfRun,
//           'avgSpeed': avgSpeed,
//           'distanceCovered': distanceCovered,
//           'startTime': startTime,
//           'timeOfRunSec': timeOfRunSec,
//           'timeOfRunMin': timeOfRunMin,
//           'timeOfRunHrs': timeOfRunHrs,
//           'listOfLatLng': listOfLatLng,
//           'initialLatitude': initialLatitude,
//           'initialLongitude': initialLongitude
//         },
//       ),
//     )
//         .then(
//       (response) {
//         var databaseId = json.decode(response.body)['name'];
//         _yourRunsList.insert(
//           0,
//           RunModel(
//             databaseID: databaseId,
//             uid: _uid,
//             dateOfRun: dateOfRun,
//             avgSpeed: avgSpeed,
//             distanceCovered: distanceCovered,
//             startTime: startTime,
//             timeOfRunSec: timeOfRunSec,
//             timeOfRunMin: timeOfRunMin,
//             timeOfRunHrs: timeOfRunHrs,
//             listOfLatLng: listOfLatLng,
//             initialLatitude: initialLatitude,
//             initialLongitude: initialLongitude,
//           ),
//         );
//         notifyListeners();
//       },
//     ).catchError((error) {
//       print(error);
//       throw error;
//     });
//   }
// }
