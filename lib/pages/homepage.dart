import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
  I changed UI to look like more attractive
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined,
                size: MediaQuery.of(context).size.height * 0.15),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "Authentication",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.08),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.13,
                  vertical: 0),
              child: MaterialButton(
                onPressed: () {
                  Get.toNamed("/login");
                }, //since this is only a UI app
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFUIDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.cyan, //Color(0xffff2d55),
                elevation: 0,
                minWidth: 400,
                height: 50,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.025),
            //   margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.13,vertical: 0),
            //   child: MaterialButton(
            //     onPressed: (){
            //       // Navigator.push(context, MaterialPageRoute(builder: (context) => RegPage()));
            //       Get.toNamed("/register");
            //     },//since this is only a UI app
            //     child: Text('REGISTER',
            //       style: TextStyle(
            //         fontSize: 15,
            //         fontFamily: 'SFUIDisplay',
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     color: Colors.amber,//Color(0xffff2d55),
            //     elevation: 0,
            //     minWidth: 400,
            //     height: 50,
            //     textColor: Colors.white,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10)
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
