import 'package:flutter/material.dart';
import 'package:frank_scoring/pages/authenticate/authenticate.dart';
import 'package:frank_scoring/pages/home/home.dart';
import 'package:provider/provider.dart';
import 'package:frank_scoring/models/myuser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    //return either Home or Authenticate widget
    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
