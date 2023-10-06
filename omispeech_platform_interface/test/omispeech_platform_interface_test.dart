// import 'package:flutter_test/flutter_test.dart';
// import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';
//
// class OmispeechMock extends OmispeechPlatform {
//   static const mockPlatformName = 'Mock';
//
//   @override
//   Future<String?> getPlatformName() async => mockPlatformName;
// }
//
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   group('OmispeechPlatformInterface', () {
//     late OmispeechPlatform omispeechPlatform;
//
//     setUp(() {
//       omispeechPlatform = OmispeechMock();
//       OmispeechPlatform.instance = omispeechPlatform;
//     });
//
//     group('getPlatformName', () {
//       test('returns correct name', () async {
//         expect(
//           await OmispeechPlatform.instance.getPlatformName(),
//           equals(OmispeechMock.mockPlatformName),
//         );
//       });
//     });
//   });
// }
