import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NeumorphicApp(
      title: 'Flutter Demo',
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      home: MyHomePage(title: 'Nite Mode'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        backgroundColor: const Color.fromARGB(44, 48, 59, 255),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: GestureDetector(
                    onTap: () {
                      openLink("https://github.com/thechawla225/NiteModeFlask");
                    },
                    child: const Icon(MdiIcons.github, size: 40)),
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
            title: GestureDetector(
                onTap: () {
                  openLink("https://thechawla225.pythonanywhere.com");
                },
                child: const Text("Nite Mode"))),
        body: SafeArea(
          child: Column(
            children: [
              Container(height: size.height * 0.1),
              Image.asset('assets/images/astronaut.png',
                  color: Colors.white, scale: 2),
              Container(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphicButton(
                      margin: const EdgeInsets.only(top: 12),
                      onPressed: () {},
                      style: NeumorphicStyle(
                        lightSource: LightSource.topRight,
                        shape: NeumorphicShape.concave,
                        color: const Color.fromRGBO(43, 50, 59, 0),
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: const Text(
                        "Choose a File",
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    width: 30,
                  ),
                  NeumorphicButton(
                      margin: const EdgeInsets.only(top: 12),
                      onPressed: () {},
                      style: NeumorphicStyle(
                        lightSource: LightSource.topRight,
                        shape: NeumorphicShape.concave,
                        color: Colors.white,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: const Text(
                        "Make it dark",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
              Container(height: size.height * 0.15),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Thanks to Font Awesome', style: TextStyle()),
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
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
