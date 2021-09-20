import 'package:flutter/material.dart';
import 'package:frank_scoring/models/myuser.dart';
import 'package:frank_scoring/models/player.dart';
import 'package:frank_scoring/services/database.dart';
import 'package:frank_scoring/shared/constants.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:provider/provider.dart';

class NewPlayerForm extends StatefulWidget {
  const NewPlayerForm({Key? key}) : super(key: key);

  @override
  _NewPlayerFormState createState() => _NewPlayerFormState();
}

class _NewPlayerFormState extends State<NewPlayerForm> {
  final _formKey = GlobalKey<FormState>();

  //form values
  late String _currentName;
  int _currentHandicap = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<Player>(
        stream: DatabaseService(uid: user!.uid).playerData,
        builder: (context, snapshot) {
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
                    value: (_currentHandicap).toDouble(),
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
                        await DatabaseService(uid: user.uid)
                            .addPlayersData(user.uid,_currentName, _currentHandicap);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green, fixedSize: Size(220.0, 32.0)),
                    child: Text(
                      'Add Player',
                      style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
        });
  }
}
