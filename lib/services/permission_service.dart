import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestContactsPermission() async {
    if (await Permission.contacts.isGranted) {
      return true;
    }
    var status = await Permission.contacts.isDenied;
    if (status) {
      final permissionStatus = await Permission.contacts.request();
      return permissionStatus.isGranted ? true : false;
    }

    return false;
  }

  static Future<bool> requestCameraPermission() async {
    if (await Permission.camera.isGranted) {
      return true;
    }
    var status = await Permission.camera.isDenied;
    if (status) {
      final permissionStatus = await Permission.camera.request();
      return permissionStatus.isGranted ? true : false;
    }

    return false;
  }
}
