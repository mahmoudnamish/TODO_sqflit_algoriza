
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp_algoriza/layout/cubit/state.dart';
import 'package:path/path.dart';
import '../../shared/Components/style.dart';
class CubitAddTask extends Cubit<StateAddTask> {
  CubitAddTask() : super(InitialStates());

  static CubitAddTask get(context) => BlocProvider.of(context);
  var DesignteamController = TextEditingController();
  var DeadlineController = TextEditingController();
  var StartTimeController = TextEditingController();
  var EndTimeController = TextEditingController();
  var RemindController = TextEditingController();
  var RepeatController = TextEditingController();
  var datepkercontroler = DatePickerController();
  int SelectColor = 0;


  void Colorselect(int index) {
    SelectColor = index;
    emit(SelectColorState());
  }

  int SelectRemind = 10;
  List<int>RemindList = [10, 30, 60, 1440];

  void changeRemind(Remind) {
    SelectRemind = Remind;
    RemindController.text = SelectRemind.toString();
    emit(ChangeRemind());
  }

  String SelectRepeat = 'Non';
  List<String> ListRepeat = ['Non', 'Daily', 'Weekly', 'monthly'];

  void CahngeRepeat(Repeat) {
    SelectRepeat = Repeat;
    RepeatController.text = SelectRepeat;
    emit(ChangeRepeat());
  }


  void InitialeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'TODO.db');
    await deleteDatabase(path);
    CreateDataBase(path: path);
    print('Initial dataBase');
    emit(InitialDatabase());
  }

  Database? database;

  void CreateDataBase({
    required String path
  }) async {
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING,date STRING,starttime STRING,endtime STRING,remind INTEGER ,repeat STRING, color INTEGER,status STRING,favorit STRING )');
        },
        onOpen: (Database db) {
          print('on opendata pase');
          database = db;
          GetDataBase();
        }
    );
  }

  void InsertDataBase() {
    emit(InsertDataBaseLoding());
    database?.transaction((txn) async {
      txn.rawInsert(
          ' INSERT INTO Test(title,date,starttime,endtime,remind,repeat,color,status,favorit) VALUES("${DesignteamController
              .text}","${DeadlineController.text}","${StartTimeController
              .text}","${EndTimeController.text}","${RemindController
              .text}","${RepeatController
              .text}","${SelectColor}","new","favorit")')
          .then((value) {
        print('insert table');
        DesignteamController.clear();
        DeadlineController.clear();
        StartTimeController.clear();
        EndTimeController.clear();
        RemindController.clear();
        RepeatController.clear();
        GetDataBase();
        emit(InsertDatabase());
      });
    });
  }

  List<Map> Newtasks = [];
  List<Map> Complete = [];
  List<Map>Users = [];
  List<Map> favorit = [];

  void GetDataBase() async {
    Newtasks = [];
    Complete = [];
    Users = [];
    favorit = [];
    emit(LodingGetDatabase());
    database?.rawQuery('SELECT * FROM Test').then((value) {
      print('get user');
      Users = value;
      Users.forEach((element) {
        if (element['status'] == 'new') {
          Newtasks.add(element);
        } else if (element['status'] == 'comblete') {
          Complete.add(element);
        }
      });
      Users.forEach((element) {
        if (element['favorit'] == 'favorit') {
          favorit.add(element);
        }
      });

      emit(getDatabase());
    });
  }

  List<Map>datetime = [];
  DateTime SelecteDate = DateTime.now().toUtc();
  String SelecteDateString = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void Date() {
    database?.rawQuery('SELECT * FROM Test WHERE date = ?', [SelecteDateString])
        .then((value) {
      datetime = value;


      emit(getDatabase());
    });

    emit(Selecteddate());
  }

  defultcolor(int ? color) {
    switch (color) {
      case 0 :
        return red;
      case 1 :
        return teal;
      case 2 :
        return oragne;
      case 3 :
        return blue;
      default:
        return Colors.grey;
    }
  }

  bool ValueCheck = true;
  bool Checkout = false;

  void checkbox(dynamic value) {
    ValueCheck = value;
    emit(checkboxstate());
  }

  void Notcheckbox(dynamic value) {
    Checkout = value;
    emit(checkboxstate());
  }

  void UpdateDatabase({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
        'UPDATE Test SET status = ? WHERE id = ? ',
        ['$status', id]).then((value) {
      GetDataBase();
      print(value);
      emit(UpdateDatabaseState());
    });
  }

  void UpdateFavorit({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
        'UPDATE Test SET favorit = ? WHERE id = ? ',
        ['$status', id]).then((value) {
      GetDataBase();
      print(value);
      emit(UpdateDatabaseState());
    });
  }

  void deletDatabase({
    required int id,
  }) async {
    database!.rawDelete(
        'DELETE FROM Test WHERE id = ?', [id]).then((value) {
      GetDataBase();
      print(value);
      emit(deleteDatabaseState());
    });
  }

void notification()async{
 await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: DesignteamController.text,

      ),

  );
}
}