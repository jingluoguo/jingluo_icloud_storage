import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:jingluo_icloud_storage/jingluo_icloud_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _jingluoIcloudStoragePlugin = JingluoIcloudStorage();

  final _key = "count";

  var idx = 0;

  @override
  void initState() {
    super.initState();
    startNotification();
    initPlatformState();
  }

  void startNotification() {
    _jingluoIcloudStoragePlugin.registerEventListener(onEvent: (event) {
      if (event["key"] == JingluoIcloudStorageEventType.updateICloudStorage) {
        Map? map = event["payload"]["value"];
        if (map != null && map[_key] != null) {
          idx = map[_key];
        }
        setState(() {});
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    var res = await _jingluoIcloudStoragePlugin.isICloudEnabled();
    if (res?['code'] != 0) {
      return;
    }
    try {
      platformVersion =
          await _jingluoIcloudStoragePlugin.getPlatformVersion() ??
              'Unknown platform version';

      var res = await _jingluoIcloudStoragePlugin.getValue(key: _key);
      setState(() {
        if (res != null && res['code'] == 0) {
          idx = int.parse((res["msg"] ?? 0).toString());
        }
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              GestureDetector(
                onTap: () async {
                  var res = await _jingluoIcloudStoragePlugin.setValue(
                      key: "count", value: idx + 1);
                  if (res?['code'] == 0) {
                    setState(() {
                      idx++;
                    });
                  }
                },
                child: const Text("累加"),
              ),
              Text("当前的值：$idx")
            ],
          ),
        ),
      ),
    );
  }
}
