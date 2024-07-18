// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as img;
// import 'package:tflite_v2/tflite_v2.dart';
// import 'dart:io';

// class AlzheimerScreen extends StatefulWidget {
//   const AlzheimerScreen({super.key});

//   @override
//   State<AlzheimerScreen> createState() => _AlzheimerScreenState();
// }

// class _AlzheimerScreenState extends State<AlzheimerScreen> {
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   Future<void> loadModel() async {
//     await Tflite.loadModel(
//       model: 'assets/alzheimer.tflite',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future<String> classifyAlzheimerImage(
//         String modelPath, String imageAssetPath) async {
//       // Load the model
//       var interpreter = await Tflite.loadModel(
//         model: modelPath,
//       );

//       // Load the image
//       ByteData data = await rootBundle.load(imageAssetPath);
//       List<int> bytes = data.buffer.asUint8List();
//       var image = img.decodeImage(Uint8List.fromList(bytes));

//       // Resize the image to match the target size (224x224)
//       image = img.copyResize(image!, width: 224, height: 224);

//       // Convert image to ByteData
//       var byteData = image.getBytes();
//       var imgBuffer = byteData.buffer.asUint8List();

//       // Run inference
//       var result = await Tflite.runModelOnBinary(
//         binary: imgBuffer,
//         numResults: 1,
//       );

//       // Process the result
//       var classLabel = result![0]['label'];
//       var classLabels = [
//         'Mild Demented',
//         'Moderate Demented',
//         'Non Demented',
//         'Very Mild Demented'
//       ];
//       var prediction = classLabels[classLabel];

//       // Close the interpreter
//       Tflite.close();

//       return prediction;
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Flutter ML App'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             classifyAlzheimerImage(
//                 'assets/alzheimer.tflite', 'assets/test.jpg');
//           },
//           child: Text('Upload Image'),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }
// }
