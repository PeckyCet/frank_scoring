class CourseTest {

  String courseName = ''; //name of course
  int courseHoles = 0; //number of holes on course
  int holeNumber = 0; //the hole number
  int holePar = 0; //the par of the hole
  int holeIndex = 0; //the stroke index of the hole
  String teeType =''; //the type of tees for the data provided

  CourseTest({required this.courseName, required this.teeType, required this.courseHoles});

  Future<void> getCourse() async {

    courseName = 'Roxburghe';
    courseHoles = 18;
    teeType = 'Yellow';

    print('$courseName + $courseHoles + $teeType');

  }

}