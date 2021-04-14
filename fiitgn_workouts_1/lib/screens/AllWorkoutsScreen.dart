import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Workouts_providers.dart';

class AllWorkoutsScreen extends StatefulWidget {
  static const routeName = '\allWorkouts';

  @override
  _AllWorkoutsScreenState createState() => _AllWorkoutsScreenState();
}

class _AllWorkoutsScreenState extends State<AllWorkoutsScreen> {
  //  final workoutDataProvider = Provider.of<WorkoutsProvider>(context);
  // TODO
  //
  // ADD DIFFERENT SLIDING PAGES FOR PRIVATE AND PUBLIC WORKOUTS
  // SHOW OTHER DETAILS AND IMAGES AND STUFF
  var isInit = true;
  var unFollowIcon = Icon(Icons.add_box_outlined);
  var followIcon = Icon(Icons.add_box);
  var icon = Icon(Icons.add_box_outlined);
  List<dynamic> iconList = [];
  void followWorkout(String workoutId) {
    final workoutDataProvider = Provider.of<WorkoutsProvider>(context);
    List<WorkoutModel> workoutsLists = workoutDataProvider.workoutList;
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<WorkoutsProvider>(context).showAllWorkouts();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final workoutDataProvider = Provider.of<WorkoutsProvider>(context);
    final List<WorkoutModel> workoutsList = workoutDataProvider.workoutList;
    final String userEmailId = workoutDataProvider.userEmailId;
    workoutsList.forEach((element) {
      if (element.listOfFollowersId.contains(userEmailId)) {
        iconList.add(followIcon);
      } else {
        iconList.add(unFollowIcon);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('All Workouts'),
      ),
      // body: Center(
      //   child: Text("testetstetstestet"),
      // ),
      body: ListView.builder(
        itemCount: workoutsList.length,
        itemBuilder: (ctx, i) {
          return Card(
            child: Column(
              children: [
                Text(
                  workoutsList[i].workoutName,
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
                ),
                Text("Creator Id - " + workoutsList[i].creatorId),
                InkWell(
                  child: iconList[i],
                  onTap: () async {
                    //  function to follow/unfollow the workout
                    print("test");
                    if (workoutsList[i]
                        .listOfFollowersId
                        .contains(userEmailId)) {
                      if (workoutsList[i].creatorId != userEmailId) {
                        await workoutDataProvider.unFollowWorkout(
                            workoutsList[i], workoutsList[i].workoutId);
                        print("http unfollow done");
                        setState(() {
                          iconList[i] = unFollowIcon;
                          print("state set");
                        });
                      } else {
                        // cant unfollow your own workout
                        print("cant unfollow your own workout");
                        //
                        // TODO Add a snackbar thats tells user they cant unfollow workouts they have created
                      }
                    } else if (!workoutsList[i]
                        .listOfFollowersId
                        .contains(userEmailId)) {
                      await workoutDataProvider.followWorkout(
                          workoutsList[i], workoutsList[i].workoutId);
                      print("http follow done");
                      setState(() {
                        iconList[i] = followIcon;
                        print("state set");
                      });
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
