import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jingluo_icloud_storage/jingluo_icloud_storage_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelJingluoIcloudStorage platform = MethodChannelJingluoIcloudStorage();
  const MethodChannel channel = MethodChannel('jingluo_icloud_storage');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
