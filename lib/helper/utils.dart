import 'dart:async';

import 'package:intl/intl.dart';
import 'package:petani_kopi/firebase_query.dart/query_key.dart';
import 'package:petani_kopi/model/users.dart';

userToChats(Map<String, dynamic> map) {
  Users chat = Users();
  chat.userId = map[UserKey.userId];
  chat.userImage = map[UserKey.userImage];
  chat.userImageHash = map[UserKey.userImageHash];
  chat.userName = map[UserKey.userName];
  // chat.userProfile = map[UserKey.userProfile];
  // chat.lastChat = '';
  // chat.lastChatType = Const.typeNormal;
  // chat.lastImage = null;
  // chat.lastNameSearch = generateStringKey(map[UserKey.userName]);
  // chat.lastSearchChat = generateStringKey('');
  return chat;
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' DAY AGO';
    } else {
      time = diff.inDays.toString() + ' DAYS AGO';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
    } else {
      time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
    }
  }

  return time;
}

String getFileName(String url) {
  RegExp regExp = RegExp(r'.+(\/|%2F)(.+)\?.+');
  //This Regex won't work if you remove ?alt...token
  var matches = regExp.allMatches(url);

  var match = matches.elementAt(0);
  // print(Uri.decodeFull(match.group(2)!));
  return Uri.decodeFull(match.group(2)!);
}

// {
//  if (this != null) {
//   (this)!.cancel();
//  }
// timer.onChange(
//   setState:(value){
//     timer = value;
//   }
//   onTimerStop: (){
//     Function
//   }
// );
// }
extension Change on Timer? {
  onChange({
    required Function(Timer) setstate,
    required Function() onTimerStop,
    Duration? timerDuration,
  }) {
    Duration duration = timerDuration ?? const Duration(milliseconds: 800);
    setstate(Timer(duration, () => onTimerStop()));
  }
}

const duration = Duration(milliseconds: 800);

extension Change2 on Timer? {
  void onChanges({
    required Function() onSearch,
  }) {
    Timer? timer = (this);
    if (timer != null) timer.cancel();
    timer = Timer(duration, onSearch);
  }
}
