import 'dart:async';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';

/// An implementation of [OmispeechPlatform] that uses method channels.
class MethodChannelOmispeech extends OmispeechPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('omispeech');

  @override
  Future<String?> startListening() {
    return methodChannel.invokeMethod<String>('startListening');
  }

  @override
  Future<String?> cancelListening() {
    return methodChannel.invokeMethod<String>('cancelListening');
  }

  @override
  Future<String?> stopListening() {
    return methodChannel.invokeMethod<String>('startListening');
  }
}
