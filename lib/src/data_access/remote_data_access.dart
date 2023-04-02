import 'dart:convert';

import 'package:extructura_app/src/interfaces/i_data_access.dart';
import 'package:extructura_app/src/models/image_model.dart';
import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';
import 'package:extructura_app/src/support/network/http_method_enum.dart';
import 'package:extructura_app/src/support/network/network.dart';
import 'package:extructura_app/src/support/network/network_request.dart';
import 'package:extructura_app/src/support/network/network_response.dart';
import 'package:extructura_app/values/k_api.dart';

class RemoteDataAccess implements IDataAccess {
  @override
  late String token;

  @override
  Future<InvoiceModel?> getInvoice() async {
    NetworkRequest request = NetworkRequest(
      url: kApiInvoice,
      httpMethod: HttpMethodEnum.httpGet,
      enableCache: false,
    );

    NetworkResponse? response = await Network().callApi(request);

    if (response != null && response.response != null) {
      InvoiceModel? invoice =
          InvoiceModel.fromJson(jsonDecode(response.response!));
      return invoice;
    } else {
      return null;
    }
  }

  @override
  Future<bool?> postSendImage(ImageModel image) async {
    NetworkRequest request = NetworkRequest(
      url: kApiSendImage,
      jsonBody: jsonEncode({"base64Image": image.getBase64()}),
      httpMethod: HttpMethodEnum.httpPost,
      enableCache: false,
    );

    NetworkResponse? response = await Network().callApi(request);

    if (response != null && response.response != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool?> postRequestHeaderProcessing() async {
    NetworkRequest request = NetworkRequest(
      url: kApiHeader,
      httpMethod: HttpMethodEnum.httpPost,
      enableCache: false,
    );

    NetworkResponse? response = await Network().callApi(request);

    if (response != null && response.response != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool?> postRequestItemsProcessing() async {
    NetworkRequest request = NetworkRequest(
      url: kApiItems,
      httpMethod: HttpMethodEnum.httpPost,
      enableCache: false,
    );

    NetworkResponse? response = await Network().callApi(request);

    if (response != null && response.response != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool?> postRequestFooterProcessing() async {
    NetworkRequest request = NetworkRequest(
      url: kApiFooter,
      httpMethod: HttpMethodEnum.httpPost,
      enableCache: false,
    );

    NetworkResponse? response = await Network().callApi(request);

    if (response != null && response.response != null) {
      return true;
    } else {
      return false;
    }
  }
}
