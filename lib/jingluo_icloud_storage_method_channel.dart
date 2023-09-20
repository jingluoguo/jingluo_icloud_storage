import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'jingluo_icloud_storage_platform_interface.dart';

/// An implementation of [JingluoIcloudStoragePlatform] that uses method channels.
class MethodChannelJingluoIcloudStorage extends JingluoIcloudStoragePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('jingluo_icloud_storage_method');

  @override
  Future<Map?> isICloudEnabled() async {
    return await methodChannel.invokeMethod('isICloudEnabled');
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Map?> getValue(String key, String type) async {
    final res = await methodChannel.invokeMethod('getValue', {"key": key, "type": type});
    return res;
  }

  @override
  Future<Map?> setValue(Map arguments) async {
    final res = await methodChannel.invokeMethod('setValue', arguments);
    return res;
  }

  @override
  Future<Map?> deleteValue(String key) async {
    final res = await methodChannel.invokeMethod('deleteValue', {"key": key});
    return res;
  }
}
