//
//  UserDefaultsApi.swift
//  jingluo_icloud_storage
//
//  Created by 郭士君 on 2023/9/19.
//

#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif
import Foundation

class UserDefaultsApi {
  
  static let shared = UserDefaultsApi()
  
  private init() {
    let keyValueStore = NSUbiquitousKeyValueStore.default
    // 监听数据变化
    NotificationCenter.default.addObserver(self, selector: #selector(keyValueStoreDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: keyValueStore)
    
    keyValueStore.synchronize()
  }
  
  public func isICloudEnabled(result: @escaping FlutterResult) {
    if let _ = FileManager.default.ubiquityIdentityToken {
      result(CommonUtil.wrapErrResult(code: 0, msg: "iCloud is on"))
    } else {
      result(CommonUtil.wrapErrResult(code: -2, msg: "iCloud is not turned on"))
    }
  }
  
  @objc func keyValueStoreDidChange(notification: Notification) {
    // 处理数据变化
    if let userInfo = notification.userInfo as? [String: Any],
       let reasonForChange = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? NSNumber {
      
      var reason = -1
      reason = reasonForChange.intValue
      
      if (reason == NSUbiquitousKeyValueStoreServerChange || reason == NSUbiquitousKeyValueStoreInitialSyncChange) {
        guard let changedKeys = userInfo[NSUbiquitousKeyValueStoreChangedKeysKey] as? [String] else {
          return
        }
        let store = NSUbiquitousKeyValueStore.default
        for key in changedKeys {
          let value = store.object(forKey: key)
          print("修改的值: \(value ?? -1)")
          let body = CommonUtil.eventWrapResult(key: EventKey.UpdateICloudStorage, payload: ["code": 0, "value": value])
          EventManager.shared.emitEvent(body)
        }
      }
    }
  }
  
  public func getValueByIcloudStorage(arguments: Any?, result: @escaping FlutterResult) {
    if let arg = arguments as? Dictionary<String, String>, let key = arg["key"] {
      var val:Any?
      let type = arg["type"]
      let store = NSUbiquitousKeyValueStore.default
      switch type {
        case "string":
          val = store.string(forKey: key)
        case "array":
          val = store.array(forKey: key)
        case "dictionary":
          val = store.dictionary(forKey: key)
        case "data":
          val = store.data(forKey: key)
        case "long":
          val = store.longLong(forKey: key)
        case "double":
          val = store.double(forKey: key)
        case "bool":
          val = store.bool(forKey: key)
        default:
          val = store.object(forKey: key)
      }
      result(["code": 0, "msg": val])
    }
    
    result(CommonUtil.wrapErrResult(code: -1, msg: "参数异常"))
  }
  
  public func setValueByIcloudStorage(arguments: Any?, result: @escaping FlutterResult) {
    if let arg = arguments as? Dictionary<String, Any>, let key = arg["key"] as? String, let value = arg["value"] {
      let store = NSUbiquitousKeyValueStore.default
      store.set(value, forKey: key)
      store.synchronize()
      result(CommonUtil.wrapErrResult(code: 0))
    }
    
    result(CommonUtil.wrapErrResult(code: -1, msg: "参数异常"))
  }
  
  public func deleteValueByIcloudStorage(arguments: Any?, result: @escaping FlutterResult) {
    if let arg = arguments as? Dictionary<String, String>, let key = arg["key"] {
      let store = NSUbiquitousKeyValueStore.default
      store.removeObject(forKey: key)
      result(CommonUtil.wrapErrResult(code: 0))
    }
    result(CommonUtil.wrapErrResult(code: -1, msg: "参数异常"))
  }
  
}
