import 'package:google_generative_ai/google_generative_ai.dart';

Future<String?> functionGemini(String? prompt) async{

  final model = GenerativeModel(


  model: 'gemini-1.5-flash',
apiKey: "AIzaSyDUl6DFeiMjzdeEZ0DAwrjLRhADMa1joeo",
 );

  final response = await model.generateContent([Content.text(prompt!)]);
 return response.text;


 
}
