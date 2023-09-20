#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif
import UIKit

public class JingluoIcloudStoragePlugin: NSObject, FlutterPlugin {
  
  var channel: FlutterMethodChannel?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    // 注册method channel
#if os(iOS)
    let messenger = registrar.messenger()
#else
    let messenger = registrar.messenger
#endif
    let channel = FlutterMethodChannel(name: "jingluo_icloud_storage_method", binaryMessenger: messenger)
    let instance = JingluoIcloudStoragePlugin()
    instance.channel = channel
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    // 注册event channel
    EventManager.shared.initializeWithRegistrar(registrar)
  }
  
  public override init() {
    super.init()
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getValue":
      UserDefaultsApi.shared.getValueByIcloudStorage(arguments: call.arguments, result: result)
    case "setValue":
      UserDefaultsApi.shared.setValueByIcloudStorage(arguments: call.arguments, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
