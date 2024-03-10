// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:lighting_hold/pages/pages_add_device.dart'; //导入相关控件

enum HomePageList {
  // ignore: constant_identifier_names
  add_devices,
  // ignore: constant_identifier_names
  QR_phont
}

//有状态控件
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("设备列表"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(180, 30, 120, 190),
        foregroundColor: Colors.white,
        actions: [_ppmenubutton(context)],
        iconTheme: const IconThemeData(
          size: 30,
          color: Colors.white,
        ),
      ),
      body: const Center(
        child: Text("这里是body22"),
      ),
    );
  }
}

//下拉菜单
PopupMenuButton _ppmenubutton(BuildContext context) {
  return PopupMenuButton(
    onSelected: (value) {
      if (value == HomePageList.add_devices) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return const AddDevicePage();
        }));
        debugPrint("按下 ‘添加设备'\n");
      }
      debugPrint('$value');
    },
    //icon 设置图标
    icon: const Icon(Icons.add_circle),
    //shape 设置边框样式
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      // side: const BorderSide(
      //   width: 2,
      //   color: Color.fromARGB(255, 0, 0, 0),
      //   style: BorderStyle.solid,
      // ),
    ),
    //itemBuilder 设置子选项
    itemBuilder: (BuildContext context) {
      return [
        const PopupMenuItem(
          value: HomePageList.add_devices,
          child: Row(
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0), // 图标间距
                child: Icon(Icons.electrical_services,
                    color: Colors.black, size: 20),
              ),
              Text("添加设备"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: HomePageList.QR_phont,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0), // 图标间距
                child: Icon(Icons.center_focus_weak,
                    color: Colors.black, size: 20),
              ),
              Text("扫码"),
            ],
          ),
        ),
      ];
    },
  );
}
