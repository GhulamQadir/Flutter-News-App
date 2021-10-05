import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String imagePath;

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image.path;
    });
    print(imagePath);
  }

  void register() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      final String userName = userNameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;
      final String imageName = path.basename(imagePath);

      FirebaseFirestore db = FirebaseFirestore.instance;

      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/$imageName');

      File file = File(imagePath);
      await ref.putFile(file);

      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String downloadUrl = await ref.getDownloadURL();

      await db.collection("users").doc(user.user.uid).set({
        "userName": userName,
        "email": email,
        "image": downloadUrl,
      });

      userNameController.clear();
      emailController.clear();
      passwordController.clear();

      print("Your registration has been completed !");
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          });
    }
  }

  goToLoginScreen() {
    Navigator.of(context).pushNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                // Center(
                //   child: Container(
                //     height: 150,
                //     width: 200,
                //     decoration: BoxDecoration(
                //         image: DecorationImage(
                //             image: NetworkImage(
                //                 "https://previews.123rf.com/images/businessvector/businessvector1510/businessvector151000024/45788264-newspaper-icon.jpg"))),
                //   ),
                // ),

                // GestureDetector(
                //   onTap: pickImage,
                //   child: CircleAvatar(
                //     radius: 100,
                //     // backgroundColor: Colors.transparent,
                //     backgroundImage: NetworkImage(
                //         "https://www.pngitem.com/pimgs/m/6-67022_dslr-camera-vector-icon-camera-vector-icon-png.png"),
                //   ),
                // ),

                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: imagePath == null
                          ? NetworkImage(
                              "https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-camera-512.png")
                          : FileImage(File(imagePath)),
                      // NetworkImage(
                      //     "https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-camera-512.png")
                    )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.orange[300],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xffF8F0E3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.orange[300],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xffF8F0E3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.orange[300],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xffF8F0E3),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 150,
                    child: TextButton(
                        onPressed: register,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.orange[500]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            )))),
                Padding(
                  padding: const EdgeInsets.only(top: 13, bottom: 10),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        GestureDetector(
                          onTap: goToLoginScreen,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 17, color: Colors.orange[400]),
                          ),
                        ),
                      ],
                    ),
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
