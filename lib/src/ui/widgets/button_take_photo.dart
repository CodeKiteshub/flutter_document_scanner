import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_document_scanner/src/document_scanner_controller.dart';

class ButtonTakePhoto extends StatelessWidget {
  final bool hide;
  final String image;
  const ButtonTakePhoto({
    Key? key,
    this.hide = false,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hide) {
      return Container();
    }

    return Center(
      child: GestureDetector(
          onTap: () => context.read<DocumentScannerController>().takePhoto(),
          child: Image.asset(image, scale: 4)
          // child: Container(
          //   height: 74,
          //   width: 74,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(
          //       color: Colors.white,
          //       width: 6,
          //     ),
          //   ),
          //   child: Center(
          //     child: Container(
          //       height: 25,
          //       width: 25,
          //       decoration: const BoxDecoration(
          //         color: Color(0xffd8345e),
          //         shape: BoxShape.circle,
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
