//
//  Util.swift
//  jingluo_icloud_storage
//
//  Created by 郭士君 on 2023/9/19.
//

import Foundation

class CommonUtil {
  static public func wrapErrResult(code: ErrorCode, msg: Any? = nil) -> [String: Any] {
    var ret = [String: Any]()
    ret["code"] = code.rawValue
    ret["msg"] = msg ?? code.description
    return ret
  }
  
  static public func wrapResult(code: ErrorCode, payload: [String: Any?]) -> [String: Any] {
    var ret = [String: Any]()
    ret["code"] = code.rawValue
    ret["msg"] = code.description
    ret["payload"] = payload
    return ret
  }
  
  static public func eventWrapResult(key: String, payload: [String: Any?]) -> [String: Any] {
    var ret = [String: Any]()
    ret["key"] = key
    ret["payload"] = payload
    return ret
  }
}

enum ErrorCode: Int {
  case success = 0
  case invalidParameter = -1
  case unauthorized = -2 // iCloud未登录
  
  var description: String {
    switch self {
    case .success:
      return "Success"
    case .invalidParameter:
      return "Invalid parameter"
    case .unauthorized:
      return "Unauthorized access"
    }
  }
}
