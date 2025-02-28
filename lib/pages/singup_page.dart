import 'package:flutter/material.dart';
import 'package:search_restaurant/pages/login_page.dart';
import 'package:search_restaurant/servers/api_auth.dart';

class singupPage extends StatefulWidget {
  const singupPage({super.key});

  @override
  State<singupPage> createState() => _singupPageState();
}

class _singupPageState extends State<singupPage> {
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
                controller: Usernamecontroller,
                decoration: InputDecoration(
                    hintText: 'username',
                    hintStyle: TextStyle(color: Color((0xff0070648))),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color((0xffFFA451)),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFFA451)))),
              ),
            ),
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
                        icon: Icon(
                            ishide ? Icons.visibility_off : Icons.visibility)),
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
                    backgroundColor: WidgetStatePropertyAll(Color(0xffFFA451))),
                onPressed: () {
                  if (fromkey.currentState!.validate()) {
                    apiAuth
                        .singup(Usernamecontroller.text, Eamilcontroller.text,
                            passwordcontroller.text)
                        .then((isdone) {
                      if (isdone) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('فشل')));
                      }
                    });
                  }
                },
                child: Text(
                  'singUp',
                  style: TextStyle(fontSize: 18.5),
                )),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do you have an account?',
                  style: TextStyle(color: Color(0xff0070648), fontSize: 16),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ));
                    },
                    child: Text(
                      'longin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0070648)),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
