import 'dart:io';
import 'dart:typed_data';

import 'package:blurhash/blurhash.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/profil_block/profil_event.dart';
import 'package:petani_kopi/bloc/profil_block/profil_state.dart';
import 'package:petani_kopi/firebase_query.dart/login_query.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/database.dart';
import 'package:path/path.dart';

class ProfilBlock extends Bloc<ProfilEvent, ProfilState> {
  Users users = Users();
  String? url;
  String? hash;
  ProfilBlock() : super(ProfilInitial()) {
    on<ProfilEvent>((event, emit) => start(event, emit));
  }

  start(ProfilEvent event, Emitter<ProfilState> emit) async {
    try {
      if (event is ProfilInitEvent) {
        emit(ProfilOnLoading());
        users = await DB.getUser();
        emit(InitUserProfileDone(users));
      } else if (event is SubmitUpdateProfile) {
        emit(ProfilOnLoading());
        await uploading(event.user.file);
        await updateData(event.user);
        emit(ProfileUpdated(users));
      }
    } catch (e) {
      emit(UserProfileFailed(e.toString()));
    }
  }

  uploading(File? file) async {
    if (file != null) {
      String fileName = basename(file.path);
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      await taskSnapshot.ref.getDownloadURL().then((value) => url = value);

      Uint8List bytes = await file.readAsBytes();
      await BlurHash.encode(bytes, 2, 2).then((value) => hash = value);
    }
  }

  updateData(Users result) async {
    Users data = users;
    data.userName = result.userName ?? users.userName;
    data.userAlamat = result.userAlamat ?? users.userAlamat;
    data.userImage = url ?? users.userImage;
    data.userImageHash = hash ?? users.userImageHash;
    data.userMail = result.userMail ?? users.userMail;
    data.userPhone = result.userPhone ?? users.userPhone;
    await LogQuery.updateUserData(data);
    users = await LogQuery.getUsersById(users.userId!);
    await DB.saveUser(users);
  }
}
