import 'package:check_lottery/screen/screen_showlottery.dart';
import 'package:check_lottery/screen/truatHuai.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.grey[300], // กำหนดสีพื้นหลังของแอพเป็นสีเทาอ่อน
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "คุณถูกรางวัลหรือเปล่าน้าา",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: const TabBarView(children: [HuaiExit(), TruatHuai()]),
        bottomNavigationBar: const SizedBox(
          height: 70,
          child: ColoredBox(
            color: Colors.black87,
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 30), // กำหนดขนาดตัวหนังสือใน TabBar
              child: TabBar(tabs: [
                Tab(
                  child: Text(
                    'ผลรางวัล',
                    style: TextStyle(fontSize: 22, color: Colors.white70),
                  ),
                ),
                Tab(
                  child: Text(
                    'ตรวจรางวัล',
                    style: TextStyle(fontSize: 22, color: Colors.white70),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
