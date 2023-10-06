import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omispeech_linux/omispeech_linux.dart';
import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OmispeechLinux', () {
    const kPlatformName = 'Linux';
    late OmispeechLinux omispeech;
    late List<MethodCall> log;

    setUp(() async {
      omispeech = OmispeechLinux();

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
      OmispeechLinux.registerWith();
      expect(OmispeechPlatform.instance, isA<OmispeechLinux>());
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
