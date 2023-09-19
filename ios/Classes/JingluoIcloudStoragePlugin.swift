import Flutter
import UIKit

public class JingluoIcloudStoragePlugin: NSObject, FlutterPlugin {
  
  var channel: FlutterMethodChannel?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    // 注册method channel
    let channel = FlutterMethodChannel(name: "jingluo_icloud_storage_method", binaryMessenger: registrar.messenger())
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
