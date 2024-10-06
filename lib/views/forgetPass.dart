import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:myapp/views/login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String newPassword = '';
  String confirmPassword = '';
  bool isSubmitting = false;

  Future<void> resetPassword() async {
    try {
      // Check if the email exists in Firestore
      QuerySnapshot userRecord = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userRecord.docs.isNotEmpty) {
        // Allow user to update password
        if (newPassword == confirmPassword) {
          String uid = userRecord.docs[0].id;

          // Update the password in Firebase Authentication
          await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);

          // Update the password in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({'Password': newPassword});

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password updated successfully')));
          Get.off(AuthScreen());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Passwords do not match')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found with this email')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        isSubmitting = true;
      });
      resetPassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black38,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.off(AuthScreen());
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black38),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forget Password Page',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Gap(20),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail),
                  ),
                  style: TextStyle(color: Colors.grey.shade100),
                ),
                Gap(12),
                TextFormField(
                  key: ValueKey('newPassword'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Enter at least 6 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newPassword = value!;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  style: TextStyle(color: Colors.grey.shade100),
                ),
                Gap(12),
                TextFormField(
                  key: ValueKey('confirmPassword'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Enter at least 6 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    confirmPassword = value!;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm New Password',
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  style: TextStyle(color: Colors.grey.shade100),
                ),
                Gap(16),
                SizedBox(
                  height: 46,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text('Reset Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
