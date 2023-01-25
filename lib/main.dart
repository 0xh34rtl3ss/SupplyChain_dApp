import 'package:flutter/material.dart';
import 'package:flutter_logistic_fatih/customer.dart';
import 'package:flutter_logistic_fatih/sender.dart';
import 'package:provider/provider.dart';
import 'hub.dart';
import 'package:metamask/metamask.dart';

import 'package:http/http.dart';
import 'package:webthree/webthree.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tracking Parcel',
      theme: ThemeData(
          primaryColor: Colors.red,
          primarySwatch: Colors.red,
          secondaryHeaderColor: Colors.amberAccent),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            //the appbar
            title: const Text('Parcel Track & Trace'),
            centerTitle: true, //make the title centre true
            elevation: 3, //state the elevation of the app bar
            bottom: const TabBar(tabs: [
              Tab(child: Text('Customer')), // caption of the tab
              Tab(child: Text('Sender')),
              Tab(child: Text('Hub')), // caption of the tab
            ]),
          ),
          body: TabBarView(children: [
            CustomerPage(), //item details custom widget
            SenderPage(),
            HubPage() // get checkpoint custom widget
          ])),
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ContractLinking(),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const MyHomePage(),
//       ),
//     );
//   }
// }
