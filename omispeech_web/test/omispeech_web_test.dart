import 'package:flutter_test/flutter_test.dart';
import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';
import 'package:omispeech_web/omispeech_web.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OmispeechWeb', () {
    const kPlatformName = 'Web';
    late OmispeechWeb omispeech;

    setUp(() async {
      omispeech = OmispeechWeb();
    });

    test('can be registered', () {
      OmispeechWeb.registerWith();
      expect(OmispeechPlatform.instance, isA<OmispeechWeb>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await omispeech.getPlatformName();
      expect(name, equals(kPlatformName));
    });
  });
}
