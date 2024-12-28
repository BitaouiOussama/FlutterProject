// import 'dart:typed_data';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;
// import 'package:flutter/services.dart';


// class TfliteService {
//   Interpreter? _interpreter;

//   Future<void> loadModel() async {
//     try {
//       _interpreter = await Interpreter.fromAsset('classification.tflite');
//     } catch (e) {
//       print('Error loading model: $e');
//     }
//   }

//   String classifyImage(Uint8List imageData) {
//     // Prepare input and output tensors
//     final input = imageData.buffer.asUint8List();
//     final output = List.filled(10, 0.0).reshape([1, 10]);

//     // Run inference
//     _interpreter?.run(input, output);

//     // Find the highest confidence class
//     final classIndex = output[0].indexWhere((val) => val == output[0].reduce((a, b) => a > b ? a : b));
//     return _getClassLabel(classIndex);
//   }

//   String _getClassLabel(int index) {
//     const labels = ['T-shirt', 'Trouser', 'Pullover', 'Dress', 'Coat', 'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot'];
//     return labels[index];
//   }

//   void dispose() {
//     _interpreter?.close();
//   }
// }

// 2222222222222222222222222222222222222222222222

// class TfliteService {
//   Interpreter? _interpreter;
//   List<String> _labels = [];
//   bool isLoaded = false;

//   // Initialize the service
//   Future<void> loadModel() async {
//     try {
//       // Load model
//       _interpreter = await Interpreter.fromAsset('assets/models/classification.tflite');
      
//       // Load labels
//       final labelData = await rootBundle.loadString('assets/models/labels.txt');
//       _labels = labelData.split('\n');
      
//       isLoaded = true;
//       print('Model and labels loaded successfully');
//     } catch (e) {
//       print('Error loading model or labels: $e');
//     }
//   }

//   Future<String> classifyImage(Uint8List imageData) async {
//     if (!isLoaded) return 'Model not loaded';

//     try {
//       // Decode image
//       final image = img.decodeImage(imageData);
//       if (image == null) return 'Failed to decode image';

//       // Resize image to 224x224
//       final resizedImage = img.copyResize(image, width: 224, height: 224);
      
//       // Convert image to input tensor format
//       var inputArray = List.generate(
//         1,
//         (index) => List.generate(
//           224,
//           (y) => List.generate(
//             224,
//             (x) {
//               final pixel = resizedImage.getPixel(x, y);
//               // Use proper color channel extraction
//               return [
//                 (pixel.r / 255.0),  // Red channel
//                 (pixel.g / 255.0),  // Green channel
//                 (pixel.b / 255.0),  // Blue channel
//               ];
//             },
//           ),
//         ),
//       );

//       // Prepare output tensor
//       var outputArray = List.filled(1 * _labels.length, 0).reshape([1, _labels.length]);

//       // Run inference
//       _interpreter?.run(inputArray, outputArray);

//       // Get prediction
//       final result = outputArray[0];
//       final maxScore = result.reduce((a, b) => a > b ? a : b);
//       final predictionIndex = result.indexOf(maxScore);

//       return _labels[predictionIndex];
//     } catch (e) {
//       print('Error classifying image: $e');
//       return 'Error classifying image';
//     }
//   }

//   // Get all labels
//   List<String> getLabels() => _labels;

//   // Clean up resources
//   void dispose() {
//     _interpreter?.close();
//   }
// }

// 3333333333333333333333333333333

// import 'dart:html' as html;
// import 'dart:js' as js;
// import 'dart:typed_data';
// import 'dart:js_util' as js_util;

// class TensorFlowService {
//   bool isLoaded = false;
//   final List<String> labels = ['Apple', 'Strawberry', 'Mango', 'Grape', 'Banana'];

//   Future<void> loadModel() async {
//     try {
//       // Wait for TensorFlow.js to be ready
//       await js.context.callMethod('waitForTensorFlow');
//       isLoaded = true;
//       print('TensorFlow.js model loaded successfully');
//     } catch (e) {
//       print('Error loading model: $e');
//     }
//   }

//   // Future<String> classifyImage(Uint8List imageBytes) async {
//   //   if (!isLoaded) return 'Model not loaded';

//   //   try {
//   //     // Create a blob from the image bytes
//   //     final blob = html.Blob([imageBytes]);
//   //     final url = html.Url.createObjectUrlFromBlob(blob);
      
//   //     // Create an image element
//   //     final img = html.ImageElement()
//   //       ..src = url
//   //       ..style.display = 'none';
      
//   //     // Wait for image to load
//   //     await img.onLoad.first;
      
//   //     // Call TensorFlow.js predict function
//   //     final result = js.context.callMethod('predictImage', [img]);
      
//   //     // Clean up
//   //     html.Url.revokeObjectUrl(url);
      
//   //     // Get the predicted class index
//   //     final predictionIndex = js.context.callMethod('getTopPrediction', [result]);
      
//   //     return labels[predictionIndex as int];
//   //   } catch (e) {
//   //     print('Error classifying image: $e');
//   //     return 'Error classifying image';
//   //   }
//   // }

//   Future<String> classifyImage(Uint8List imageBytes) async {
//   if (!isLoaded) return 'Model not loaded';

//   try {
//     // Create a blob from the image bytes
//     final blob = html.Blob([imageBytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);

//     // Create an image element
//     final img = html.ImageElement()
//       ..src = url
//       ..style.display = 'none';

//     // Wait for image to load
//     await img.onLoad.first;

//     // Call TensorFlow.js predict function
//     final jsResult = js.context.callMethod('predictImage', [img]);

//     // Convert the JavaScript result into a Dart-compatible list
//     final List<dynamic> result = js_util.getProperty(jsResult, 'values') as List<dynamic>;

//     // Clean up
//     html.Url.revokeObjectUrl(url);

//     // Get the predicted class index
//     final predictionIndex = js.context.callMethod('getTopPrediction', [result]);

//     return labels[predictionIndex as int];
//   } catch (e) {
//     print('Error classifying image: $e');
//     return 'Error classifying image';
//   }
// }
// }

// 4444444444444444444444444444444444444444444444444444

// import 'dart:html' as html;
// import 'dart:js' as js;
// import 'dart:typed_data';
// import 'dart:js_util' as js_util;

// class TensorFlowService {
//   bool isLoaded = false;
//   final List<String> labels = ['Apple', 'Strawberry', 'Mango', 'Grape', 'Banana'];

//   Future<void> loadModel() async {
//     try {
//       // Wait for TensorFlow.js to be ready
//       await js.context.callMethod('waitForTensorFlow');
//       isLoaded = true;
//       print('TensorFlow.js model loaded successfully');
//     } catch (e) {
//       print('Error loading model: $e');
//     }
//   }

//   Future<String> classifyImage(Uint8List imageBytes) async {
//     if (!isLoaded) return 'Model not loaded';

//     try {
//       // Create a blob from the image bytes
//       final blob = html.Blob([imageBytes]);
//       final url = html.Url.createObjectUrlFromBlob(blob);

//       // Create an image element
//       final img = html.ImageElement()
//         ..src = url
//         ..style.display = 'none';
//       html.document.body?.append(img);

//       // Wait for image to load
//       await img.onLoad.first;

//       try {
//         // Call TensorFlow.js predict function and await the result
//         final result = await js_util.promiseToFuture(
//           js.context.callMethod('predictImage', [img])
//         );

//         // Convert the prediction array to a List<double>
//         final List<double> predictions = (result as List).map((e) => (e as num).toDouble()).toList();

//         // Find the index of the highest probability
//         int predictionIndex = predictions.indexOf(predictions.reduce((a, b) => a > b ? a : b));

//         // Cleanup
//         img.remove();
//         html.Url.revokeObjectUrl(url);

//         return labels[predictionIndex];
//       } catch (e) {
//         print('Prediction error: $e');
//         return 'Error making prediction';
//       }
//     } catch (e) {
//       print('Error classifying image: $e');
//       return 'Error classifying image';
//     }
//   }
// }

// 5555555555555555555555555555555555555555555555555555555555


import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class ModelService {
  Interpreter? _interpreter;

  Future<void> loadModel(String s) async {
    try {
      _interpreter = await Interpreter.fromAsset(s);
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
      _interpreter = null;
    }
  }

  Future<String> classifyImage(Uint8List imageData) async {
    if (_interpreter == null) {
      return 'Model not loaded';
    }

    var processedImage = _preprocessImage(imageData);
    if (processedImage.isEmpty) {
      return 'Error: Preprocessed image is empty';
    }

    final output = List.filled(1 * 141, 0.0).reshape([1, 141]);  // Ensure List<double>

    try {
      _interpreter!.run(processedImage.buffer.asFloat32List().reshape([1, 64, 64, 3]), output);
    } catch (e) {
      print('Error during inference: $e');
      return 'Error during classification';
    }

    List<double> result = output[0].cast<double>();  // Cast to List<double>

    final classIndex = result.indexWhere(
          (val) => val == result.reduce((a, b) => a > b ? a : b),
    );

    return _getClassLabel(classIndex);
  }


  Uint8List _preprocessImage(Uint8List imageData) {
    img.Image? image = img.decodeImage(imageData);
    if (image == null) {
      throw Exception('Error decoding image');
    }

    // Resize to 64x64 (model input size)
    image = img.copyResize(image, width: 64, height: 64);

    // Convert to Float32 and normalize
    var convertedBytes = Float32List(64 * 64 * 3);
    int index = 0;

    for (int y = 0; y < 64; y++) {
      for (int x = 0; x < 64; x++) {
        final pixel = image.getPixel(x, y);
        convertedBytes[index++] = pixel.r / 255.0;  // Red
        convertedBytes[index++] = pixel.g / 255.0;  // Green
        convertedBytes[index++] = pixel.b / 255.0;  // Blue
      }
    }

    print('Preprocessed image size: ${convertedBytes.length}');
    return convertedBytes.buffer.asUint8List();
  }

  String _getClassLabel(int index) {
    const labels = [
      'Apple Braeburn', 'Apple Crimson Snow', 'Apple Golden 1', 'Apple Golden 2', 'Apple Golden 3',
      'Apple Granny Smith', 'Apple Pink Lady', 'Apple Red 1', 'Apple Red 2', 'Apple Red 3',
      'Apple Red Delicious', 'Apple Red Yellow 1', 'Apple Red Yellow 2', 'Apricot', 'Avocado',
      'Avocado ripe', 'Banana', 'Banana Red', 'Cactus fruit', 'Carambula',
      'Cauliflower', 'Cherry 1', 'Cherry 2', 'Cherry Rainier', 'Clementine',
      'Cocos', 'Corn', 'Cucumber Ripe', 'Cucumber Ripe 2', 'Dates',
      'Eggplant', 'Fig', 'Ginger Root', 'Granadilla', 'Grape Blue',
      'Grape Pink', 'Grape White', 'Grape White 2', 'Grape White 3', 'Grape White 4',
      'Grapefruit Pink', 'Grapefruit White', 'Guava', 'Hazelnut', 'Huckleberry',
      'Kaki', 'Kiwi', 'Kohlrabi', 'Kumquat', 'Lemon',
      'Lemon Meyer', 'Limes', 'Lychee', 'Mandarine', 'Mango',
      'Mangostan', 'Maracuja', 'Melon Piel de Sapo', 'Mulberry', 'Nectarine',
      'Onion Red', 'Onion Red Peeled', 'Onion White', 'Orange', 'Papaya',
      'Passion Fruit', 'Peach', 'Peach 2', 'Peach Flat', 'Pear',
      'Pear Abate', 'Pear Kaiser', 'Pear Monster', 'Pear Red', 'Pear Williams',
      'Pepino', 'Physalis', 'Physalis with Husk', 'Pineapple', 'Pitahaya Red',
      'Plum', 'Pomegranate', 'Pomelo Sweetie', 'Potato Red', 'Potato Red Washed',
      'Potato Sweet', 'Potato White', 'Quince', 'Rambutan', 'Raspberry',
      'Redcurrant', 'Salak', 'Strawberry', 'Strawberry Wedge', 'Tamarillo',
      'Tangelo', 'Tomato 1', 'Tomato 2', 'Tomato 3', 'Tomato 4',
      'Tomato Cherry Red', 'Tomato Maroon', 'Tomato Yellow', 'Walnut', 'Watermelon'
    ];

    return (index >= 0 && index < labels.length) ? labels[index] : 'Unknown';

  }


  void dispose() {
    _interpreter?.close();
    print('Interpreter disposed');
  }
}


