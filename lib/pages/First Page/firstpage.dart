import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/global.dart';
import '../QR/qrscan.dart';

List<int> arr = [0, 0, 0, 0];

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String cameraScanResult = "k";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  int randInt() {
    var random = Random();
    int k = random.nextInt(4);
    return k;
  }

  Color pickColor() {
    int count = 0;
    final colorList = [
      Colors.grey,
      Color(0xfffa9881),
      Color(0xffb1a5f6),
      Color(0xff71b4fb),
    ];
    for (int i = 0; i < 4; i++) {
      if (arr[i] == 1) {
        count++;
      }
    }
    if (count == 4) {
      for (int i = 0; i < 4; i++) {
        arr[i] = 0;
      }
      count = 0;
    }
    int k = randInt();
    while (arr[k] != 0) {
      k = randInt();
    }
    print("K : " + k.toString());
    arr[k] = 1;
    return colorList[k];
  }

  @override
  Widget build(BuildContext context) {
    double padding_length = MediaQuery.of(context).size.width * 0.05;
    Widget buttonTile(String text, String route) {
      return Padding(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.06),
        child: MaterialButton(
          color: pickColor(), //Color(0xffff2d55),
          elevation: 0,
          minWidth: 150,
          height: 50,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(padding_length)),
          child: Text(
            "$text",
            style: TextStyle(fontSize: padding_length),
          ),
          onPressed: () {
            Get.toNamed('$route');
          },
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[100],
            leading: const Icon(
              Icons.short_text,
              size: 30,
              color: Colors.black,
            ),
            actions: [
              IconButton(
                  color: Colors.black,
                  onPressed: (() {
                    setState(() {
                      Get.toNamed('/login');
                      FirebaseAuth.instance.signOut();
                    });
                  }),
                  icon: Icon(Icons.logout_outlined))
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(padding_length),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello,",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.06,
                                color: Colors.grey)),
                        Text("${Cuser.name}",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.1,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, padding_length, 0, padding_length),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Category",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.055,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        // MaterialButton(
                        //   onPressed: () {
                        //     seeAll(context);
                        //   },
                        //   child: Text("See All",
                        //       style: TextStyle(
                        //           fontSize:
                        //               MediaQuery.of(context).size.width * 0.055,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black)),
                        // )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      // buttonTile("Registration", '/register'),
                      // buttonTile("QR Generator", '/qrgenerator'),
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.06),
                        child: MaterialButton(
                          color: pickColor(), //Color(0xffff2d55),
                          elevation: 0,
                          minWidth: MediaQuery.of(context).size.width * 0.38,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(padding_length)),
                          child: Text(
                            "QR Scanner",
                            style: TextStyle(fontSize: padding_length),
                          ),
                          onPressed: () async {
                            // Get.toNamed('/qrscan');
                            qrfn();
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       right: MediaQuery.of(context).size.width * 0.06),
                      //   child: MaterialButton(
                      //     color: pickColor(), //Color(0xffff2d55),
                      //     elevation: 0,
                      //     minWidth: MediaQuery.of(context).size.width * 0.38,
                      //     textColor: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.circular(padding_length)),
                      //     child: Text(
                      //       "QR Biometry",
                      //       style: TextStyle(fontSize: padding_length),
                      //     ),
                      //     onPressed: () async {
                      //       // Get.toNamed('/qrscan');
                      //       biofn();
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
