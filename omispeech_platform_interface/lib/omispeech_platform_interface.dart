import 'dart:async';

import 'package:omispeech_platform_interface/src/method_channel_omispeech.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of omispeech must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `Omispeech`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [OmispeechPlatform] methods.
abstract class OmispeechPlatform extends PlatformInterface {
  /// Constructs a OmispeechPlatform.
  OmispeechPlatform() : super(token: _token);

  static final Object _token = Object();

  static OmispeechPlatform _instance = MethodChannelOmispeech();

  /// The default instance of [OmispeechPlatform] to use.
  ///
  /// Defaults to [MethodChannelOmispeech].
  static OmispeechPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [OmispeechPlatform] when they register themselves.
  static set instance(OmispeechPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }
  final StreamController<String> recognitionResultController = StreamController<String>.broadcast();


  /// Starts the listening process
  Future<String?> startListening();
  /// Cancels listening.
  Future<String?> cancelListening();
  /// Stops listening.
  Future<String?> stopListening();

}
