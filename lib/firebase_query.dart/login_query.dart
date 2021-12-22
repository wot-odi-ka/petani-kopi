import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petani_kopi/firebase_query.dart/query_key.dart';
import 'package:petani_kopi/model/users.dart';

class LogQuery {
  static uploadUser(dynamic map) async {
    await FirebaseFirestore.instance
        .collection(Col.users)
        .doc(map[UserKey.userId])
        .set(map)
        .catchError((e) => throw e);
  }

  static checkName(String name) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Col.users)
        .where(UserKey.userName, isEqualTo: name)
        .get()
        .catchError((e) => throw e);

    return snapshot.docs.isNotEmpty;
  }

  static checkMail(String mail) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Col.users)
        .where(UserKey.userMail, isEqualTo: mail)
        .get()
        .catchError((e) => throw e);

    return snapshot.docs.isNotEmpty;
  }

  static updateUserData(Users user) async {
    await FirebaseFirestore.instance
        .collection(Col.users)
        .doc(user.userId)
        .set(user.toMap())
        .catchError((e) => throw e.toString());
  }

  static getUsersById(String id) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection(Col.users)
        .where(UserKey.userId, isEqualTo: id)
        .get()
        .catchError((e) => throw e);

    var map = snap.docs[0].data() as Map<String, dynamic>;

    return Users.map(map);
  }

  static friendSearch(map) async {
    List<String> friendId = [];
    List<DocumentSnapshot> result = [];

    await FirebaseFirestore.instance
        .collection(Col.friends)
        .doc(map[UserKey.userId])
        .collection(Col.friendList)
        .get()
        .then((value) {
      for (var element in value.docs) {
        friendId.add(element.data()[UserKey.userId]);
      }
    }).catchError((e) => throw e);

    await FirebaseFirestore.instance
        .collection(Col.users)
        .where(UserKey.userName, isEqualTo: map['val'])
        .where(UserKey.userName, isNotEqualTo: map[UserKey.userName])
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        if (friendId.isNotEmpty) {
          for (int x = 0; x < friendId.length; x++) {
            if (value.docs[i][UserKey.userId] != friendId[x]) {
              result.add(value.docs[i]);
            }
          }
        } else {
          result.add(value.docs[i]);
        }
      }
    }).catchError((e) => throw e);

    return result;
  }

  static updateSellerStatus(String userId) async {
    await FirebaseFirestore.instance
        .collection(Col.users)
        .doc(userId)
        .update({'userIsSeller': true}).catchError(
      (e) => throw e.toString(),
    );
  }
}
