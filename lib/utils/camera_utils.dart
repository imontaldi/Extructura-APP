import 'dart:io';

import 'package:image/image.dart' as memory_image;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'dart:math' as math;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:exif/exif.dart';
import 'package:extructura_app/src/models/image_model.dart';

Future<bool> checkCameraPermissions() async {
  Map<permission_handler.Permission, permission_handler.PermissionStatus>
      statuses = await [
    permission_handler.Permission.camera,
    permission_handler.Permission.storage,
    permission_handler.Permission.photos,
  ].request();

  return statuses[permission_handler.Permission.camera]!.isGranted == true &&
      statuses[permission_handler.Permission.storage]!.isGranted == true &&
      statuses[permission_handler.Permission.photos]!.isGranted == true;
}

generateTargetPath(PickedFile imagePicked) {
  int rand = math.Random().nextInt(10000);
  String targetPath = imagePicked.path;
  targetPath = targetPath.replaceAll(
      RegExp(r"\.(?:jpg|gif|png|JPG|GIF|PNG|JPEG)"), "$rand.jpg");
  return targetPath;
}

generateTargetPathForGallery(File file) {
  int rand = math.Random().nextInt(10000);
  String targetPath = file.path;
  targetPath = targetPath.replaceAll(
      RegExp(r"\.(?:jpg|gif|png|JPG|GIF|PNG|JPEG)"), "$rand.jpg");
  return targetPath;
}

Future<File?> checkImageOrientation(String imagePath) async {
  final originalFile = File(imagePath);
  List<int> imageBytes = await originalFile.readAsBytes();
  int rand = math.Random().nextInt(10000);
  String targetPath = originalFile.path;
  targetPath = targetPath.replaceAll(
      RegExp(r"\.(?:jpg|gif|png|JPG|GIF|PNG|JPEG)"), "$rand.jpg");

  final originalImage = memory_image.decodeImage(imageBytes);
  final height = originalImage!.height;
  final width = originalImage.width;
  final exifData = await readExifFromBytes(imageBytes);

  if (exifData['Image Orientation'] != null &&
      exifData['Image Orientation']!.printable.contains('Horizontal')) {
    return await FlutterImageCompress.compressAndGetFile(
      originalFile.path,
      targetPath,
      quality: 100,
      keepExif: true,
      rotate: height >= width ? 0 : 90,
    );
  } else if (exifData['Image Orientation']!.printable.contains('180')) {
    if (height >= width) {
      return await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        targetPath,
        quality: 100,
        keepExif: true,
        rotate: -90,
      );
    }
  }

  return originalFile;
}

Future<bool> checkStoragePermissions() async {
  Map<permission_handler.Permission, permission_handler.PermissionStatus>
      statuses = await [
    permission_handler.Permission.storage,
    permission_handler.Permission.photos,
  ].request();

  return statuses[permission_handler.Permission.storage]!.isGranted == true &&
      statuses[permission_handler.Permission.photos]!.isGranted == true;
}

compressAndSaveImage(PickedFile imagePicked, String targetPath) async {
  var compressedImage = await FlutterImageCompress.compressAndGetFile(
      imagePicked.path, targetPath,
      quality: 80, keepExif: true);
  compressedImage = await checkImageOrientation(imagePicked.path);
  ImageModel imageModel = ImageModel(path: compressedImage!.path);
  File image = File(imageModel.path!);
  return image;
}

compressAndSaveImageForGallery(File file, String targetPath) async {
  var compressedImage = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 80, keepExif: true);
  compressedImage = await checkImageOrientation(compressedImage!.path);
  ImageModel imageModel = ImageModel(path: compressedImage!.path);
  File image = File(imageModel.path!);
  return image;
}
