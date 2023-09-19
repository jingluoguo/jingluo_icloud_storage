//
//  EventManager.swift
//  Pods
//
//  Created by 郭士君 on 2023/9/18.
//

import Flutter
import Foundation

class EventManager: NSObject, FlutterStreamHandler {
    
    static let shared = EventManager()
    
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink?
    
    func initializeWithRegistrar(_ registrar: FlutterPluginRegistrar) {
        eventChannel = FlutterEventChannel(name: "jingluo_icloud_storage_event", binaryMessenger: registrar.messenger())
        eventChannel?.setStreamHandler(self)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
    
    func emitEvent(_ event: [String: Any]) {
        if let eventSink = eventSink {
            eventSink(event)
        }
    }
}
