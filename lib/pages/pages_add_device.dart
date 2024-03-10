// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
import 'dart:async'; // 异步库

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
final flutterReactiveBle = FlutterReactiveBle(); //导入蓝牙包

List<DiscoveredDevice> deviceList = [];

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  /// 检查权限获取情况
  Future<void> requestPermPD() async {
    bool gpsflag = await requestPermission();
    if (gpsflag) {
      debugPrint("成功获取权限");
    } else {
      debugPrint("获取权限失败");
    }
  }

  /// 动态申请定位权限
  Future<bool> requestPermission() async {
    var status = await Permission.location.status;
    var isBleScanGranted = await Permission.bluetoothScan.request();
    //
    var isBleConnectGranted = await Permission.bluetoothConnect.request();
    //
    var isBleAdvertiseGranted = await Permission.bluetoothAdvertise.request();

    if (status == PermissionStatus.granted) {
      /// 已经授权
      return true;
    } else {
      /// 未授权重新发起定位授权
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    debugPrint("切换页面");

    /// 页面启动时调用权限
    requestPermPD();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加设备"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(180, 30, 120, 190),
        foregroundColor: Colors.white,
      ),
      body: const Text("没有设备"),
      floatingActionButton: Container(
        width: 100,
        height: 40,
        // padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(180, 30, 120, 190),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {
            flutterReactiveBle.scanForDevices(
                withServices: [], scanMode: ScanMode.lowLatency).listen(
              (device) {
                //code for handling results
                deviceList.add(device);
              },
              onError: (e) {
                //code for handling error
                debugPrint("onError = $e");
              },
            );
          },
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textBaseline: TextBaseline.ideographic,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 20,
                ),
                Text("扫描设备")
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
