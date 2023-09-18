import 'package:flutter_test/flutter_test.dart';
import 'package:jingluo_icloud_storage/jingluo_icloud_storage.dart';
import 'package:jingluo_icloud_storage/jingluo_icloud_storage_platform_interface.dart';
import 'package:jingluo_icloud_storage/jingluo_icloud_storage_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockJingluoIcloudStoragePlatform
    with MockPlatformInterfaceMixin
    implements JingluoIcloudStoragePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final JingluoIcloudStoragePlatform initialPlatform = JingluoIcloudStoragePlatform.instance;

  test('$MethodChannelJingluoIcloudStorage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelJingluoIcloudStorage>());
  });

  test('getPlatformVersion', () async {
    JingluoIcloudStorage jingluoIcloudStoragePlugin = JingluoIcloudStorage();
    MockJingluoIcloudStoragePlatform fakePlatform = MockJingluoIcloudStoragePlatform();
    JingluoIcloudStoragePlatform.instance = fakePlatform;

    expect(await jingluoIcloudStoragePlugin.getPlatformVersion(), '42');
  });
}
