import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frank_scoring/models/course.dart';
import 'package:frank_scoring/models/myuser.dart';
import 'package:frank_scoring/models/player.dart';
import 'package:frank_scoring/services/database.dart';
import 'package:frank_scoring/shared/constants.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:provider/provider.dart';

class PlayerDetailsForm extends StatefulWidget {

  @override
  _PlayerDetailsFormState createState() => _PlayerDetailsFormState();
}

class _PlayerDetailsFormState extends State<PlayerDetailsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> _playerStream =
      FirebaseFirestore.instance.collection('players').snapshots();

  //form values
  late String _currentName;
  int _currentHandicap = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: _playerStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        print(snapshot);
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your player details',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        labelText: 'Name', hintText: 'Enter your name'),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                    initialValue: document.get('name'),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Select your Handicap',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  SfSlider(
                    min: 0.0,
                    max: 40.0,
                    value: (_currentHandicap ?? document.get('handicap'))
                        .toDouble(),
                    interval: 5,
                    onChanged: (val) =>
                        setState(() => _currentHandicap = val.round()),
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    activeColor: Colors.green,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user!.uid).updatePlayersData(
                            user.uid, _currentName, _currentHandicap);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green, fixedSize: Size(220.0, 32.0)),
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user!.uid)
                            .deletePlayersData();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red, fixedSize: Size(180.0, 28.0)),
                    child: Text(
                      'Delete Player',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
