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
      let store = NSUbiquitousKeyValueStore.default
      result(["code": true, "msg": store.object(forKey: key)])
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
