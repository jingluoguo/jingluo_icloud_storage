
import 'jingluo_icloud_storage_platform_interface.dart';

class JingluoIcloudStorage {
  Future<String?> getPlatformVersion() {
    return JingluoIcloudStoragePlatform.instance.getPlatformVersion();
  }

  Future<Map?> getValue(String key) {
    return JingluoIcloudStoragePlatform.instance.getValue(key);
  }

  Future<Map?> setValue(Map arguments) {
    return JingluoIcloudStoragePlatform.instance.setValue(arguments);
  }
}
