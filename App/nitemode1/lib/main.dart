import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'Nite Mode',
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.top,
        depth: 10,
      ),
      home: ShowCaseWidget(
        builder: Builder(
          builder: (_) => MyHomePage(title: "Nite Mode"),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final key4 = GlobalKey();
  final key5 = GlobalKey();

  callShowCase() async {
    final SharedPreferences prefs = await _prefs;
    bool? isFirstRun;
    isFirstRun = prefs.getBool('isFirstRun');
    if (isFirstRun == null) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context)!
            .startShowCase([keyThree, keyOne, keyTwo, key4, key5]),
      );
      prefs.setBool('isFirstRun', false);
    }
  }

  @override
  void initState() {
    super.initState();
    callShowCase();
  }

  openLink(url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 44, 48, 59),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              CustomShowCase(
                mykey: keyOne,
                desc: "Visit our Github",
                child: IconButton(
                  onPressed: () {},
                  icon: GestureDetector(
                      onTap: () {
                        openLink(
                            "https://github.com/thechawla225/NiteModeFlask");
                      },
                      child: const Icon(MdiIcons.github, size: 40)),
                ),
              ),
            ],
            leading: GestureDetector(
              onTap: () async {
                openLink("https://thechawla225.pythonanywhere.com");
              },
              child: Image.asset("assets/images/moon-solid.png",
                  color: Colors.white, scale: 20),
            ),
            titleSpacing: 0.0,
            title: CustomShowCase(
              mykey: keyTwo,
              desc: "Visit our Website",
              child: GestureDetector(
                  onTap: () {
                    openLink("https://thechawla225.pythonanywhere.com");
                  },
                  child: const Text("Nite Mode",
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'ProximaNova'))),
            )),
        body: SafeArea(
          child: Column(
            children: [
              Container(height: size.height * 0.1),
              CustomShowCase(
                mykey: keyThree,
                desc: "Welcome to Nite Mode! Touch anywhere for the next step",
                child: Image.asset('assets/images/astronaut.png',
                    color: Colors.white, scale: 2),
              ),
              Container(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomShowCase(
                    mykey: key4,
                    desc: "You can pick a file here",
                    child: NeumorphicButton(
                        margin: const EdgeInsets.only(top: 12),
                        onPressed: () {},
                        style: NeumorphicStyle(
                          depth: 2,
                          lightSource: LightSource.top,
                          shape: NeumorphicShape.concave,
                          color: const Color.fromRGBO(43, 50, 59, 0),
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                          "Choose a File",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'ProximaNova',
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  CustomShowCase(
                    mykey: key5,
                    desc: "Turn file to dark mode here",
                    child: NeumorphicButton(
                        margin: const EdgeInsets.only(top: 12),
                        onPressed: () {},
                        style: NeumorphicStyle(
                          depth: 2,
                          lightSource: LightSource.top,
                          shape: NeumorphicShape.concave,
                          color: Colors.white,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                          "Make it dark",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'ProximaNova',
                          ),
                        )),
                  ),
                ],
              ),
              Container(height: size.height * 0.15),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Thanks to Font Awesome',
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  var url = "https://fontawesome.com/license";

                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      forceSafariVC: false,
                      forceWebView: false,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'View License',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ProximaNova',
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class CustomShowCase extends StatelessWidget {
  final Widget child;
  final String desc;
  final GlobalKey mykey;

  const CustomShowCase(
      {required this.child, required this.desc, required this.mykey});

  @override
  Widget build(BuildContext context) {
    return Showcase(
      child: child,
      key: mykey,
      description: desc,
      descTextStyle: const TextStyle(
          fontFamily: 'ProximaNova',
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Colors.black),
    );
  }
}
