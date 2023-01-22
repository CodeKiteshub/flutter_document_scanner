import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_document_scanner/src/bloc/app/app_bloc.dart';
import 'package:flutter_document_scanner/src/bloc/app/app_state.dart';
import 'package:flutter_document_scanner/src/ui/widgets/button_take_photo.dart';
import 'package:flutter_document_scanner/src/utils/take_photo_document_style.dart';

class TakePhotoDocumentPage extends StatelessWidget {
  final TakePhotoDocumentStyle takePhotoDocumentStyle;
  final String camerabutton;

  final String pdfimage;
  final String galleryimage;
  final VoidCallback pdftools;
  final VoidCallback gallery;
  const TakePhotoDocumentPage({
    Key? key,
    required this.takePhotoDocumentStyle,
    required this.camerabutton,
    required this.pdfimage,
    required this.galleryimage,
    required this.pdftools,
    required this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, AppStatus>(
      selector: (state) => state.statusCamera,
      builder: (context, state) {
        switch (state) {
          case AppStatus.initial:
            return Container();

          case AppStatus.loading:
            return takePhotoDocumentStyle.onLoading;

          case AppStatus.success:
            return _CameraPreview(
              takePhotoDocumentStyle: takePhotoDocumentStyle,
              camerabutton: camerabutton,
              pdfimage: pdfimage,
              galleryimage: galleryimage,
              pdftools: pdftools,
              gallery: gallery,
            );

          case AppStatus.failure:
            return Container();
        }
      },
    );
  }
}

class _CameraPreview extends StatelessWidget {
  final TakePhotoDocumentStyle takePhotoDocumentStyle;
  final String camerabutton;
  final String pdfimage;
  final String galleryimage;
  final VoidCallback pdftools;
  final VoidCallback gallery;
  const _CameraPreview({
    Key? key,
    required this.takePhotoDocumentStyle,
    required this.camerabutton,
    required this.pdfimage,
    required this.galleryimage,
    required this.pdftools,
    required this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, CameraController?>(
      selector: (state) => state.cameraController,
      builder: (context, state) {
        if (state == null) {
          return const Center(
            child: Text(
              "No Camera",
            ),
          );
        }

        return Stack(
          // fit: StackFit.expand,
          children: [
            // * Camera
            Positioned(
              top: takePhotoDocumentStyle.top ?? 0,
              bottom: takePhotoDocumentStyle.bottom ?? 0,
              left: takePhotoDocumentStyle.left ?? 0,
              right: takePhotoDocumentStyle.right ?? 0,
              child: CameraPreview(state),
            ),

            // * children
            if (takePhotoDocumentStyle.children != null)
              ...takePhotoDocumentStyle.children!,

            /// Default
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: pdftools,
                      child: Image.asset(pdfimage, scale: 1.5)),
                  ButtonTakePhoto(
                    image: camerabutton,
                  ),
                  InkWell(
                      onTap: gallery,
                      child: Image.asset(galleryimage, scale: 1.3)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
