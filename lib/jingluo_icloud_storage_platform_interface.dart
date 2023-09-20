import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'jingluo_icloud_storage_method_channel.dart';

abstract class JingluoIcloudStoragePlatform extends PlatformInterface {
  /// Constructs a JingluoIcloudStoragePlatform.
  JingluoIcloudStoragePlatform() : super(token: _token);

  static final Object _token = Object();

  static JingluoIcloudStoragePlatform _instance = MethodChannelJingluoIcloudStorage();

  /// The default instance of [JingluoIcloudStoragePlatform] to use.
  ///
  /// Defaults to [MethodChannelJingluoIcloudStorage].
  static JingluoIcloudStoragePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [JingluoIcloudStoragePlatform] when
  /// they register themselves.
  static set instance(JingluoIcloudStoragePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Map?> getValue(String key, String type) {
    throw UnimplementedError('getValue() has not been implemented.');
  }

  Future<Map?> setValue(Map arguments) {
    throw UnimplementedError('setValue() has not been implemented.');
  }
}
