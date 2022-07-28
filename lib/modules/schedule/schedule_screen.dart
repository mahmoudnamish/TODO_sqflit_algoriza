import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todoapp_algoriza/layout/cubit/cubit.dart';
import 'package:todoapp_algoriza/layout/cubit/state.dart';
import 'package:todoapp_algoriza/modules/add_task/add_taskscreen.dart';

import '../../shared/Components/components.dart';



class ScheduleScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitAddTask,StateAddTask>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =CubitAddTask.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AddTaskScreen()),
                          (route) => false);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: const Text(
              'Schedule',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsetsDirectional.only(top: 10,bottom: 10,end: 6,start: 20),
              decoration:
              const BoxDecoration(border: BorderDirectional(bottom:BorderSide(width: 1,color: Colors.grey),top: BorderSide(width: 1,color: Colors.grey) )),
              child: DatePicker(
                  onDateChange: (newdate){
                    cubit.SelecteDate = newdate;
                    cubit.SelecteDateString = DateFormat('yyyy-MM-dd').format( cubit.SelecteDate);
                    cubit.Date();
                },
                DateTime.now(),
                initialSelectedDate:cubit.SelecteDate,
                dateTextStyle:GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black54)),
                dayTextStyle: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black54)),
                monthTextStyle: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black54)),
                selectedTextColor: Colors.white,
                selectionColor: Colors.green,
                width: 70,
                height: 100,
              ),),
                  const SizedBox(
              height: 15,
            ),
                  Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text  ('${Jiffy(cubit.SelecteDate).EEEE}',style: const TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),),
                  const Spacer(),
                  Text(textAlign: TextAlign.end,
                    DateFormat.yMMMMd().format(cubit.SelecteDate).toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54,),
                  ),
                ],
              ),
            ),
                  const SizedBox(height: 10,),
               ConditionalBuilder(condition:cubit.datetime.length>0
                   , builder: (context)=>Expanded(

                     child: RefreshIndicator(
                       onRefresh: ()async{
                         cubit.Date();
                         print(cubit.SelecteDateString);
                       },
                       child:
                       ListView.separated(itemBuilder: (contect,index)=>UserItem(
                           item:cubit.datetime[index],


                       )
                           , separatorBuilder: (contect,index)=> Container(width: double.infinity,
                             height: 1,color: Colors.grey,
                           )
                           , itemCount: cubit.datetime.length),
                     ),
                   )
                   , fallback:(context)=> RefreshIndicator(
                     onRefresh: ()async{
                       cubit.Date();
                       print(cubit.SelecteDateString);
                     },

                     child: Center(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.menu,size: 100,color: Colors.grey),
                           Text('No Tasks yet ,Please Add Some Tasks ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.grey),)
                       ],),
                     ),
                   ))



          ]),
        );
      },

    );
  }
}
