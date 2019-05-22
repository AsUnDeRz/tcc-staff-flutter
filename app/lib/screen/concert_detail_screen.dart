import 'dart:async';
import 'dart:io';

import 'package:app/color_config.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:path_provider/path_provider.dart';

class ConcertDetail extends StatefulWidget {
  final String concertName;

  ConcertDetail(this.concertName);

  @override
  State<StatefulWidget> createState() => new ConcertDetailState();
}

class ConcertDetailState extends State<ConcertDetail> {
  String concertName;
  CameraController controller;
  String imagePath;

  @override
  void initState() {
    super.initState();
    concertName = widget.concertName;
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorGuide.colorPrimary,
        title: Text(concertName),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: _cameraPreviewWidget(),
            ),
          )
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  Future<void> detectCamera() async {
    try {
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Pictures';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File imageFile = File(filePath);
      final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
      final BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
      final List<Barcode> barcodes = await barcodeDetector.detectInImage(visionImage);

      for (Barcode barcode in barcodes) {
//      final Rectangle<int> boundingBox = barcode.boundingBox;
//      final List<Point<int>> cornerPoints = barcode.cornerPoints;
        final String rawValue = barcode.rawValue;
        print("RawValue $rawValue");

        final BarcodeValueType valueType = barcode.valueType;
        print("ValueType $valueType");
      }
    } catch (e) {
      print(e);
    }
  }
}
