import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omispeech_android/omispeech_android.dart';
import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OmispeechAndroid', () {
    const kPlatformName = 'Android';
    late OmispeechAndroid omispeech;
    late List<MethodCall> log;

    setUp(() async {
      omispeech = OmispeechAndroid();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(omispeech.methodChannel, (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      OmispeechAndroid.registerWith();
      expect(OmispeechPlatform.instance, isA<OmispeechAndroid>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await omispeech.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
