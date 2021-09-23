import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank_scoring/models/myuser.dart';
import 'package:provider/provider.dart';

class CourseDetailsForm extends StatefulWidget {
  const CourseDetailsForm({Key? key}) : super(key: key);

  @override
  _CourseDetailsFormState createState() => _CourseDetailsFormState();
}

class _CourseDetailsFormState extends State<CourseDetailsForm> {
  final Stream<QuerySnapshot> _courseStream =
      FirebaseFirestore.instance.collection('courses').snapshots();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: _courseStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Column(
                children: <Widget>[
                  Text(document.get('courseName')),
                  SizedBox(height: 20.0),
                  Text(document.get('teeType')),
                  SizedBox(height: 20.0),
                  Text('Holes: ${document.get('numberOfHoles').toString()}'),
                  SizedBox(height: 20.0),
                  Text('Creator UID: ${document.get('creatorUid')}'),
                  SizedBox(height: 20.0),
                  Text('Doc ID: ${document.get('docID')}'),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

/*ListTile(
              title: new Text(document.get('courseName')),
              subtitle: new Text(document.get('teeType')),
            );*/