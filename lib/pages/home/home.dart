import 'package:flutter/material.dart';
import 'package:frank_scoring/models/myuser.dart';
import 'package:frank_scoring/pages/player_pages/user_details_form.dart';
import 'package:frank_scoring/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frank_scoring/services/database.dart';
import 'package:frank_scoring/shared/loading.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    void _showUserSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: UserDetailsForm(),
        );
      });
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.green[100],
              appBar: AppBar(
                backgroundColor: Colors.green[300],
                title: Text('Frank Scoring'),
                centerTitle: true,
                elevation: 0,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                      await FirebaseAuth.instance.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign Out'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 80.0),
                      child: Card(
                          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                          child: ListTile(
                            leading: Icon(Icons.person, size: 40.0),
                            title: Text(userData!.name),
                            subtitle: Text('Handicap: ${userData.handicap} '),
                            trailing: GestureDetector(
                              onTap: () => _showUserSettingsPanel(),
                              child: Icon(
                                Icons.edit
                              ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/players');
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            fixedSize: Size(220.0, 32.0)),
                        child: Text(
                          'Players',
                          style: TextStyle(
                            fontSize: 24.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/courses');
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            fixedSize: Size(220.0, 32.0)),
                        child: Text(
                          'Courses',
                          style: TextStyle(
                            fontSize: 24.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          print('New Round Button Pressed');
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            fixedSize: Size(220.0, 32.0)),
                        child: Text(
                          'Start Round',
                          style: TextStyle(
                            fontSize: 24.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
