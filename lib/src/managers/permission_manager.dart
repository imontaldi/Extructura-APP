import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static final PermissionManager _instance = PermissionManager._constructor();

  factory PermissionManager() {
    return _instance;
  }

  PermissionManager._constructor();

  Future<bool> getPermissionForLocation() async {
    return await _getPermission(Permission.locationWhenInUse);
  }

  Future<bool> _getPermission(Permission permission) async {
    bool hasPermission = await permission.isGranted;
    if (!hasPermission) {
      hasPermission = await permission.request().isGranted;
    }
    return hasPermission;
  }
}
