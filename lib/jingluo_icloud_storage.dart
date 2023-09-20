import 'jingluo_icloud_storage_platform_interface.dart';

class JingluoIcloudStorage {
  Future<Map?> isICloudEnabled() {
    return JingluoIcloudStoragePlatform.instance.isICloudEnabled();
  }

  Future<String?> getPlatformVersion() {
    return JingluoIcloudStoragePlatform.instance.getPlatformVersion();
  }

  Future<Map?> getValue(
      {required String key,
      JingluoIcloudStorageType type = JingluoIcloudStorageType.none}) {
    return JingluoIcloudStoragePlatform.instance.getValue(key, type.name);
  }

  Future<Map?> setValue(
      {required String key,
      required dynamic value}) {
    return JingluoIcloudStoragePlatform.instance
        .setValue({"key": key, "value": value});
  }

  Future<Map?> deleteValue(
      {required String key}) {
    return JingluoIcloudStoragePlatform.instance.deleteValue(key);
  }
}

enum JingluoIcloudStorageType {
  string,
  array,
  dictionary,
  data,
  long,
  double,
  bool,
  none,
}
