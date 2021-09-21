import 'package:flutter/material.dart';
import 'package:frank_scoring/models/course.dart';
import 'package:frank_scoring/models/myuser.dart';
import 'package:frank_scoring/pages/course_pages/course_tile.dart';
import 'package:provider/provider.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {

    //gets list of all courses in the course collection
    final courses = Provider.of<List<Course>>(context) ?? [];
    //gets current user from user collection
    final user = Provider.of<MyUser?>(context);

    return ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseTile(course: courses[index]);
        });
  }
}
