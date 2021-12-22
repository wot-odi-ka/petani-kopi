class PermissionState {}

class InitialPermission extends PermissionState {}

class StoragePermissionGranted extends PermissionState {}

class CameraPermissionGranted extends PermissionState {}

class PermissionFailed extends PermissionState {
  final String error;

  PermissionFailed(this.error);
}
