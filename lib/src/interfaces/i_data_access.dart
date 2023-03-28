import 'package:extructura_app/src/models/image_model.dart';
import 'package:extructura_app/src/models/invoice_model.dart';

abstract class IDataAccess {
  late String token;
  Future<InvoiceModel?> getInvoice();
  Future<bool?> postRequestItemsProcessing();
  Future<bool?> postRequestHeaderProcessing();
  Future<bool?> postRequestFooterProcessing();
  Future<bool?> postSendImage(ImageModel image);
}
