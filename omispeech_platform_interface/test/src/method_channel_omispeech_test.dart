// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:omispeech_platform_interface/src/method_channel_omispeech.dart';
//
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   const kPlatformName = 'platformName';
//
//   group('$MethodChannelOmispeech', () {
//     late MethodChannelOmispeech methodChannelOmispeech;
//     final log = <MethodCall>[];
//
//     setUp(() async {
//       methodChannelOmispeech = MethodChannelOmispeech();
//       TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
//           .setMockMethodCallHandler(
//         methodChannelOmispeech.methodChannel,
//         (methodCall) async {
//           log.add(methodCall);
//           switch (methodCall.method) {
//             case 'startListening':
//               return kPlatformName;
//             default:
//               return null;
//           }
//         },
//       );
//     });
//
//     tearDown(log.clear);
//
//     test('getPlatformName', () async {
//       final platformName = await methodChannelOmispeech.getPlatformName();
//       expect(
//         log,
//         <Matcher>[isMethodCall('getPlatformName', arguments: null)],
//       );
//       expect(platformName, equals(kPlatformName));
//     });
//   });
// }
