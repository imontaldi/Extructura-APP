import 'dart:convert';
import 'dart:io';
import 'package:extructura_app/src/data_access/dummy_data_access.dart';
import 'package:extructura_app/src/data_access/remote_data_access.dart';
import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:extructura_app/src/enums/culture.dart';
import 'package:extructura_app/src/interfaces/i_data_access.dart';
import 'package:extructura_app/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/faq_model.dart';

class DataManager {
  static final DataManager _instance = DataManager._constructor();
  late SharedPreferences prefs;
  late IDataAccess dataAccess;

  Culture selectedCulture = Culture.es;

  factory DataManager() {
    return _instance;
  }

  DataManager._constructor();

  init() async {
    dataAccess = RemoteDataAccess();

    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      dataAccess = DummyDataAccess();
    }
    prefs = await SharedPreferences.getInstance();
    //_dataAccess?.token = _getToken();
  }

  saveToken(String? token) async {
    try {
      await prefs.setString('token', token ?? "");
      dataAccess.token = token!;
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  hasSession() {
    return hasToken() != null;
  }

  hasToken() {
    return prefs.getString('token') != null;
  }

  saveRemember(bool value) {
    prefs.setString('remember', value.toString());
  }

  saveUser(String value) {
    prefs.setString('savedUser', value);
  }

  bool getRemember() {
    String? remember = prefs.getString('remember');
    bool value = remember != null ? remember.parseBool() : false;
    return value;
  }

  String? getSavedUser() {
    return getRemember() ? prefs.getString('savedUser') : null;
  }

  void cleanData() async {
    await prefs.remove("token");
    await prefs.remove("currentProfile");
    await prefs.remove('notifications');
  }

  getCulture() {
    String? prefCulture = prefs.getString('culture');
    if (prefCulture != null) {
      if (jsonDecode(prefs.getString('culture')!) == "Culture.es") {
        return Culture.es;
      } else {
        return Culture.en;
      }
    }
    return Culture.es;
  }

  bool isFirstSession() {
    return prefs.getBool('firstSession') ?? true;
  }

  Future<void> saveFirstSession(bool check) async {
    try {
      await prefs.setBool('firstSession', check);
    } catch (ex) {
      throw Exception(ex);
    }
  }

  // Requests
  Future<InvoiceModel?> getInvoice() async {
    return await dataAccess.getInvoice();
  }

  Future<bool?> postSendImage(File image, int imageTypeId) async {
    return await dataAccess.postSendImage(image, imageTypeId);
  }

  Future<bool?> postRequestHeaderProcessing() async {
    return await dataAccess.postRequestHeaderProcessing();
  }

  Future<bool?> postRequestItemsProcessing() async {
    return await dataAccess.postRequestItemsProcessing();
  }

  Future<bool?> postRequestFooterProcessing() async {
    return await dataAccess.postRequestFooterProcessing();
  }

  Future<List<FAQModel>?> getFaqList() async {
    List<FAQModel>? result = await dataAccess.getFaqList();
    return result;
  }
}
