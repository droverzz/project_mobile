// A widget that displays the picture taken by the user.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../helpers/food_guru.dart';
import '../../models/recipe.dart';
import '../recipe_detail_screen.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  Future<String> getModelPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    if (await file.exists()) {
      debugPrint('Model loaded successfully: $path');
    } else {
      debugPrint('Failed to load model: $path');
    }
    return file.path;
  }

  Future<List<String>> findFood() async {
    final InputImage inputImage = InputImage.fromFilePath(imagePath);

    final modelPath = await getModelPath('assets/ml/aiy.tflite');

    final options = LocalObjectDetectorOptions(
      mode: DetectionMode.single,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );

    final objectDetector = ObjectDetector(options: options);

    final List<DetectedObject> objects =
        await objectDetector.processImage(inputImage);

    final List<String> detectedObjects = [];

    for (DetectedObject detectedObject in objects) {
      final rect = detectedObject.boundingBox;
      final trackingId = detectedObject.trackingId;

      for (Label label in detectedObject.labels) {
        detectedObjects.add(label.text);
      }
    }

    objectDetector.close();

    return detectedObjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ผลการค้นหาด้วยภาพ')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: FutureBuilder(
          future: findFood(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Image.file(File(imagePath)),
                  const SizedBox(height: 20),
                  snapshot.data!.isNotEmpty
                      ? ElevatedButton(
                      onPressed: () async {
                        try {
                          _loadingDialog(context);
                          final stream =
                          FoodGuru().provider.sendMessageStream('Find recipe for ${snapshot.data!.first}');
                          var response = await stream.join();
                          final json = jsonDecode(response);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecipeDetailScreen(recipe: Recipe.fromJson(
                                      json['recipe'])),
                            ),
                          );
                        } catch (e) {
                          Navigator.pop(context);
                          _errorDialog(context);
                        }
                      },
                      child: Text('ค้นหาสูตรสำหรับ ${snapshot.data!.first}')
                  )
                      : const Text('ไม่เจออาหารในภาพ'),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

void _loadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text('กำลังโหลดข้อมูล...'),
          ],
        ),
      );
    },
  );
}

void _errorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('ไม่สามารถเชื่อมต่อกับ Food Guru ได้'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ปิด'),
          ),
        ],
      );
    },
  );
}
