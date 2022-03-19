import 'package:flutter/material.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_app/kal.dart' as kal;
import 'package:test_app/local_storage/SqfliteActivity.dart';
import 'package:test_app/search/main_2.dart';
import 'package:test_app/sites.dart' as sites;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  none() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Web',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: SqfliteActivity(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'images/logo.png',
                width: 100,
                height: 100,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'PT. Nippisun Indonesia',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Container(
            //   height: 50,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.grey,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.blue[300],
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 32,
            // ),
            TabBar(
              tabs: [
                Tab(text: 'Kalkulator'),
                Tab(text: 'NPI Sites'),
              ],
              controller: controller,
              indicatorColor: Colors.blue[900],
              unselectedLabelColor: Colors.black,
              labelColor: Colors.blue[900],
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  kal.Kal(),
                  sites.Sites(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
