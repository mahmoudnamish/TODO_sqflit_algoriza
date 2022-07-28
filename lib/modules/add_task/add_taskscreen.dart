
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_algoriza/layout/home_screen.dart';

import 'package:todoapp_algoriza/layout/cubit/state.dart';
import 'package:todoapp_algoriza/modules/schedule/schedule_screen.dart';
import 'package:todoapp_algoriza/shared/Components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/Components/style.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <CubitAddTask, StateAddTask>(
      listener: (context,state) {},
      builder: (context,state) {
        var key = GlobalKey<FormState>();
        var cubit = CubitAddTask.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: const Text(
              'Add task',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            shape:
                const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: key,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormFiled(
                          controller: cubit.DesignteamController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Pleas enter the Design team meeting';
                            }
                            return null;
                          },
                          text: 'Design team meeting'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Deadline',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormFiled(
                          sufex: Icons.arrow_drop_down_sharp,
                          bottom: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2023-06-08'))
                                .then((value) {
                              cubit.DeadlineController.text =
                                  DateFormat('yyyy-MM-dd').format(value!);
                            });
                          },
                          controller: cubit.DeadlineController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Pleas enter the Deadline';
                            }
                            return null;
                          },
                          text: '2021-02-28'),
                      const SizedBox(
                        height: 15,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Start time',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: DefaultTextFormFiled(
                                      sufex: Icons.watch_later_outlined,
                                      bottom: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          cubit.StartTimeController.text =
                                              value!.format(context);
                                        });
                                      },
                                      controller: cubit.StartTimeController,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Pleas enter the Time';
                                        }
                                        return null;
                                      },
                                      text: '11:00 Am'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'End time',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: DefaultTextFormFiled(
                                      sufex: Icons.watch_later_outlined,
                                      bottom: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          cubit.EndTimeController.text =
                                              value!.format(context);
                                        });
                                      },
                                      controller: cubit.EndTimeController,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Pleas enter the Time';
                                        }
                                        return null;
                                      },
                                      text: '14:00 Pm'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Remind',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: cubit.RemindController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleas enter the Design team meeting';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[100],
                          filled: true,
                          labelStyle: const TextStyle(color: Colors.grey),
                          hintText: '${cubit.SelectRemind}minutes early',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          suffixIcon: DropdownButton(
                            items: cubit.RemindList.map(
                                (int value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      '$value',
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    ))).toList(),
                            icon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (newvalue) {
                              cubit.changeRemind(newvalue);
                            },
                          ),
                          border:
                              const OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Repeat',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: cubit.RepeatController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleas enter the Design team meeting';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[100],
                          filled: true,
                          labelStyle: const TextStyle(color: Colors.grey),
                          hintText: '${cubit.SelectRepeat}',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          suffixIcon: DropdownButton(
                            items: cubit.ListRepeat.map(
                                (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      '$value',
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    ))).toList(),
                            icon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (newvalue) {
                              cubit.CahngeRepeat(newvalue);
                            },
                          ),
                          border:
                          const    OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Color',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: List.generate(
                            4,
                            (index) => GestureDetector(
                                  onTap: () {
                                    cubit.Colorselect(index);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: CircleAvatar(
                                          child: cubit.SelectColor == index
                                              ?  Icon(
                                                  Icons.done,
                                                  size: 16,
                                                  color: Colors.white,
                                                )
                                              : null,
                                          backgroundColor: index == 0
                                              ? red
                                              : index == 1
                                                  ? teal
                                                  : index == 2
                                                      ? oragne
                                                      : index==3?blue:null)),
                                )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defultBottom(
                          width: double.infinity,
                          background: Colors.green,
                          onpresse: () {
                            if(key.currentState!.validate()){
                              cubit.notification();
                              cubit.InsertDataBase();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleScreen()));
                            }
                          },
                          text: 'Create a Task')
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
