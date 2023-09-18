
import 'jingluo_icloud_storage_platform_interface.dart';

class JingluoIcloudStorage {
  Future<String?> getPlatformVersion() {
    return JingluoIcloudStoragePlatform.instance.getPlatformVersion();
  }
}
