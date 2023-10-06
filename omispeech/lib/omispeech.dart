import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';
import 'dart:async';

OmispeechPlatform get _platform => OmispeechPlatform.instance;

Stream<String> get recognitionResults => _platform.recognitionResultController.stream;

/// Returns the name of the current platform.
Future<void> startListening() async {
  await _platform.startListening();
}

/// Returns the name of the current platform.
Future<void> cancelListening() async {
  await _platform.cancelListening();
}

/// Returns the name of the current platform.
Future<void> stopListening() async {
  await _platform.stopListening();
}
