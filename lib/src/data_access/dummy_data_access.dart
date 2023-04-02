import 'dart:io';
import 'package:extructura_app/src/exceptions/exception_launcher.dart';
import 'package:extructura_app/src/interfaces/i_data_access.dart';
import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';
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
  Future<InvoiceModel?> getInvoice() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> postRequestFooterProcessing() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> postSendImage(ImageModel image) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> postRequestHeaderProcessing() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> postRequestItemsProcessing() {
    throw UnimplementedError();
  }
}
