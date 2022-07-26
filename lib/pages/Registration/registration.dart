import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project/utils/global.dart';
import 'package:project/utils/styles.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int _selectedIndex = 0;

  void showToast(String s, Color c) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: c,
        textColor: Colors.white);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _regbuttonStudent() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailControllerStudent.text, password: "123456");
      students
          .doc(_admissionControllerStudent.text)
          .set({
            'Name': _nameControllerStudent.text,
            'Email_Id': _emailControllerStudent.text,
            'DOB': _dobControllerStudent.text,
            'Phone': _phoneControllerStudent.text,
            'Aadhaar': _aadhaarControllerStudent.text,
            'Address': _addressControllerStudent.text,
            'Admission_No': _admissionControllerStudent.text,
            'Department': _deptControllerStudent.text,
            'Year': _yearControllerStudent.text,
            'Entrance_Rank': _rankControllerStudent.text,
            'Password': "123456"
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      showToast('Registration Successful', Colors.grey[500]!);
      _userreg(_nameControllerStudent.text, 0, _emailControllerStudent.text);
      CStudent.name = _nameControllerStudent.text;
      CStudent.email = _emailControllerStudent.text;
      CStudent.dob = _dobControllerStudent.text;
      CStudent.phone = _phoneControllerStudent.text;
      CStudent.aadhaar = _aadhaarControllerStudent.text;
      CStudent.address = _addressControllerStudent.text;
      CStudent.admission = _admissionControllerStudent.text;
      CStudent.dept = _deptControllerStudent.text;
      CStudent.year = _yearControllerStudent.text;
      CStudent.rank = _rankControllerStudent.text;
      Get.toNamed('/first');
    } catch (e) {
      String error;
      error = e.toString();
      int kpp = error.lastIndexOf(']') + 1;
      showToast('${error.substring(kpp)}', Colors.red[300]!);
    }
    ;
  }

  void _userreg(String name, int level, String email) async {
    users.doc(email).set(({"Name": name, "Level": level, "Email": email}));
  }

  void _regbuttonTeacher() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailControllerTeacher.text, password: "123456");
      teachers
          .add({
            'Name': _nameControllerTeacher.text,
            'Email_Id': _emailControllerTeacher.text,
            'Employee_Id': _employeeIdControllerTeacher.text,
            'Department': _deptControllerTeacher.text,
            'Password': "123456"
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      showToast('Registration Successful', Colors.grey[500]!);
      _userreg(_nameControllerTeacher.text, 1, _emailControllerTeacher.text);
      CTeacher.name = _nameControllerTeacher.text;
      CTeacher.email = _emailControllerTeacher.text;
      CTeacher.employeeId = _employeeIdControllerTeacher.text;
      CTeacher.dept = _deptControllerTeacher.text;
      Get.toNamed('/first');
    } catch (e) {
      String error;
      error = e.toString();
      int kpp = error.lastIndexOf(']') + 1;
      showToast('${error.substring(kpp)}', Colors.red[300]!);
    }
    ;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _nameControllerStudent = TextEditingController();
  final TextEditingController _emailControllerStudent = TextEditingController();
  final TextEditingController _dobControllerStudent = TextEditingController();
  final TextEditingController _phoneControllerStudent = TextEditingController();
  final TextEditingController _aadhaarControllerStudent =
      TextEditingController();
  final TextEditingController _addressControllerStudent =
      TextEditingController();
  final TextEditingController _admissionControllerStudent =
      TextEditingController();
  final TextEditingController _deptControllerStudent = TextEditingController();
  final TextEditingController _yearControllerStudent = TextEditingController();
  final TextEditingController _rankControllerStudent = TextEditingController();

  final TextEditingController _nameControllerTeacher = TextEditingController();
  final TextEditingController _emailControllerTeacher = TextEditingController();
  final TextEditingController _employeeIdControllerTeacher =
      TextEditingController();
  final TextEditingController _deptControllerTeacher = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference teachers =
      FirebaseFirestore.instance.collection('teachers');
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.29),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(23),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'All Fields marked aestriks(*) are mandatory.',
                  style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width * 0.04, // or whatever
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Personal Details',
                  style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width * 0.05, // or whatever
                    color: Colors.black,
                  ),
                ),
              ),
              TextField(
                  controller: _nameControllerStudent,
                  style: inputstyle(),
                  decoration: inputdec("Name*", Icons.person_outline)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _emailControllerStudent,
                  style: inputstyle(),
                  decoration: inputdec("Email*", Icons.email_outlined)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _dobControllerStudent,
                  style: inputstyle(),
                  decoration: inputdec("Dob*", Icons.date_range_outlined)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _phoneControllerStudent,
                  style: inputstyle(),
                  decoration: inputdec("Phone No*", Icons.phone_outlined)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _aadhaarControllerStudent,
                  style: inputstyle(),
                  decoration: inputdec("Aadhar No*", Icons.person_outlined)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _addressControllerStudent,
                  style: inputstyle(),
                  maxLines: 4,
                  decoration: inputdec("Address*", Icons.home_outlined)),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Academic Details',
                  style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width * 0.05, // or whatever
                    color: Colors.black,
                  ),
                ),
              ),
              TextField(
                  controller: _admissionControllerStudent,
                  style: inputstyle(),
                  decoration: inputdec("Admission No*", Icons.person_outline)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _deptControllerStudent,
                  style: inputstyle(),
                  decoration: inputdec("Department*", Icons.school_outlined)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _yearControllerStudent,
                  style: inputstyle(),
                  decoration: inputdec("Year*", Icons.date_range_outlined)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _rankControllerStudent,
                  style: inputstyle(),
                  decoration:
                      inputdec("Entrance Rank*", Icons.school_outlined)),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () => _regbuttonStudent(),
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFUIDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                disabledColor: Colors.grey[300],
                color: Colors.cyan, //Color(0xffff2d55),
                elevation: 0,
                minWidth: 400,
                height: 50,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(23),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'All Fields marked aestriks(*) are mandatory.',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _nameControllerTeacher,
                  style: inputstyle(),
                  decoration: inputdec("Name*", Icons.person_outline)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _emailControllerTeacher,
                  style: inputstyle(),
                  decoration: inputdec("Email*", Icons.email_outlined)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _employeeIdControllerTeacher,
                  style: inputstyle(),
                  decoration: inputdec("Employee Id*", Icons.person_outline)),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _deptControllerTeacher,
                  style: inputstyle(),
                  decoration: inputdec("Department*", Icons.home_outlined)),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () => _regbuttonTeacher(),
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFUIDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                disabledColor: Colors.grey[300],
                color: Colors.cyan, //Color(0xffff2d55),
                elevation: 0,
                minWidth: 400,
                height: 50,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Stack(children: <Widget>[
        CachedNetworkImage(
          imageUrl:
              "https://cdn.pixabay.com/photo/2019/03/21/15/51/chatbot-4071274_960_720.jpg",
        ),
        _widgetOptions.elementAt(_selectedIndex),
      ])),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Student',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Teacher',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}
