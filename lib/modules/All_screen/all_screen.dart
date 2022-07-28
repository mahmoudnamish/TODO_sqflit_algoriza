import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp_algoriza/layout/cubit/state.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/Components/components.dart';

class AllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitAddTask,StateAddTask>(
      listener: (context,state){},
      builder: (context,state){
        var Cubit = CubitAddTask.get(context);
        return ConditionalBuilder(condition: Cubit.Users.length>0
            , builder: (context)=> RefreshIndicator(
              onRefresh: ()async{
                Cubit.GetDataBase();
              },
              child:
              ListView.separated(itemBuilder: (contect,index)=>DefaultItem(
                  item:Cubit.Users[index]
              )
                  , separatorBuilder: (contect,index)=>Container(width: double.infinity,
                    height: 1,color: Colors.grey,
                  )
                  , itemCount: Cubit.Users.length),
            ),
            fallback: (context)=>Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu,size: 100,color: Colors.grey),
                  Text('No Tasks yet ,Please Add Some Tasks ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.grey),)
                ],),
            )
        );

      },

    );
  }
}
