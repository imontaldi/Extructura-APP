import 'package:flutter/material.dart';
import 'package:extructura_app/values/k_colors.dart';

class SnackBarPictureSourceComponent {
  static SnackBar build(context, onTakePictureFromPDFButtonTap,
      onTakePictureFromCameraButtonTap, onTakePictureFromGaleryButtonTap) {
    return SnackBar(
      dismissDirection: DismissDirection.down,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onTakePictureFromPDFButtonTap();
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                },
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.file_copy, color: KPrimary),
                        SizedBox(height: 3),
                        Text(
                          "Documento\n(Archivos)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            color: KGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onTakePictureFromGaleryButtonTap();
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                },
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.perm_media, color: KPrimary),
                        SizedBox(height: 3),
                        Text(
                          "Galería\n(Imágen)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            color: KGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  await onTakePictureFromCameraButtonTap();
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                },
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.camera_alt, color: KPrimary),
                        SizedBox(height: 3),
                        Text(
                          "Cámara",
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            color: KGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
