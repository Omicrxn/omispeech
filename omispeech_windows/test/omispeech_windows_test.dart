// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:omispeech_platform_interface/omispeech_platform_interface.dart';
// import 'package:omispeech_windows/omispeech_windows.dart';
//
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   group('OmispeechWindows', () {
//     const kPlatformName = 'Windows';
//     late OmispeechWindows omispeech;
//     late List<MethodCall> log;
//
//     setUp(() async {
//       omispeech = OmispeechWindows();
//
//       log = <MethodCall>[];
//       TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
//           .setMockMethodCallHandler(omispeech.methodChannel, (methodCall) async {
//         log.add(methodCall);
//         switch (methodCall.method) {
//           case 'getPlatformName':
//             return kPlatformName;
//           default:
//             return null;
//         }
//       });
//     });
//
//     test('can be registered', () {
//       OmispeechWindows.registerWith();
//       expect(OmispeechPlatform.instance, isA<OmispeechWindows>());
//     });
//
//     test('getPlatformName returns correct name', () async {
//       final name = await omispeech.getPlatformName();
//       expect(
//         log,
//         <Matcher>[isMethodCall('getPlatformName', arguments: null)],
//       );
//       expect(name, equals(kPlatformName));
//     });
//   });
// }
