import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project/utils/global.dart';
import 'package:project/utils/styles.dart';
import '../../utils/forgotpassword.dart';
import '../addon.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  var _passwordVisible = false;
  var successfulLogin = false;
  var isLoading = true;

  void initState() {
    _passwordVisible = false;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isloading = true;
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   // title: Text("Login"),
        //   backgroundColor: Colors.blueGrey,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Get.toNamed('/');
        //     },
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:
                    "https://i0.wp.com/www.artofvfx.com/IM2/IM2_PROLOGUE_VFX_15.jpg",
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                  child: ListView(
                    shrinkWrap:
                        true, //you must add this if you place listview inside scrollview
                    physics:
                        NeverScrollableScrollPhysics(), //to prevent default scrolling of listview
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          controller: _emailController,
                          style: inputstyle(),
                          decoration:
                              inputdec("Username", Icons.person_outline)),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: !_passwordVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _passwordController,
                        style: inputstyle(),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            border: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: new BorderSide(color: Colors.cyan)),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 16, // or whatever
                              color: Colors.grey,
                              height:
                                  2.2, //                                <----- this was the key
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 20,
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,
                            hintText: "Password"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MaterialButton(
                            onPressed: () async {
                              await ResetPassword(
                                  context, _emailController, _firebaseAuth);
                              if (restsender == 1)
                                showToast(
                                    "Reset Link has been Sent", Colors.grey);
                            },
                            child: Text("Forgot password ?",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 17,
                                ))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03),
                         child: isLoading ? MaterialButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = false;
                            });
                            // print(_emailController.toString() +
                            //     " " +
                            //     _passwordController.toString());
                            setState(() {
                              isloading = false;
                            });
                            try {
                              await _firebaseAuth
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then((value) => print('Login Successful'));
                              await getDetails();
                              Redirector(_emailController.text);
                              successfulLogin = true;
                              setState(() {
                                isloading = true;
                              });
                              showToast('Login Successful', Colors.grey[500]!);
                            } catch (e) {
                              setState(() {
                                isloading = true;
                              });
                              String error;
                              error = e.toString();
                              int kpp = error.lastIndexOf(']') + 1;
                              showToast(
                                  '${error.substring(kpp)}', Colors.red[300]!);
                            }
                            setState(() {
                              if(successfulLogin){
                                showToast(
                                  'Login Successful', Colors.grey[500]!);
                              }
                              isLoading = true;
                            });
                          },
                          child: isloading
                              ? Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'SFUIDisplay',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                          color: Colors.cyan, //Color(0xffff2d55),
                          elevation: 0,
                          minWidth: 200,
                          height: 50,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ): MaterialButton(
                          onPressed: () {},
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            // backgroundColor: Colors.cyan,
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
                      // SizedBox(
                      //   height: 40,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       "New user ?",
                      //     ),
                      //     MaterialButton(
                      //         onPressed: () {
                      //           // Get.toNamed("/register");
                      //         },
                      //         child: Text("Register now",
                      //             style: TextStyle(
                      //                 color: Colors.red[800],
                      //                 fontSize: 18,
                      //                 decoration: TextDecoration.underline)))
                      //   ],
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
