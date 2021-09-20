import 'package:flutter/material.dart';
import 'package:frank_scoring/models/player.dart';
import 'package:provider/provider.dart';
import 'package:frank_scoring/models/player.dart';

class CurrentUser extends StatefulWidget {
  const CurrentUser({Key? key}) : super(key: key);

  @override
  _CurrentUserState createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
  @override
  Widget build(BuildContext context) {

    final currentuser = Provider.of<List<Player>>(context);

    return Container();
  }
}
