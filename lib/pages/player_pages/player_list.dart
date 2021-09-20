import 'package:flutter/material.dart';
import 'package:frank_scoring/models/myuser.dart';
import 'package:frank_scoring/models/player.dart';
import 'package:provider/provider.dart';
import 'package:frank_scoring/pages/player_pages/player_tile.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({Key? key}) : super(key: key);

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  Widget build(BuildContext context) {

    //gets list of all players in the players collection
    final players = Provider.of<List<Player>>(context) ?? [];
    //gets the current user from user collection
    final user = Provider.of<MyUser?>(context);

    //filters the list of players by comparing their uid value to the current users uid
    var filteredPlayers =
        players.where((item) => item.uid == user!.uid).toList();

    //filters the list of players alphabetically
    filteredPlayers.sort((a, b) => a.playerName.compareTo(b.playerName));

    return ListView.builder(
          itemCount: filteredPlayers.length,
          itemBuilder: (context, index) {
            return PlayerTile(player: filteredPlayers[index]);
          },
        );
  }
}
