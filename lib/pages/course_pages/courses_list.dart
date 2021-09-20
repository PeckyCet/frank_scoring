import 'package:flutter/material.dart';
import 'package:frank_scoring/services/course.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<Course> courses = [
    Course(courseName: 'Roxburghe', courseHoles: 18, teeType: 'Yellow')
  ];

  void updateCourses(index) async {
    Course instance = courses[index];
    await instance.getCourse();

    //TODO Navigate to course details page with instance data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text('Choose Course'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateCourses(index);
                },
                title: Text(courses[index].courseName),
                subtitle: Text('Holes: ${courses[index].courseHoles}' +
                    ' Tees: ${courses[index].teeType}'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add Course Button pressed');
        },
        child: const Icon(
          Icons.add,
          size: 35.0,
        ),
        backgroundColor: Colors.green[600],
      ),
    );
  }
}
