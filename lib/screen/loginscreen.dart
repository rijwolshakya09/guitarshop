import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/repository/customer_repository.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:motion_toast/motion_toast.dart';

import '../model/customappbarlogin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  int counter = 1;

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? username, password;

  _navigatorToScreen(bool isLogin) {
    if (isLogin) {
      Navigator.pushReplacementNamed(context, '/layout');
    } else {
      MotionToast.error(
        description: const Text("Either Username Or Password is Not Correct"),
      ).show(context);
    }
  }

  _login() async {
    try {
      CustomerRepository userRepository = CustomerRepository();
      bool isLogin = await userRepository.login(
        _usernameController.text,
        _passwordController.text,
      );
      if (isLogin) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: counter,
            channelKey: 'basic_channel',
            title: 'Login Success',
            body: 'Welcome To Guitar Shop',
          ),
        );
        setState(() {
          counter++;
        });
        _navigatorToScreen(true);
      } else {
        _navigatorToScreen(false);
      }
    } catch (e) {
      MotionToast.error(
        description: Text("Error: ${e.toString()}"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 180,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: ClipPath(
            clipper: CustomAppBar(),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF535699),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Image.asset('assets/images/MainGuitarLogo.png'),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Title(
                  color: const Color(0xFF535699),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xFF535699),
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      fontFamily: 'Merienda',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //=============================Username Text Field==============================
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF535699),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF535699),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          key: const ValueKey("username"),
                          controller: _usernameController,
                          cursorColor: const Color(0xFF535699),
                          style: const TextStyle(
                            color: Color(0xFF535699),
                            fontFamily: 'Merienda',
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Fluent.person_20_filled,
                              color: Color(0xFF535699),
                              size: 34,
                            ),
                            labelText: 'Username',
                            hintText: 'Enter Your Username',
                            labelStyle: TextStyle(fontSize: 18),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Username';
                            }
                            return null;
                          },
                        ),
                      ),

                      //===========================Password Text Field================================
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF535699),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF535699),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          key: const ValueKey("password"),
                          controller: _passwordController,
                          cursorColor: const Color(0xFF535699),
                          style: const TextStyle(
                            color: Color(0xFF535699),
                            fontFamily: 'Merienda',
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Ph.lock_key_fill,
                              color: Color(0xFF535699),
                              size: 34,
                            ),
                            labelText: 'Password',
                            hintText: 'Enter Your Password',
                            labelStyle: TextStyle(fontSize: 18),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      //=================================Forget Password==============================
                      Container(
                        margin: const EdgeInsets.only(top: 18),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: Color(0xFF535699),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Merienda',
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),

                      //=================================Login Button=================================
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: ElevatedButton(
                          key: const ValueKey("loginBtn"),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF535699),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                _login();
                              }
                            });
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Merienda',
                            ),
                          ),
                        ),
                      ),

                      //=================================Or Bar=======================================
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              color: Color(0xFF535699),
                              indent: 5,
                              endIndent: 5,
                              thickness: 2,
                            ),
                          ),
                          Text(
                            "Or",
                            style: TextStyle(
                              color: Color(0xFF535699),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Merienda',
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(0xFF535699),
                              indent: 5,
                              endIndent: 5,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),

                      //==============================Social Media Links==============================
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.grey.shade200,
                                child: const Iconify(
                                  Logos.google_icon,
                                  // color: Color(0xFF2471FF),
                                  size: 40,
                                )),
                          ),
                          const SizedBox(
                            width: 42,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.grey.shade200,
                                child: const Iconify(
                                  SimpleIcons.facebook,
                                  color: Color(0xFF2471FF),
                                  size: 40,
                                )),
                          ),
                        ],
                      ),

                      //==============================Sign Up Button Link=============================
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't Have An Account?",
                            style: TextStyle(
                              // color: Color(0xFF535699),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Merienda',
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.pushNamed(
                                  context,
                                  '/register',
                                );
                              });
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFF535699),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Merienda',
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
