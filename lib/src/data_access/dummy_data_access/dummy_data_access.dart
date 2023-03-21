import 'dart:io';
import 'package:extructura_app/src/exceptions/exception_launcher.dart';
import 'package:extructura_app/src/interfaces/i_data_access.dart';
import 'package:extructura_app/src/models/image_model.dart';

class DummyDataAccess implements IDataAccess {
  // Add this function in every dummy function for exception testing
  // ignore: unused_element
  _verifyExceptionThrow() {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      // print(StackTrace.current.toString());
      ExceptionLauncher().explode();
    }
  }

  @override
  late String token;

  @override
  Future<bool?> getItems() {
    // TODO: implement getItems
    throw UnimplementedError();
  }

  @override
  Future<bool?> postSendImage(ImageModel image) {
    // TODO: implement postSendImage
    throw UnimplementedError();
  }
}
