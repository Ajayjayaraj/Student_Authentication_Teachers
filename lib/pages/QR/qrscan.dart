import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/pages/addon.dart';
import 'package:project/utils/global.dart';
import 'package:qrscan/qrscan.dart' as scanner;

Future<int> getData1() async {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('students');
  late var allData;
  // idtosearch = "B19CS054";
  QuerySnapshot querySnapshot = await _collectionRef.get();
  allData = await querySnapshot.docs.map((doc) => doc.data()).toList();
  for (var i in allData) {
    if (i["Admission_No"] == idtosearch) {
      CStudent.name = i['Name'];
      CStudent.email = i['Email_Id'];
      CStudent.dob = i['DOB'];
      CStudent.phone = i['Phone'];
      CStudent.aadhaar = i['Aadhaar'];
      CStudent.address = i['Address'];
      CStudent.admission = i['Admission_No'];
      CStudent.dept = i['Department'];
      CStudent.year = i['Year'];
      CStudent.rank = i['Entrance_Rank'];
      return 1;
    }
  }
  return 0;
}

Future<void> qrfn() async {
  int k = await getData1();
  String cameraScanResult = "k";
  print("hello");
  var camerastatus = await Permission.camera.status;
  if (camerastatus.isGranted) {
    print("object");
    var cameraScanResult1 = await scanner.scan();
    cameraScanResult = cameraScanResult1.toString();
    Cuser.emailid = cameraScanResult;
    idtosearch = cameraScanResult;
  } else {
    var isGranted = await Permission.camera.request();
    if (isGranted.isGranted) {
      var cameraScanResult1 = await scanner.scan();
      cameraScanResult = cameraScanResult1.toString();
      Cuser.emailid = cameraScanResult;
      idtosearch = cameraScanResult;
    }
  }
  if (k == 1) {
    Get.toNamed('/qrres');
  } else {
    showToast("No such user", Colors.red);
    Get.toNamed('/first');
  }
}

Future<void> qrfn1() async {
  for (int i = 0; i < 3;) {
    int k = await getData1();
    String cameraScanResult = "k";
    print("hello");
    var camerastatus = await Permission.camera.status;
    if (camerastatus.isGranted) {
      print("object");
      var cameraScanResult1 = await scanner.scan();
      cameraScanResult = cameraScanResult1.toString();
      Cuser.emailid = cameraScanResult;
      idtosearch = cameraScanResult;
    } else {
      var isGranted = await Permission.camera.request();
      if (isGranted.isGranted) {
        var cameraScanResult1 = await scanner.scan();
        cameraScanResult = cameraScanResult1.toString();
        Cuser.emailid = cameraScanResult;
        idtosearch = cameraScanResult;
      }
    }
    if (k == 1) {
      int flag = 0;
      for(int p = 0;p<lst.length;p++) {
        if(lst[p] == CStudent.name) {
          flag = 1;
        }
      }
      if(flag == 0) {
        lst.add(CStudent.name);
        i++;
      }
    } 
    else {
      showToast("No such user", Colors.red);
      Get.toNamed('/first');
    }
  }
  Get.toNamed('/attendance');
}

Future<void> biofn() async {
  // int k = await getData1();
  String cameraScanResult = "k";
  print("hello");
  var camerastatus = await Permission.camera.status;
  if (camerastatus.isGranted) {
    print("object");
    var cameraScanResult1 = await scanner.scan();
    cameraScanResult = cameraScanResult1.toString();
    Cuser.emailid = cameraScanResult;
    idtosearch = cameraScanResult;
  } else {
    var isGranted = await Permission.camera.request();
    if (isGranted.isGranted) {
      var cameraScanResult1 = await scanner.scan();
      cameraScanResult = cameraScanResult1.toString();
      Cuser.emailid = cameraScanResult;
      idtosearch = cameraScanResult;
    }
  }
  // if (k == 1) {
  Get.toNamed('/qrbio');
  // } else {
  // showToast("No such user", Colors.red);
  // Get.toNamed('/first');
  // }
}
