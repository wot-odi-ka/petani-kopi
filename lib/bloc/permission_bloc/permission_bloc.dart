import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_event.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_state.dart';
import 'package:petani_kopi/common/permission_denied_dialog.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionStatus? galleryStatus;
  PermissionStatus? cameraStatus;
  Permission? permissionGallery = Permission.storage;
  Permission? permissionCamera = Permission.camera;

  PermissionBloc() : super(InitialPermission()) {
    on<PermissionEvent>((event, emit) => start(event, emit));
  }

  start(PermissionEvent event, Emitter<PermissionState> emit) async {
    try {
      if (event is GetStoragePermission) {
        await getStoragePermission();
        emit(StoragePermissionGranted());
      } else if (event is GetCameraPermission) {
        await getCameraPermission();
        emit(CameraPermissionGranted());
      }
    } catch (e) {
      emit(PermissionFailed(e.toString()));
    }
  }

  getCameraPermission() async {
    await permissionCamera!.request().then((res) => cameraStatus = res);

    if (cameraStatus == PermissionStatus.permanentlyDenied) {
      showDeniedDialog('Camera permission is needed to take a photo');
    } else if (cameraStatus == PermissionStatus.denied) {
      throw 'Camera permission is needed to take a photo';
    } else if (cameraStatus == PermissionStatus.granted) {
      return;
    }
  }

  getStoragePermission() async {
    await permissionGallery!.request().then((res) => galleryStatus = res);

    if (galleryStatus == PermissionStatus.permanentlyDenied) {
      showDeniedDialog('Storage permission is needed to take a photo');
    } else if (galleryStatus == PermissionStatus.denied) {
      throw 'Storage permission is needed to take a photo';
    } else if (galleryStatus == PermissionStatus.granted) {
      return;
    }
  }
}
