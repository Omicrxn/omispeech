import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omispeech_ios/omispeech_ios.dart';
import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OmispeechIOS', () {
    const kPlatformName = 'iOS';
    late OmispeechIOS omispeech;
    late List<MethodCall> log;

    setUp(() async {
      omispeech = OmispeechIOS();

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
      OmispeechIOS.registerWith();
      expect(OmispeechPlatform.instance, isA<OmispeechIOS>());
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
