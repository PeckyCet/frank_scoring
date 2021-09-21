import 'package:flutter/material.dart';
import 'package:frank_scoring/models/myuser.dart';
import 'package:frank_scoring/pages/course_pages/course_select.dart';
import 'package:frank_scoring/pages/home/home.dart';
import 'package:frank_scoring/pages/player_pages/player_select.dart';
import 'package:frank_scoring/pages/course_pages/courses_list.dart';
import 'package:frank_scoring/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frank_scoring/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:frank_scoring/models/myuser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      catchError: (User, MyUser) => null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/home': (context) => Home(),
          '/players': (context) => Players(),
          '/courses': (context) => Courses(),
        },
      ),
    );
  }
}