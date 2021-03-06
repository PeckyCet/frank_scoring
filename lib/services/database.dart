import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frank_scoring/models/myuser.dart';
import 'package:frank_scoring/models/player.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //users collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String playerName, int playerHandicap) async {
    return await userCollection.doc(uid).set({
      'name': playerName,
      'handicap': playerHandicap,
    });
  }

  //players collection reference
  final CollectionReference playerCollection =
      FirebaseFirestore.instance.collection('players');

  //Updates a player document in the player collection
  Future updatePlayersData(String userUid,String playerName, int playerHandicap) async {
    return await playerCollection.doc(uid).set({
      'uid': userUid,
      'name': playerName,
      'handicap': playerHandicap,
    });
  }

  //Deletes a player document from the player collection
  Future deletePlayersData() async {
    return await playerCollection.doc(uid).delete();
  }

  //Adds a new player document to the player collection
  Future addPlayersData(String userUid, String playerName, int playerHandicap) async {
    return await playerCollection.doc().set({
      'uid': uid,
      'name': playerName,
      'handicap': playerHandicap,
    });
  }

  //player list from snapshot
  List<Player> _playerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Player(
          uid: doc.get('uid') ?? '',
          playerName: doc.get('name') ?? '',
          playerHandicap: doc.get('handicap') ?? 0);
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid, name: snapshot['name'], handicap: snapshot['handicap']);
  }

  //playerData from snapshot
  Player _playerDataFromSnapshot(DocumentSnapshot snapshot) {
    return Player(
        uid: uid,
        playerName: snapshot['name'],
        playerHandicap: snapshot['handicap']);
  }

  //get players stream
  Stream<List<Player>> get players {
    return playerCollection.snapshots().map(_playerListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //get player doc stream
  Stream<Player> get playerData {
    return playerCollection.doc(uid).snapshots().map(_playerDataFromSnapshot);
  }
}
