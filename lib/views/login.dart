import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myapp/views/CardPage.dart';
import 'package:myapp/views/forgetPass.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String email = '';
  String password = '';

  bool isLoginPage = false;
  bool isVissible = true;

  void beginAuth() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      submitFirebase(email, password, userName);
    }
  }

  Future<void> submitFirebase(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;

    try {
      if (isLoginPage) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signed in successfully', style: TextStyle(
          color: Colors.white
          ),)),
        );
        Get.off(CardApp());
      } else {
        await auth.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully', style: TextStyle(
          color: Colors.white
          ),)),
        );
        Get.off(CardApp());
        String uid = auth.currentUser!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'userName': userName,
          'email': email,
          'Password':password
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Authentication failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black38
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isLoginPage? 'Login Page':'SignUp Page',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
              color: Colors.black87),),
              Gap(20),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (!isLoginPage)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 4) {
                            return 'Enter at least 4 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userName = value!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Colors.grey.shade300),
                          prefixIcon: Icon(Icons.person, color: Colors.grey.shade800),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(color: Colors.grey.shade100),
                      ),
                    const Gap(12),
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                        prefixIcon: Icon(Icons.mail, color: Colors.grey.shade800),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.grey.shade100),
                    ),
                    const Gap(12),
                    TextFormField(
                      key: ValueKey('password'),
                      obscureText: isVissible,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey.shade800,),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            isVissible = !isVissible;
                          });
                        },
                        icon: isVissible == true ? Icon(Icons.visibility_off, color: Colors.grey.shade800):
                        Icon(Icons.visibility, color: Colors.grey.shade800))
                      ),
                      style: TextStyle(color: Colors.grey.shade100),
                    ),
                    const Gap(16),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: beginAuth,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          isLoginPage ? 'Login' : 'Sign Up',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const Gap(12),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLoginPage = !isLoginPage;
                        });
                      },
                      child: Text(
                        isLoginPage ? 'Create new account' : 'Already have an account? Sign in',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: Text('Forgot Password?',
                      style: TextStyle(color: Colors.black),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
