import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guitarshop/repository/customer_repository.dart';
import 'package:wear/wear.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class LoginScreenState extends StatefulWidget {
  const LoginScreenState({Key? key}) : super(key: key);

  @override
  State<LoginScreenState> createState() => _LoginScreenStateState();
}

class _LoginScreenStateState extends State<LoginScreenState> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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

  _navigatorToScreen(bool isLogin) {
    if (isLogin) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      Fluttertoast.showToast(
        msg: ("Either Username Or Password is Not Correct"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.transparent,
        textColor: Colors.black,
      );
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
      Fluttertoast.showToast(
        msg: ("Error: ${e.toString()}"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.transparent,
        textColor: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(
        builder: (context, mode, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter username',
                        // border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter first number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter password',
                        // border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter first number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          });
                        },
                        child: const Text("Login"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
