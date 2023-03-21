import 'dart:convert';

import 'package:extructura_app/src/interfaces/i_data_access.dart';
import 'package:extructura_app/src/models/image_model.dart';
import 'package:extructura_app/src/support/network/http_method_enum.dart';
import 'package:extructura_app/src/support/network/network.dart';
import 'package:extructura_app/src/support/network/network_request.dart';
import 'package:extructura_app/src/support/network/network_response.dart';
import 'package:extructura_app/values/k_api.dart';

class RemoteDataAccess implements IDataAccess {
  @override
  late String token;

  @override
  Future<bool?> getItems() async {
    NetworkRequest request = NetworkRequest(
      url: kApiItems,
      httpMethod: HttpMethodEnum.httpGet,
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
}
