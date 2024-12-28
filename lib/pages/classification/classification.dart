// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:test_project/services/classification-service.dart';



// class ClassifyPage extends StatefulWidget {
//   @override
//   _ClassifyPageState createState() => _ClassifyPageState();
// }

// class _ClassifyPageState extends State<ClassifyPage> {
//   final ImagePicker _picker = ImagePicker();
//   final TfliteService _modelService = TfliteService();
//   String _classification = "Classify Images";
//   Uint8List? _imageBytes;

//   @override
//   void initState() {
//     super.initState();
//     _modelService.loadModel();
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();
//       setState(() {
//         _imageBytes = bytes;
//       });
//       _classifyImage(bytes);
//     }
//   }

//   void _classifyImage(Uint8List imageBytes) async {
//     final result = _modelService.classifyImage(imageBytes);
//     setState(() {
//       _classification = result;
//     });
//   }

//   @override
//   void dispose() {
//     _modelService.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Classifier'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             _classification,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           if (_imageBytes != null)
//             Image.memory(
//               _imageBytes!,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             icon: Icon(Icons.camera_alt),
//             label: Text('Camera'),
//             onPressed: () => _pickImage(ImageSource.camera),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton.icon(
//             icon: Icon(Icons.image),
//             label: Text('Gallery'),
//             onPressed: () => _pickImage(ImageSource.gallery),
//           ),
//         ],
//       ),
//     );
//   }
// }

// The New Widget 222222222222222222222222222222


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:html' as html;

// import 'package:test_project/services/classification-service.dart';

// class FruitClassifierWidget extends StatefulWidget {
//   const FruitClassifierWidget({Key? key}) : super(key: key);

//   @override
//   State<FruitClassifierWidget> createState() => _FruitClassifierWidgetState();
// }

// class _FruitClassifierWidgetState extends State<FruitClassifierWidget> {
//   final TensorFlowService _tfliteService = TensorFlowService();
//   String _prediction = 'No prediction yet';
//   bool _isLoading = true;
//   String? _imageUrl;
//   Uint8List? _imageBytes;

//   @override
//   void initState() {
//     super.initState();
//     _loadModel();
//   }

//   Future<void> _loadModel() async {
//     await _tfliteService.loadModel();
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   Future<void> _pickAndClassifyImage() async {
//     final html.FileUploadInputElement input = html.FileUploadInputElement()
//       ..accept = 'image/*';
//     input.click();

//     await input.onChange.first;
//     if (input.files?.isEmpty ?? true) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final html.File file = input.files![0];
//       final reader = html.FileReader();
//       reader.readAsArrayBuffer(file);

//       await reader.onLoad.first;
//       final Uint8List bytes = Uint8List.fromList(reader.result as List<int>);
      
//       // Create URL for image preview
//       final blob = html.Blob([bytes]);
//       final url = html.Url.createObjectUrlFromBlob(blob);
      
//       // Classify image
//       final prediction = await _tfliteService.classifyImage(bytes);
      
//       setState(() {
//         _imageBytes = bytes;
//         _imageUrl = url;
//         _prediction = prediction;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _prediction = 'Error processing image: $e';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fruit Classifier'),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (_isLoading)
//                   const CircularProgressIndicator()
//                 else
//                   Column(
//                     children: [
//                       if (_imageUrl != null)
//                         Container(
//                           margin: const EdgeInsets.symmetric(vertical: 16),
//                           height: 200,
//                           width: 200,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               _imageUrl!,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ElevatedButton.icon(
//                         onPressed: _pickAndClassifyImage,
//                         icon: const Icon(Icons.upload_file),
//                         label: const Text('Upload Image'),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           'Prediction: $_prediction',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _tfliteService.dispose();
//     // Clean up object URLs
//     if (_imageUrl != null) {
//       html.Url.revokeObjectUrl(_imageUrl!);
//     }
//     super.dispose();
//   }
// }


// 333333333333333333333333333333333333333333
// import 'package:flutter/material.dart';
// import 'dart:html' as html;
// import 'dart:typed_data';

// import 'package:test_project/services/classification-service.dart';

// class FruitClassifierWidget extends StatefulWidget {
//   const FruitClassifierWidget({Key? key}) : super(key: key);

//   @override
//   State<FruitClassifierWidget> createState() => _FruitClassifierWidgetState();
// }

// class _FruitClassifierWidgetState extends State<FruitClassifierWidget> {
//   final TensorFlowService _tensorFlowService = TensorFlowService();
//   String _prediction = 'No prediction yet';
//   bool _isLoading = true;
//   String? _imageUrl;
//   Uint8List? _imageBytes;

//   @override
//   void initState() {
//     super.initState();
//     _loadModel();
//   }

//   Future<void> _loadModel() async {
//     await _tensorFlowService.loadModel();
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   Future<void> _pickAndClassifyImage() async {
//     final html.FileUploadInputElement input = html.FileUploadInputElement()
//       ..accept = 'image/*';
//     input.click();

//     await input.onChange.first;
//     if (input.files?.isEmpty ?? true) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final html.File file = input.files![0];
//       final reader = html.FileReader();
//       reader.readAsArrayBuffer(file);

//       await reader.onLoad.first;
//       final Uint8List bytes = Uint8List.fromList(reader.result as List<int>);

//       // Create a URL for image preview
//       final blob = html.Blob([bytes]);
//       final url = html.Url.createObjectUrlFromBlob(blob);

//       // Classify image
//       final prediction = await _tensorFlowService.classifyImage(bytes);

//       setState(() {
//         _imageBytes = bytes;
//         _imageUrl = url;
//         _prediction = prediction;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _prediction = 'Error processing image: $e';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fruit Classifier'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (_isLoading)
//                 const CircularProgressIndicator()
//               else
//                 Column(
//                   children: [
//                     if (_imageUrl != null)
//                       Container(
//                         margin: const EdgeInsets.symmetric(vertical: 16),
//                         height: 200,
//                         width: 200,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(
//                             _imageUrl!,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ElevatedButton.icon(
//                       onPressed: _pickAndClassifyImage,
//                       icon: const Icon(Icons.upload_file),
//                       label: const Text('Upload Image'),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Prediction: $_prediction',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Clean up resources
//     if (_imageUrl != null) {
//       html.Url.revokeObjectUrl(_imageUrl!);
//     }
//     super.dispose();
//   }
// }

// 44444444444444444444444444444444444444444444444444444444444

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import 'package:test_project/services/classification-service.dart';

class ImageClassificationPage extends StatefulWidget {
  const ImageClassificationPage({super.key});

  @override
  _ImageClassificationPageState createState() => _ImageClassificationPageState();
}

class _ImageClassificationPageState extends State<ImageClassificationPage> {
  final ImagePicker _picker = ImagePicker();
  final ModelService _modelService = ModelService();
  String _classification = "Select an image to classify";
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadModel().then((_) {
      print('Model initialized successfully');
    }).catchError((e) {
      print('Failed to initialize model: $e');
    });
  }


  Future<void> _loadModel() async {
    await _modelService.loadModel('assets/models/fruits_model_optimized.tflite');
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
      _classifyImage(bytes);
    }
  }

  void _classifyImage(Uint8List imageBytes) async {
    final result = await _modelService.classifyImage(imageBytes);
    setState(() {
      _classification = result;
    });
  }

  @override
  void dispose() {
    _modelService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit Image Classifier'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _classification,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          if (_imageBytes != null)
            Image.memory(
              _imageBytes!,
              height: 250,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Capture from Camera'),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.image),
            label: const Text('Select from Gallery'),
            onPressed: () => _pickImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }
}

