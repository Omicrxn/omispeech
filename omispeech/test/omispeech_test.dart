import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:omispeech/omispeech.dart';
import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOmispeechPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements OmispeechPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Omispeech', () {
    late OmispeechPlatform omispeechPlatform;

    setUp(() {
      omispeechPlatform = MockOmispeechPlatform();
      OmispeechPlatform.instance = omispeechPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => omispeechPlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => omispeechPlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
