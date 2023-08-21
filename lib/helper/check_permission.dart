import 'package:permission_handler/permission_handler.dart';
import 'package:handover/helper/extensions/debugger_extension.dart';

Future<bool> requestPermission(Permission permission) async => await permission.request().then((status) {
      'status $status --- status.isGranted ${status.isGranted}'.debug('requestPermission');
      return status.isGranted;
    });
