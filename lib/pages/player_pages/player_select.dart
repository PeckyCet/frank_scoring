import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frank_scoring/models/myuser.dart';
import 'package:frank_scoring/models/player.dart';
import 'package:frank_scoring/pages/player_pages/new_player_form.dart';
import 'package:frank_scoring/pages/player_pages/player_list.dart';
import 'package:frank_scoring/services/auth.dart';
import 'package:frank_scoring/services/database.dart';
import 'package:frank_scoring/shared/loading.dart';
import 'package:provider/provider.dart';

class Players extends StatefulWidget {
  @override
  _PlayersState createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  final AuthService _auth = AuthService();

  void _showAddPlayerForm() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: NewPlayerForm(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Player>>.value(
      initialData: [],
      value: DatabaseService(uid: '').players,
      child: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('Choose Player'),
          elevation: 0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () {
                _showAddPlayerForm();
              },
              icon: Icon(Icons.person_add),
              label: Text('Add Player'),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ],
        ),
        body: PlayerList(),
      ),
    );
  }
}
