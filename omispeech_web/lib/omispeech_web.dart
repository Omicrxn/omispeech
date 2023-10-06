import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';
import 'dart:async';

/// The Web implementation of [OmispeechPlatform].
class OmispeechWeb extends OmispeechPlatform {
  /// Registers this class as the default instance of [OmispeechPlatform]
  static void registerWith([Object? registrar]) {
    OmispeechPlatform.instance = OmispeechWeb();
  }

  final StreamController<String> _recognitionResultController = StreamController<String>();
  Stream<String> get recognitionResults => _recognitionResultController.stream;

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
