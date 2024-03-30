import 'dart:io';
import 'package:extructura_app/src/interfaces/i_data_access.dart';
import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';
import 'package:extructura_app/src/models/faq_model.dart';

class DummyDataAccess implements IDataAccess {
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
  Future<bool?> postSendImage(File image, int imageTypeId) {
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

  @override
  Future<List<FAQModel>?> getFaqList() {
    throw UnimplementedError();
  }
}
