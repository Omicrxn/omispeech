import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';

/// The Windows implementation of [OmispeechPlatform].
class OmispeechWindows extends OmispeechPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('omispeech_windows');

  /// Registers this class as the default instance of [OmispeechPlatform]
  static void registerWith() {
    OmispeechPlatform.instance = OmispeechWindows();
  }


  @override
  Future<String?> startListening() {
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
