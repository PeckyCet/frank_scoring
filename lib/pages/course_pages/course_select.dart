import 'package:flutter/material.dart';
import 'package:frank_scoring/models/course.dart';
import 'package:frank_scoring/pages/course_pages/courses_list.dart';
import 'package:frank_scoring/pages/course_pages/new_course_form.dart';
import 'package:frank_scoring/services/auth.dart';
import 'package:frank_scoring/services/database.dart';
import 'package:provider/provider.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final AuthService _auth = AuthService();

  void _showAddCourseForm() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: NewCourseForm(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Course>>.value(
      initialData: [],
      value: DatabaseService(uid: '').courses,
      child: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('Choose Course'),
          elevation: 0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () {
                _showAddCourseForm();
              },
              icon: Icon(Icons.person_add),
              label: Text('Add Course'),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ],
        ),
        body: CourseList(),
      ),
    );
  }
}
