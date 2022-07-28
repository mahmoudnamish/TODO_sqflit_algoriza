import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_algoriza/layout/cubit/cubit.dart';
import 'package:todoapp_algoriza/layout/cubit/state.dart';

import '../../shared/Components/components.dart';

class CompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitAddTask,StateAddTask>(
      listener: (context,state){},
      builder: (context,state){
        var Cubit = CubitAddTask.get(context);

        return ConditionalBuilder(condition: Cubit.Complete.length >0
            , builder: (context)=>RefreshIndicator(
              onRefresh: () async {
                Cubit.GetDataBase();
              },
              child:
              ListView.separated(itemBuilder: (contect, index) =>
                  DefaultItem(
                      item: Cubit.Complete[index]
                  )
                  , separatorBuilder: (contect, index) =>
                      Container(width: double.infinity,
                        height: 1, color: Colors.grey,
                      )
                  , itemCount: Cubit.Complete.length),
            )
            , fallback: (context)=>Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu,size: 100,color: Colors.grey),
                  Text('No Tasks yet ,Please Add Some Tasks ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.grey),)
                ],),
            ));




      },

    );
  }
}
