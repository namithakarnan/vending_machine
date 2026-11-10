import 'package:flutter/foundation.dart';
import 'package:vending_machine/main.dart';
import 'package:vending_machine/services/voice_services.dart';

class VoiceProvider extends ChangeNotifier {
  final VoiceService _voiceService = VoiceService();

  bool isInitialized = false;
  bool isListening = false;
  bool isSpeaking = false;

  VendingState state = VendingState.welcome;
  String recognizedText = '';
  String response = 'Welcome! What would you like today?';
  String? errorMessage;

  Future<void> initialize() async {
    isInitialized = await _voiceService.initialize(
      onStatus: (status) {
        isListening = status == 'listening';

        notifyListeners();
      },
      onError: (error) {
        errorMessage = error;
        isListening = false;
        notifyListeners();
      },
    );

    notifyListeners();
    await startListening();
  }

  Future<void> startListening() async {
    if (!isInitialized) {
      errorMessage = 'Speech recognition is unavailable.';
      notifyListeners();
      return;
    }

    await _voiceService.stopSpeaking();

    recognizedText = '';
    response = 'Listening...';
    errorMessage = null;
    isListening = true;
    notifyListeners();

    await _voiceService.startListening(
      onResult: (text, isFinal) {
        recognizedText = text;
        notifyListeners();

        if (isFinal) {
          processCommand(text);
        }
      },
    );
    print('Recognized Text: $recognizedText');
  }

  Future<void> stopListening() async {
    await _voiceService.stopListening();
    isListening = false;
    notifyListeners();
  }

  Future<void> processCommand(String command) async {
    final text = command.toLowerCase().trim();
    String reply;

    if (text.contains('water')) {
      reply = 'You selected water.';
    } else if (text.contains('juice')) {
      reply = 'You selected juice.';
    } else if (text.contains('chips')) {
      reply = 'You selected chips.';
    } else if (text.contains('cancel') || text.contains('stop')) {
      reply = 'Your request has been cancelled.';
    } else if (text.contains('hello') ||
        text.contains('hi') ||
        text.contains('start')) {
      state = VendingState.listening;
      reply = 'Hello! What would you like today?';
    } else {
      reply = 'Sorry, I did not understand. Please try again.';
    }

    response = reply;
    isListening = false;
    isSpeaking = true;
    notifyListeners();

    await _voiceService.speak(reply);

    isSpeaking = false;
    notifyListeners();
  }

  Future<void> speak(String text) async {
    isSpeaking = true;
    notifyListeners();

    await _voiceService.speak(text);

    isSpeaking = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _voiceService.dispose();
    super.dispose();
  }
}
