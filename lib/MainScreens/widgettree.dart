import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/pages/Attendance/attendance.dart';
import 'package:project/pages/newpage.dart';
import '../pages/First Page/firstpage.dart';
import '../pages/QR/Result.dart';
import '../pages/Registration/Login.dart';
import '../pages/homepage.dart';
import '../pages/Registration/registration.dart';

Widget Decider(String page) {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: page,
    getPages: [
      GetPage(name: '/', page: () => HomePage()),
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/register', page: () => RegistrationPage()),
      GetPage(name: '/first', page: () => FirstPage()),
      GetPage(name: '/qrres', page: () => QrResult()),
      GetPage(name: '/newPage', page: (() => NewPage())),
      GetPage(name: '/attendance', page: (() => Attendance())),
    ],
  );
}
