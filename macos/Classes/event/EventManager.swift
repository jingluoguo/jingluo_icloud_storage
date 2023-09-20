//
//  EventManager.swift
//  Pods
//
//  Created by 郭士君 on 2023/9/18.
//

#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif
import Foundation

class EventManager: NSObject, FlutterStreamHandler {
  
  static let shared = EventManager()
  
  private var eventChannel: FlutterEventChannel?
  private var eventSink: FlutterEventSink?
  
  func initializeWithRegistrar(_ registrar: FlutterPluginRegistrar) {
#if os(iOS)
    let messenger = registrar.messenger()
#else
    let messenger = registrar.messenger
#endif
    eventChannel = FlutterEventChannel(name: "jingluo_icloud_storage_event", binaryMessenger: messenger)
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
