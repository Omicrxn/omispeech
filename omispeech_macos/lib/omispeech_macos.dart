import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';

/// The MacOS implementation of [OmispeechPlatform].
class OmispeechMacOS extends OmispeechPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('omispeech_macos');

  /// Registers this class as the default instance of [OmispeechPlatform]
  static void registerWith() {
    OmispeechPlatform.instance = OmispeechMacOS();
  }
  OmiSpeechMacOS() {
    print("potato");
    methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'updatedString') {
        print("potato");
        String updatedString = call.arguments;
        recognitionResultController.add(updatedString);
      }
    });
  }

  @override
  Future<String?> startListening() {
    methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'updatedString') {
        print("potato");
        String updatedString = call.arguments;
        recognitionResultController.add(updatedString);
      }
    });
    return methodChannel.invokeMethod<String>('startListening');
  }

  @override
  Future<String?> cancelListening(){
    return methodChannel.invokeMethod<String>('cancelListening');
  }

  @override
  Future<String?> stopListening() {
    return methodChannel.invokeMethod<String>('stopListening');
  }

}
