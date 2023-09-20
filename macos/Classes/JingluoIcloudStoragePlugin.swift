import Cocoa
import FlutterMacOS

public class JingluoIcloudStoragePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
#if os(iOS)
    let messenger = registrar.messenger()
#else
    let messenger = registrar.messenger
#endif
    let channel = FlutterMethodChannel(name: "jingluo_icloud_storage_method", binaryMessenger: messenger)
    let instance = JingluoIcloudStoragePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    // 注册event channel
    EventManager.shared.initializeWithRegistrar(registrar)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "isICloudEnabled":
      UserDefaultsApi.shared.isICloudEnabled(result: result)
    case "getValue":
      UserDefaultsApi.shared.getValueByIcloudStorage(arguments: call.arguments, result: result)
    case "setValue":
      UserDefaultsApi.shared.setValueByIcloudStorage(arguments: call.arguments, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
