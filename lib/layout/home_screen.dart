import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_algoriza/layout/cubit/cubit.dart';
import 'package:todoapp_algoriza/modules/All_screen/all_screen.dart';
import 'package:todoapp_algoriza/modules/schedule/schedule_screen.dart';
import 'package:todoapp_algoriza/modules/uncompleted/uncompleted_screen.dart';
import 'cubit/state.dart';
import '../modules/add_task/add_taskscreen.dart';
import '../modules/completed/completed_screen.dart';
import '../modules/favorites/favorites_screen.dart';
import '../shared/Components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitAddTask,StateAddTask>(
      listener: (context,stater){},
      builder:  (context,stater){
        var cubit =CubitAddTask.get(context);
        return  DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,

            body: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 10) +
                        const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const  Text('Board',  style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),),
                        IconButton(
                          onPressed: () {
                            // CubitAddTask.get(context).notification();
                            cubit.Date();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleScreen()));
                          },
                          icon: const Icon(Icons.calendar_month, size: 30, color: Colors.black45),
                        ),

                      ],
                    ),
                  ),
                  const  SizedBox(height: 10,),
                  Container(
                    height: 1,
                    color: Colors.grey[200],
                    width: double.infinity,
                  ),
                  const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Text(
                          'All',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Completed',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Uncompleted',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Favorite',
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey[200],
                    width: double.infinity,
                  ),
                  const SizedBox(height: 15,),
                  Expanded(
                    child: TabBarView(
                      children: [
                        AllScreen(),
                        CompletedScreen(),
                        UnCompletedScreen(),
                        FavoritesScreen(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  defultBottom(
                      width: double.infinity,
                      background: Colors.green,
                      onpresse: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTaskScreen()));
                      },
                      text: 'Add a task'),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
