import 'package:flutter/material.dart'; //导入相关控件
import 'package:lighting_hold/pages/pages_home.dart'; //导入相关控件

void main() {
  runApp(const MyApp()); // 入口
}

// StatelessWidget 无状态控件  StatefulWidget 有状态控件
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 每个项目最外层必须套 MaterialApp
    return MaterialApp(
      title: 'lighting hold', // App标题
      debugShowCheckedModeBanner: false, // 关闭debug标志
      //主题
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 65, 133, 210)),
        useMaterial3: true,
      ),
      // 通过 home 指定首页
      home: const MyHomePage(),
    );
  }
}
