import 'package:flutter/material.dart';
import 'package:frank_scoring/models/course.dart';
import 'package:frank_scoring/pages/course_pages/course_details_form.dart';

class CourseTile extends StatefulWidget {
  final Course course;
  CourseTile({required this.course});

  @override
  _CourseTileState createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {

  void _showCourseDetailPanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.all(12.0),
        child: CourseDetailsForm(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.golf_course),
          title: Text(widget.course.courseName),
          subtitle: Text('Tees: ${widget.course.teeType}'),
          trailing: GestureDetector(
            onTap: () => _showCourseDetailPanel(),
            child: Icon(Icons.more_horiz),
          ),
        ),
      ),
    );
  }
}
