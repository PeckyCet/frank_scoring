class Course {
  final String creatorUid;
  final String courseName;
  final int numberOfHoles;
  final String teeType;
  //List<dynamic> holes = [];

  Course(
      {required this.creatorUid,
      required this.courseName,
      required this.numberOfHoles,
      required this.teeType});
}
