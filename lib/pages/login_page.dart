import 'package:flutter/material.dart';
import 'package:search_restaurant/pages/menu_page.dart';
import 'package:search_restaurant/pages/singup_page.dart';
import 'package:search_restaurant/servers/api_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApiAuth apiAuth = ApiAuth();
  bool ishide = true;
  final fromkey = GlobalKey<FormState>();
  TextEditingController Eamilcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController Usernamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: fromkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                    },
                    controller: Eamilcontroller,
                    decoration: InputDecoration(
                        hintText: 'eamil',
                        hintStyle: TextStyle(color: Color((0xff0070648))),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color((0xffFFA451)),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFFA451)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: ishide,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                    },
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                ishide = !ishide;
                              });
                            },
                            icon: Icon(ishide
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        hintText: 'password',
                        hintStyle: TextStyle(color: Color((0xff0070648))),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color((0xffFFA451)),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFFA451)))),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Color(0xffFFA451))),
                    onPressed: () {
                      if (fromkey.currentState!.validate()) {
                        apiAuth
                            .longin(
                                Eamilcontroller.text, passwordcontroller.text)
                            .then((isdone) {
                          if (isdone) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MenuPage();
                            }));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('فشل')));
                          }
                        });
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18.5),
                    )),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Donot you have an account?',
                        style: TextStyle(fontSize: 18.5)),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return singupPage();
                            },
                          ));
                        },
                        child: Text('sigin',
                            style: TextStyle(fontWeight: FontWeight.bold)))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
