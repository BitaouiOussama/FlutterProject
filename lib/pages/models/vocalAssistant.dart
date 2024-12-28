import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_project/geminiApi.dart';
import 'package:test_project/menu.dart';

class VocalAssistant extends StatefulWidget {
  const VocalAssistant({super.key});

  @override
  State<VocalAssistant> createState() => _VocalAssistantState();
}

class _VocalAssistantState extends State<VocalAssistant> {
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  String gemini_resp = '';
  bool _speechEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:  Menu(),
      appBar: AppBar(
        title: const Text('Voice Assistant',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[700],
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Input Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        const Text(
                          'Your Voice Input',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _speechToText.isListening ? _lastWords : _lastWords.isEmpty ? 'Tap the mic to start speaking...' : _lastWords,
                        style: TextStyle(
                          fontSize: 16,
                          color: _lastWords.isEmpty ? Colors.grey[600] : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
               // Assistant Response Card - Now Expanded and Scrollable
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.assistant, color: Colors.blue[700]),
                          const SizedBox(width: 8),
                          const Text(
                            'Assistant Response',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              gemini_resp.isEmpty ? 'Response will appear here...' : gemini_resp,
                              style: TextStyle(
                                fontSize: 16,
                                color: gemini_resp.isEmpty ? Colors.grey[600] : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _speechToText.isListening ? _stopListening() : _startListening();
          if (!_speechToText.isListening && _lastWords.isNotEmpty) {
            gemini_resp = (await functionGemini(_lastWords))!;
            setState(() {});
          }
        },
        backgroundColor: Colors.blue[700],
        child: Icon(
          _speechToText.isListening ? Icons.stop : Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }
}