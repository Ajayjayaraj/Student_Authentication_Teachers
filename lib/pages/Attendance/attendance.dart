import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/utils/global.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    Widget abcd(String s1) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          s1,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            // fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: lst.length,
            itemBuilder: (BuildContext context, int index) {
              return abcd(lst[index]);
            }),
      ),
    );
  }
}
