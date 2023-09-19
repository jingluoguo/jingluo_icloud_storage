//
//  Util.swift
//  jingluo_icloud_storage
//
//  Created by 郭士君 on 2023/9/19.
//

import Foundation

class CommonUtil {
    static public func wrapErrResult(code: Int32, msg: String = "") -> [String: Any] {
        var ret = [String: Any]()
        ret["code"] = code
        ret["msg"] = msg
        return ret
    }
    
    static public func wrapResult(code: Int32, msg: String, payload: [String: Any?]) -> [String: Any] {
        var ret = [String: Any]()
        ret["code"] = code
        ret["msg"] = msg
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
