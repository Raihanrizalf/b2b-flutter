// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable, unrelated_type_equality_checks, empty_statements

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectb2b/login.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String regname = '';
  String regemail = '';
  String regpas = '';
  bool _regpass = true;
  bool _conpass = true;
  late bool isSuccess ;
  final formKey = GlobalKey<FormState>();
  final _pasreg = TextEditingController();
  final _pascon = TextEditingController();
  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();

  void signup(RoundedLoadingButtonController controller) async{
    if (formKey.currentState!.validate()) {
      var response = await http.post(
          Uri.parse(
              "http://192.168.102.195:3000/api/users/register"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: json.encode({
            "fullName": regname,
            "email": regemail,
            "password": regpas,
          }));
      print(response.body);
      isSuccess = json.decode(response.body)['isSuccess'];
      if(isSuccess){
        controller.success();
        Timer(Duration(seconds: 1), (){
        showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color.fromARGB(255, 23, 22, 29),
                    title: Text('Registration Success!'),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600),
                    content: Text(
                        'Check your email to verify your account'),
                    contentTextStyle: TextStyle(fontFamily: 'Inter',color: Colors.white),
                    actions: [
                      TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.transparent),
                              minimumSize: MaterialStateProperty.all(
                                  Size.zero),
                              tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(0, 0, 10, 10))),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: ((context) {
                              return Login();
                            })));
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  )));

        });
      } else {
        _buttonController.reset();
        var error = json.decode(response.body)['message'];
        showDialog(context: context, builder: ((context) => AlertDialog(
          shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color.fromARGB(255, 23, 22, 29),
          title: Text('Registration failed'),
          titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600),
          content: Text('$error'),
          contentTextStyle: TextStyle(fontFamily: 'Inter',color: Colors.white),
          actions: [
                    TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Colors.transparent),
                            minimumSize: MaterialStateProperty.all(
                                Size.zero),
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(0, 0, 10, 10))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ))
      ])));
      _pasreg.clear();
      _pascon.clear();
      }
                  // print(json.encode({
                  //   "fullName": regname,
                  //   "email": regemail,
                  //   "password": regpas,
                  //   // "address": '' //cuma sementara addressnya masih not null
                  // }));
                  // var isSuccess = json.decode(response.body)['isSuccess'];
                  // if (isSuccess) {
                    // showDialog(
                    //     context: context,
                    //     builder: ((context) => AlertDialog(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(10)),
                    //           backgroundColor: Color.fromARGB(255, 23, 22, 29),
                    //           title: Text('Registration Success!'),
                    //           titleTextStyle: TextStyle(
                    //               color: Colors.white,
                    //               fontFamily: 'Inter',
                    //               fontWeight: FontWeight.w600),
                    //           content: Text(
                    //               'Check your email to verify your account'),
                    //           contentTextStyle: TextStyle(color: Colors.white),
                    //           actions: [
                    //             TextButton(
                    //                 style: ButtonStyle(
                    //                     overlayColor: MaterialStateProperty.all(
                    //                         Colors.transparent),
                    //                     minimumSize: MaterialStateProperty.all(
                    //                         Size.zero),
                    //                     tapTargetSize:
                    //                         MaterialTapTargetSize.shrinkWrap,
                    //                     padding: MaterialStateProperty.all(
                    //                         EdgeInsets.fromLTRB(0, 0, 10, 10))),
                    //                 onPressed: () {
                    //                   Navigator.pushReplacement(context,
                    //                       MaterialPageRoute(
                    //                           builder: ((context) {
                    //                     return Login();
                    //                   })));
                    //                 },
                    //                 child: Text(
                    //                   'OK',
                    //                   style: TextStyle(color: Colors.white),
                    //                 )),
                    //           ],
                    //         )));
                  // } else {
                  //   var error = json.decode(response.body)['error'];
                  //   showDialog(
                  //       context: context,
                  //       builder: ((context) => AlertDialog(
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             backgroundColor: Color.fromARGB(255, 23, 22, 29),
                  //             title: Text('Error!'),
                  //             titleTextStyle: TextStyle(
                  //                 color: Colors.white,
                  //                 fontFamily: 'Inter',
                  //                 fontWeight: FontWeight.w600),
                  //             content: Text(
                  //                 '$error'),
                  //             contentTextStyle: TextStyle(color: Colors.white),
                  //             actions: [
                  //               TextButton(
                  //                   style: ButtonStyle(
                  //                       overlayColor: MaterialStateProperty.all(
                  //                           Colors.transparent),
                  //                       minimumSize: MaterialStateProperty.all(
                  //                           Size.zero),
                  //                       tapTargetSize:
                  //                           MaterialTapTargetSize.shrinkWrap,
                  //                       padding: MaterialStateProperty.all(
                  //                           EdgeInsets.fromLTRB(0, 0, 10, 10))),
                  //                   onPressed: () {
                                      
                  //                   },
                  //                   child: Text(
                  //                     'OK',
                  //                     style: TextStyle(color: Colors.white),
                  //                   )),
                  //             ],
                  //           )));
                  // }
      }
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeRegister = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.fromLTRB(15, 150, 15, 40)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create New Account,',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24)),
            Text('Please fill in the form to continue',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20))
          ],
        ),
      ],
    );

    Widget inputName = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
          filled: true,
          fillColor: Color.fromARGB(31, 217, 217, 217),
          contentPadding: EdgeInsets.fromLTRB(30, 10, 20, 10),
          hintText: 'Fullname',
          hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w200,
              color: Colors.white,
              fontSize: 12),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          //   child: Icon(Icons.),
          // )
        ),
        onChanged: (value) {
          setState(() {
            regname = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            _buttonController.reset();
            return "Please enter your name";
          }
        },
      ),
    );

    Widget regEmail = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.alternate_email,
            color: Colors.white,
          ),
          filled: true,
          fillColor: Color.fromARGB(31, 217, 217, 217),
          contentPadding: EdgeInsets.fromLTRB(30, 10, 20, 10),
          hintText: 'Email',
          hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w200,
              color: Colors.white,
              fontSize: 12),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          //   child: Icon(Icons.),
          // )
        ),
        onChanged: (value) {
          setState(() {
            regemail = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            _buttonController.reset();
            return "Please enter your email";
          } else if (!value.contains('@')) {
            _buttonController.reset();
            return "Please enter a valid email";
          }
        },
      ),
    );

    Widget regPassword = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: _pasreg,
        obscureText: _regpass,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.key,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Color.fromARGB(31, 217, 217, 217),
            contentPadding: EdgeInsets.fromLTRB(30, 10, 20, 10),
            hintText: 'Password',
            hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                color: Colors.white,
                fontSize: 12),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20)),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _regpass = !_regpass;
                });
              },
              icon: Icon(
                _regpass
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
            // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: Icon(Icons.),
            // )
            ),
        onChanged: (value) {
          setState(() {
            regpas = value;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            _buttonController.reset();
            return "PLease Enter Your Password";
          } else if (value.length < 8) {
            _buttonController.reset();
            return "Password must be 8 character or more";
          }
        },
      ),
    );

    Widget confirmPassword = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: _pascon,
        cursorColor: Colors.white,
        obscureText: _conpass,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Color.fromARGB(31, 217, 217, 217),
            contentPadding: EdgeInsets.fromLTRB(30, 10, 20, 10),
            hintText: 'Confirm Password',
            hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                color: Colors.white,
                fontSize: 12),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20)),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _conpass = !_conpass;
                });
              },
              icon: Icon(
                _conpass
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
            // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: Icon(Icons.),
            // )
            ),
        validator: (value) {
          if (value!.isEmpty) {
            _buttonController.reset();
            return "Please confirm your password";
          } else if (value != _pasreg.text) {
            _buttonController.reset();
            return "Password not match";
          } else {
            return null;
          }
        },
      ),
    );

    Widget regButton = Container(
        margin: EdgeInsets.only(top: 40),
        child: RoundedLoadingButton(
          height: 35,
          width: 150,
          loaderSize: 20,
          color: Color.fromARGB(255, 217, 217, 217),
          successColor: Color.fromARGB(255, 217, 217, 217),
          valueColor: Color.fromARGB(255, 27, 26, 32),
          controller: _buttonController, 
          onPressed: () => signup(_buttonController), 
          child: Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Text('Sign Up',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 27, 26, 32),
                      fontSize: 14)),
            )
          ));

    Widget loginButton = Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already Have an Account ? ',
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Colors.white),
          ),
          TextButton(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                minimumSize: MaterialStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            // style: TextButton.styleFrom(
            //   padding: EdgeInsets.zero,
            //   minimumSize: Size.zero,
            //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login();
              }));
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 22, 29),
      body: Form(
        key: formKey,
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.white,
            child: ListView(
              children: [
                welcomeRegister,
                inputName,
                regEmail,
                regPassword,
                confirmPassword,
                regButton,
                loginButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
