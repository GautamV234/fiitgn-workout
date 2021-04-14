import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Workouts_providers.dart';

class FollowedWorkoutsScreen extends StatefulWidget {
  static const routeName = '\FollowerdWorkouts';

  @override
  _FollowedWorkoutsScreenState createState() => _FollowedWorkoutsScreenState();
}

class _FollowedWorkoutsScreenState extends State<FollowedWorkoutsScreen> {
  var init = true;
  @override
  void didChangeDependencies() async {
    if (init == true) {
      await Provider.of<WorkoutsProvider>(context).showAllWorkouts();
      print("bb");
      // TODO: implement didChangeDependencies
      super.didChangeDependencies();
    }
    init = false;
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutsProvider>(context);
    final List<WorkoutModel> followedWorkouts =
        workoutProvider.followedWorkouts();
    print(followedWorkouts);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Workouts'),
      ),
      body: followedWorkouts.length == 0
          ? Center(child: Text("none"))
          : ListView.builder(
              itemCount: followedWorkouts.length,
              itemBuilder: (ctx, i) {
                return Text(followedWorkouts[i].workoutName);
              },
            ),
    );
  }
}
