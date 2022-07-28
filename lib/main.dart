import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_algoriza/layout/cubit/cubit.dart';
import 'package:todoapp_algoriza/shared/Components/style.dart';

import 'layout/home_screen.dart';

void main()  {
   WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'Key1',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.teal,
          ledColor: Colors.white,
          playSound: true,
          enableLights: true,
          enableVibration: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
     );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CubitAddTask()..InitialeDatabase()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themelight,
        home: HomeScreen(),
      ),
    );
  }
}
