import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:extructura_app/src/enums/image_type_enum.dart';
import 'package:extructura_app/src/managers/page_manager/page_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:extructura_app/src/ui/components/entry/images/snack_bar_picture_source_component.dart';
import 'package:extructura_app/src/ui/pages/pdf_view_page.dart';
import 'package:extructura_app/src/ui/popups/loading_popup.dart';
import 'package:extructura_app/utils/page_args.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';
import 'package:quick_scanner/quick_scanner.dart';

// ignore: must_be_immutable
class ImageUploadComponent extends StatefulWidget {
  String? label;
  Function(File?)? getFile;
  File? file;
  String? imageUrl;
  Function()? deleteFile;
  Function()? deleteUrl;
  Function()? onTap;
  bool? isEditable;
  double height;
  double width;
  double cropRatio;
  bool editImageAfterPick = false;
  CustomCropperOptions? customCropperOptions;
  bool enableGallery = true;
  bool enableCamera = true;
  Function(ImageTypeEnum)? imageTypePicked;

  ImageUploadComponent({
    Key? key,
    this.label,
    required this.getFile,
    this.file,
    this.imageUrl,
    required this.deleteFile,
    this.deleteUrl,
    this.onTap,
    this.height = 240,
    this.width = 350,
    this.cropRatio = 1,
    this.isEditable = true,
    this.editImageAfterPick = false,
    this.customCropperOptions,
    this.enableCamera = true,
    this.enableGallery = true,
    this.imageTypePicked,
  }) : super(key: key);

  @override
  ImageUploadComponentState createState() => ImageUploadComponentState();
}

class ImageUploadComponentState extends State<ImageUploadComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
        onTap();
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: KGrey_L2,
              spreadRadius: -1,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          children: [
            widget.file != null ||
                    (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                ? widget.file != null
                    ? Image.file(
                        widget.file!,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.imageUrl!,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => _placeHolder(),
                        placeholder: (context, url) => _placeHolder(),
                      )
                : _placeHolder(),
            _buttonTrash(widget.file, widget.imageUrl, widget.deleteFile,
                widget.deleteUrl),
          ],
        ),
      ),
    );
  }

  void onTap() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBarPictureSourceComponent.build(
          context, getImageFromPDF, getImageFromGallery,
          onTakePictureFromCameraButtonTap: getImageFromCamera,
          onTakePictureFromPrinterButtonTap: getImageFromScanner),
    );
  }

  // Inicio Gallery
  Future getImageFromGallery() async {
    bool permissionsGranted = await checkStoragePermissions();
    if (permissionsGranted) {
      try {
        File? file;
        FilePickerResult? result =
            await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null) {
          file = File(result.files.single.path!);
        } else {
          debugPrint("Image selection cancelled");
          file = null;
        }

        if (file != null) {
          if (widget.editImageAfterPick) {
            File? temp = await cropImage(file.path);
            if (temp != null) {
              file = temp;
            }
          }
          showFilePicked(file.path, ImageTypeEnum.photo);
        }
      } catch (ex) {
        debugPrint(ex.toString());
      }
    } else {
      permission_handler.openAppSettings();
    }
  }

  Future<bool> checkStoragePermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      Map<permission_handler.Permission, permission_handler.PermissionStatus>
          statuses = {};
      if ((androidInfo.version.sdkInt) <= 32) {
        statuses = await [
          permission_handler.Permission.storage,
        ].request();
        return statuses[permission_handler.Permission.storage]!.isGranted ==
            true;
      } else {
        statuses = await [
          permission_handler.Permission.photos,
        ].request();
        return statuses[permission_handler.Permission.photos]!.isGranted ==
            true;
      }
    } else {
      Map<permission_handler.Permission, permission_handler.PermissionStatus>
          statuses = await [
        permission_handler.Permission.storage,
        permission_handler.Permission.photos,
      ].request();

      return statuses[permission_handler.Permission.storage]!.isGranted ==
              true &&
          statuses[permission_handler.Permission.photos]!.isGranted == true;
    }
  }

  // Fin Gallery

  // Inicio PDF
  Future getImageFromPDF() async {
    File? file;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      file = File(result.files.single.path!);
    } else {
      debugPrint("Document selection cancelled");
      file = null;
    }
    if (file != null) {
      // ignore: use_build_context_synchronously
      String? navigationResult = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewPage(PageArgs(pdfFileToShow: file)),
        ),
      );
      if (navigationResult != null) {
        showFilePicked(navigationResult, ImageTypeEnum.pdf);
      }
    }
  }

  // Fin PDF

  // Inicio Scanner
  Future getImageFromScanner() async {
    await LoadingPopup(
      context: context,
      loadingText: "Escaneando...",
      onLoading: getImageFromScannerLoading(),
      onResult: (data) => getImageFromScannerResult(data),
      onError: (error) => {
        PageManager().openDefaultErrorAlert(
            "No se pudo obtener imágen desde el escaner. Por favor, prueba reiniciandolo e intentando nuevamente.")
      },
    ).show();
  }

  Future<String?> getImageFromScannerLoading() async {
    QuickScanner.startWatch();
    Directory directory = await getApplicationSupportDirectory();
    String scannedFilePath = await QuickScanner.scanFile(
        (await QuickScanner.getScanners()).first, directory.path);
    QuickScanner.stopWatch();
    return scannedFilePath;
  }

  void getImageFromScannerResult(String scannedFilePath) {
    showFilePicked(scannedFilePath, ImageTypeEnum.scan);
  }

  // Fin Impresora

  // Inicio Camera
  getImageFromCamera() async {
    bool permissionsGranted = await checkCameraPermissions();
    if (permissionsGranted) {
      // ignore: use_build_context_synchronously
      await LoadingPopup(
          // ignore: use_build_context_synchronously
          context: PageManager().navigatorKey.currentState!.context,
          onLoading: getCameras(),
          onResult: (data) => openViewer(data),
          onError: (error) => {}).show();
    } else {
      permission_handler.openAppSettings();
    }
  }

  Future<bool> checkCameraPermissions() async {
    Map<permission_handler.Permission, permission_handler.PermissionStatus>
        statuses = await [
      permission_handler.Permission.camera,
    ].request();

    return statuses[permission_handler.Permission.camera]!.isGranted == true;
  }

  getCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    return cameras;
  }

  openViewer(List<CameraDescription> cameras) async {
    String? navigationResult = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(cameras),
      ),
    );
    if (navigationResult != null) {
      if (widget.editImageAfterPick) {
        File? temp = await cropImage(navigationResult);
        if (temp != null) {
          navigationResult = temp.path;
        }
      }
      showFilePicked(navigationResult, ImageTypeEnum.photo);
    }
  }

  showFilePicked(String path, ImageTypeEnum imageType) {
    setState(() {
      widget.file = File(path);
      widget.file != null
          ? widget.getFile!(widget.file)
          : widget.getFile!(File(path));
      widget.imageTypePicked!(imageType);
    });
  }

  Future<File?> cropImage(String? path) async {
    CustomCropperOptions customOptions =
        widget.customCropperOptions ?? CustomCropperOptions();
    customOptions.aspectRatio =
        CropAspectRatio(ratioX: widget.cropRatio, ratioY: 1);

    customOptions.uiSettings ??= [
      AndroidUiSettings(
        statusBarColor: KPrimary,
        toolbarTitle: "",
        toolbarColor: KPrimary,
        //lockAspectRatio: true,
        toolbarWidgetColor: KWhite,
        initAspectRatio: CropAspectRatioPreset.ratio16x9,
      ),
      IOSUiSettings(
        title: "",
      ),
    ];
    if (path != null) {
      try {
        CroppedFile? temp = await ImageCropper().cropImage(
          sourcePath: path,
          aspectRatio: customOptions.aspectRatio,
          compressFormat: customOptions.compressFormat,
          compressQuality: customOptions.compressQuality,
          cropStyle: customOptions.cropStyle,
          uiSettings: customOptions.uiSettings,
          maxHeight: customOptions.maxHeight,
          maxWidth: customOptions.maxWidth,
        );
        if (temp != null) {
          return File(temp.path);
        } else {
          throw Exception("Error al intentar recortar la imagen");
        }
      } catch (err) {
        throw Exception(err);
      }
    } else {
      throw Exception("Error al intentar recortar la imagen");
    }
  }

  _placeHolder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "images/icon_camera.png",
          height: 20,
          width: 20,
          color: KGrey_L2,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.label ?? "Toque aquí para cargar\nuna imágen de su factura",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: KGrey_L2,
            fontWeight: FontWeight.normal,
            fontSize: KFontSizeSmall30,
          ),
        )
      ],
    );
  }

  _buttonTrash(file, url, Function? deleteFile, Function? deleteUrl) {
    return Visibility(
      visible: (file != null || url != null) && widget.isEditable!,
      child: Positioned(
        bottom: -2,
        right: -2,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, right: 15),
          child: GestureDetector(
            onTap: () {
              file != null ? deleteFile!() : null;
              url != null && deleteUrl != null ? deleteUrl() : null;
            },
            child: Container(
              height: 35,
              width: 35,
              padding: const EdgeInsets.all(8),
              decoration: _iconTrashDecoration(),
              child: Image.asset(
                "images/icon_trash.png",
                fit: BoxFit.contain,
                color: KWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _iconTrashDecoration() {
    return const BoxDecoration(
      color: KPrimary,
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x40A62123),
          spreadRadius: 1,
          blurRadius: 1,
        ),
      ],
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const TakePictureScreen(this.cameras, {Key? key}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  CameraDescription? cameraDescription;

  @override
  void initState() {
    super.initState();
    _initCamera(widget.cameras.first);
    //WidgetsBinding.instance.addPostFrameCallback((_) => yourFunction(context));
  }

  void _initCamera(CameraDescription description) {
    _controller = CameraController(
      description,
      ResolutionPreset.max,
      enableAudio: false,
    );
    try {
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    } catch (e) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  takePicture() async {
    return await _controller.takePicture();
  }

  FlashMode flashMode = FlashMode.off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: KBlack,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
            flashMode == FlashMode.off
                ? _controller.setFlashMode(FlashMode.off)
                : _controller.setFlashMode(FlashMode.always);
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          color: KBlack,
                        ),
                        CameraPreview(_controller),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height / 8,
                          child: Row(
                            children: [
                              FloatingActionButton(
                                  heroTag: "button flash",
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  onPressed: () {
                                    setState(() {
                                      if (flashMode == FlashMode.off) {
                                        _controller
                                            .setFlashMode(FlashMode.always);
                                        flashMode = FlashMode.always;
                                      } else {
                                        _controller.setFlashMode(FlashMode.off);
                                        flashMode = FlashMode.off;
                                      }
                                    });
                                  },
                                  child: flashMode == FlashMode.off
                                      ? const Icon(Icons.flash_off)
                                      : const Icon(Icons.flash_on)),
                              const SizedBox(width: 20),
                              FloatingActionButton(
                                backgroundColor: KPrimary,
                                heroTag: "button camera",
                                onPressed: () async {
                                  await LoadingPopup(
                                      context: context,
                                      onLoading: takePicture(),
                                      onResult: (image) =>
                                          Navigator.pop(context, image.path),
                                      onError: (error) =>
                                          {Navigator.pop(context)}).show();
                                },
                                child: const Icon(Icons.camera_alt),
                              ),
                              const SizedBox(width: 20),
                              Visibility(
                                visible: widget.cameras.length > 1,
                                child: FloatingActionButton(
                                    heroTag: "button change camera",
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    onPressed: () async {
                                      setState(() {
                                        // get current lens direction (front / rear)
                                        final lensDirection = _controller
                                            .description.lensDirection;
                                        CameraDescription newDescription;
                                        if (lensDirection ==
                                            CameraLensDirection.front) {
                                          newDescription = widget.cameras
                                              .firstWhere((description) =>
                                                  description.lensDirection ==
                                                  CameraLensDirection.back);
                                        } else {
                                          newDescription = widget.cameras
                                              .firstWhere((description) =>
                                                  description.lensDirection ==
                                                  CameraLensDirection.front);
                                        }
                                        _initCamera(newDescription);
                                      });
                                    },
                                    child: Platform.isIOS
                                        ? const Icon(Icons.flip_camera_ios)
                                        : const Icon(
                                            Icons.flip_camera_android)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CustomCropperOptions {
  CropAspectRatio aspectRatio;
  ImageCompressFormat compressFormat;
  int compressQuality;
  CropStyle cropStyle;
  int? maxHeight;
  int? maxWidth;
  List<PlatformUiSettings>? uiSettings = [
    AndroidUiSettings(
      statusBarColor: KPrimary,
      toolbarTitle: "",
      toolbarColor: KPrimary,
      lockAspectRatio: true,
      toolbarWidgetColor: KWhite,
    ),
    IOSUiSettings(
      title: "",
    ),
  ];

  CustomCropperOptions({
    this.aspectRatio = const CropAspectRatio(ratioX: 1, ratioY: 1),
    this.compressFormat = ImageCompressFormat.png,
    this.compressQuality = 100,
    this.cropStyle = CropStyle.rectangle,
    this.maxHeight,
    this.maxWidth,
    this.uiSettings,
  });
}
