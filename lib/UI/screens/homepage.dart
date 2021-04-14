import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:note_it/UI/offline.dart';
import 'package:note_it/UI/sidemenu.dart';
import 'package:note_it/category/algoScreen.dart';
import 'package:note_it/category/appdevScreen.dart';
import 'package:note_it/category/cppScreen.dart';
import 'package:note_it/category/cprogScreen.dart';
import 'package:note_it/category/dsaiScreen.dart';
import 'package:note_it/category/hacking.dart';
import 'package:note_it/category/javaScreen.dart';
import 'package:note_it/category/jsScript.dart';
import 'package:note_it/category/linuxScreen.dart';
import 'package:note_it/category/machineScreen.dart';
import 'package:note_it/category/networking.dart';
import 'package:note_it/category/otherScreen.dart';
import 'package:note_it/category/pythonScreen.dart';
import 'package:note_it/category/react.dart';
import 'package:note_it/category/unixScreen.dart';
import 'package:note_it/category/webdevScreen.dart';
import 'package:note_it/config/palette.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool connection = true;
  Connectivity connectivity;

  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          connection = false;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  final _kTabs = <Tab>[
    Tab(
      text: 'Algorithms',
    ),
    Tab(
      text: 'Python',
    ),
    Tab(
      text: 'C++',
    ),
    Tab(
      text: 'C',
    ),
    Tab(
      text: 'Web Development',
    ),
    Tab(
      text: 'Data Science & AI',
    ),
    Tab(
      text: 'Linux',
    ),
    Tab(
      text: 'App Development',
    ),
    Tab(
      text: 'Java',
    ),
    Tab(
      text: 'JavaScript',
    ),
    Tab(
      text: 'Machine Learning',
    ),
    Tab(
      text: 'Unix',
    ),
    Tab(
      text: 'Networking',
    ),
    Tab(
      text: 'React',
    ),
    Tab(
      text: 'Hacking',
    ),
    Tab(
      text: 'Others',
    ),
  ];

  final _kTabPages = <Widget>[
    AlgoScreen(),
    PythonScreen(),
    CppScreen(),
    CProgScreen(),
    WebScreen(),
    DsaiScreen(),
    LinuxScreen(),
    AppDevScreen(),
    JavaScreen(),
    JavaScriptScreen(),
    MachineLearningScreen(),
    UnixScreen(),
    NetworkingScreen(),
    ReactScreen(),
    HackingScreen(),
    OtherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: _kTabs.length,
        child: Scaffold(
          drawer: Drawer(
            child: SideMenu(),
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Palette.scaffold,
            title: Text(
              'Note It',
              style: TextStyle(
                  color: Palette.darkblue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.6),
            ),
            iconTheme: IconThemeData(color: Palette.darkblue),
            bottom: TabBar(
              indicatorColor: Palette.darkblue,
              indicatorWeight: 2.5,
              isScrollable: true,
              physics: BouncingScrollPhysics(),
              labelColor: Palette.darkblue,
              labelStyle: TextStyle(fontSize: 18),
              tabs: _kTabs,
            ),
          ),
          body: connection
              ? Center(
                  child: Offline(),
                )
              : TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: _kTabPages,
                ),
        ),
      ),
    );
  }
}
