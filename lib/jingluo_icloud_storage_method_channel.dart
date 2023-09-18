import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'jingluo_icloud_storage_platform_interface.dart';

/// An implementation of [JingluoIcloudStoragePlatform] that uses method channels.
class MethodChannelJingluoIcloudStorage extends JingluoIcloudStoragePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('jingluo_icloud_storage');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
