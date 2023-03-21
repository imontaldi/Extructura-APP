import 'package:extructura_app/src/models/image_model.dart';

abstract class IDataAccess {
  late String token;

  Future<bool?> getItems();
  Future<bool?> postSendImage(ImageModel image);
}
