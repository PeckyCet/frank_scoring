import 'package:flutter/material.dart';
import 'package:frank_scoring/models/player.dart';
import 'package:frank_scoring/pages/player_pages/player_details_form.dart';

class PlayerTile extends StatefulWidget {

  final Player player;
  PlayerTile({required this.player});

  @override
  _PlayerTileState createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {

  void _showPlayerSettingsPanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: PlayerDetailsForm(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Icon(Icons.person, size: 40.0,),
          title: Text(widget.player.playerName),
          subtitle: Text('Handicap: ${widget.player.playerHandicap}'),
          trailing: GestureDetector(
            onTap: () => _showPlayerSettingsPanel(),
            child: Icon(
                Icons.edit
            ),
          ),
        ),
      ),
    );
  }
}
