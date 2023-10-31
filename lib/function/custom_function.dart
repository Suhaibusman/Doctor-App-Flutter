// ignore_for_file: unused_import, avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/data.dart';
import 'package:smithackathon/screens/doctor_details.dart';
import 'package:smithackathon/screens/home_screen.dart';
import 'package:smithackathon/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textfieldwidget.dart';
import 'package:smithackathon/widgets/textwidget.dart';

class CustomFunction {
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Future customDialogBox(
    context,
    String title,
    String message,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  signUpWithEmailAndPassword(
      context, emailController, passwordController, userNameController) async {
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String userName = userNameController.text.toString().trim();

    if (emailAddress == "" || password == "" || userName == "") {
      customDialogBox(context, "Sign up Error", "Please Fill All The Values");
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        await firestore.collection("users").doc(credential.user!.uid).set({
          "username": userName,
          "emailAddress": emailAddress,
          "Password": password
        });
        if (credential.user != null) {
          customDialogBox(context, "Sign Up Successfully",
              "The User With This Email: $emailAddress is Registered Successfully");
          emailController.clear();
          passwordController.clear();
          userNameController.clear();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          customDialogBox(context, "Sign Up Error", "The Password is To Weak");
        } else if (e.code == 'email-already-in-use') {
          customDialogBox(context, "Sign Up Error",
              "The account already exists for that email");
        }
      } catch (e) {
        customDialogBox(context, "Error", e.toString());
      }
    }
  }

  loginWithEmailAndPassword(
      context, emailController, passwordController) async {
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (emailAddress == "" || password == "") {
      customDialogBox(context, "Error", "Please Fill All The Values");
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
        emailController.clear();
        passwordController.clear();
        if (credential.user != null) {
          currentloginedUsername = credential.user!.uid;
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(uid: credential.user!.uid, loginedUsername: currentname ?? "back",),
              ));
        }
      } on FirebaseAuthException catch (e) {
        customDialogBox(context, "Error", e.code.toString());
      }
    }
  }

  signout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  //for fetching whole data
  fecthData() async {
    //querysnaphot me pora data ayegaa
    QuerySnapshot snapshot = await firestore.collection("users").get();
    for (var doc in snapshot.docs) {
      log(doc.toString());
    }
  }

  Future<Widget> fetchWholeData(
    setState,
    profilePic,
  ) async {
// ...

    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection("doctor").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.pinkColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.pinkColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
  
  //for fetching specific data
  fecthSpecificData() async {
    //agr specific document pr run krenge to document snapshot me aayega sirf ek user ka data aayega
    DocumentSnapshot snapshot =
        await firestore.collection("users").doc("05NHGEjt1Jklkbd1Yl4h").get();

    log(snapshot.toString());
  }
  fetchUserName() async {
  DocumentSnapshot snapshot = await firestore.collection("users").doc(currentloginedUsername).get();
  
  if (snapshot.exists) {
    // Access and store the user's data in variables
    Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

    if (userData != null) {
       currentname = userData["username"];
      
    } else {
      print("User data is null.");
    }
  } else {
    print("User document does not exist.");
  }
}


  addUsertoFireBase(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              textFieldController: passController,
              hintText: "Password",
              isPass: true,
            ),
            CustomTextField(
              textFieldController: emailController,
              hintText: "Email Address",
            ),
          ],
        ),
        actions: [
          InkWell(
              onTap: () {
                //is method me doc id khud set horahi
                firestore.collection("users").add({
                  "Password": passController.text,
                  "emailAddress": emailController.text
                });
                passController.clear();
                emailController.clear();
                Navigator.pop(context);
              },
              child: const Center(
                  child: CustomButtonWidget(
                      bgColor: MyColors.blackColor,
                      textMessage: "Add",
                      textColor: MyColors.whiteColor,
                      textSize: 30,
                      buttonWidth: 100)))
        ],
      ),
    );
  }

  updateData(context, doc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              textFieldController: passController,
              hintText: "Password",
              isPass: true,
            ),
            CustomTextField(
              textFieldController: emailController,
              hintText: "Email Address",
            ),
          ],
        ),
        actions: [
          InkWell(
              onTap: () async {
                //is method me doc id khud set horahi
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(doc.id)
                    .update({
                  'name': passController.text,
                  'emailAddress': emailController.text,
                  // Update other fields as well
                }).then((value) {
                  customDialogBox(context, "Value Updated", "Document updated");
                  Navigator.pop(context); // Close the dialog
                }).catchError((error) {
                  customDialogBox(
                      context, "Error", "Error updating document: $error");
                });
                passController.clear();
                emailController.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Center(
                  child: CustomButtonWidget(
                      bgColor: MyColors.blackColor,
                      textMessage: "Add",
                      textColor: MyColors.whiteColor,
                      textSize: 30,
                      buttonWidth: 100)))
        ],
      ),
    );
  }

  deleteData(context, doc) async {
    try {
      await firestore.collection('users').doc(doc.id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${doc['name']} deleted Successfully"),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Handle any errors that occur during the delete operation
      print(e);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("An error occurred while deleting the document."),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
    }
  }

  doctorSignUpWithEmailAndPassword(context, emailController, passwordController,
      userNameController, selectedDoctorField, profilePic) async {
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String userName = userNameController.text.toString().trim();
    // String speciality = specialityController.text.toString().trim();
    if (emailAddress == "" || password == "" || userName == "") {
      customDialogBox(context, "Sign up Error", "Please Fill All The Values");
    } else if (selectedDoctorField == "Select Value") {
      customDialogBox(
          context, "Sign up Error", "Please Select Your Specialiity");
    } else if (profilePic == null) {
      customDialogBox(context, "Sign up Error", "Please Upload Your Image");
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );

        signupDoctorUid = credential.user!.uid;
        UploadTask uploadimage = FirebaseStorage.instance
            .ref()
            .child("profilepictures")
            .child(credential.user!.uid)
            .putFile(profilePic!);

        TaskSnapshot taskSnapshot = await uploadimage;
        String downloadurl = await taskSnapshot.ref.getDownloadURL();
        await firestore.collection("doctor").doc(credential.user!.uid).set({
          "username": userName,
          "emailAddress": emailAddress,
          "Password": password,
          "speciality": selectedDoctorField,
          "picture": downloadurl
        });

        if (credential.user != null) {
          customDialogBox(context, "Sign Up Successfully",
              "The User With This Email: $emailAddress is Registered Successfully");
          emailController.clear();
          passwordController.clear();
          userNameController.clear();
          selectedDoctorField = "Select Value";
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          customDialogBox(context, "Sign Up Error", "The Password is To Weak");
        } else if (e.code == 'email-already-in-use') {
          customDialogBox(context, "Sign Up Error",
              "The account already exists for that email");
        } else {
          customDialogBox(context, "Error", e.code);
        }
      } catch (e) {
        customDialogBox(context, "Error", e.toString());
      }
    }
  }

  Future<Widget> fetchCardiologyData(
    setState,
    profilePic,
  ) async {
// ...

    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where(
            "speciality",
            isEqualTo: "Cardiologist",
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
  Future<Widget> fetchOrthoPedicData(
    setState,
    profilePic,
  ) async {
// ...

    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where("speciality", isEqualTo: "Orthopedic")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
  Future<Widget> fetchDentistData(
    setState,
    profilePic,
  ) async {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where("speciality", isEqualTo: "Dentist")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
 Future<Widget> fetchNeuroLogistData(
    setState,
    profilePic,
  ) async {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where("speciality", isEqualTo: "Neurologist")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
Future<Widget> fetchPsychiatrististData(
    setState,
    profilePic,
  ) async {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where("speciality", isEqualTo: "Psychiatrist")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
Future<Widget> fetchGynecologistData(
    setState,
    profilePic,
  ) async {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where("speciality", isEqualTo: "Obstetrician-Gynecologist")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
Future<Widget> fetchOptholomoogistData(
    setState,
    profilePic,
  ) async {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where("speciality", isEqualTo: "Ophthalmologist")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
Future<Widget> fetchPediatrcianData(
    setState,
    profilePic,
  ) async {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where("speciality", isEqualTo: "Pediatrician")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
Future<Widget> fetchGastrologistData(
    setState,
    profilePic,
  ) async {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where("speciality", isEqualTo: "Gastroenterologist")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
Future<Widget> fetchDermatologistData(
    setState,
    profilePic,
  ) async {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("doctor")
          .where("speciality", isEqualTo: "Dermatologist")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  //querysnaphot me pora data ayegaa

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetails(
                                  username: doc["username"],
                                  speciality: doc["speciality"],
                                  profileimages: doc["picture"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(doc["picture"]),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_outlined,
                                        color: MyColors.greenColor,
                                      ),
                                      Text("4.8"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    textMessage: doc["username"],
                                    textColor: MyColors.blackColor,
                                    textSize: 20),
                                TextWidget(
                                    textMessage: doc["speciality"],
                                    textColor: MyColors.greyColor,
                                    textSize: 13),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 103,
                                      decoration: BoxDecoration(
                                          color: MyColors.greyColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "Appointment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.chat,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 34,
                                        width: 34,
                                        decoration: BoxDecoration(
                                            color: MyColors.greyColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: MyColors.greyColor,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

}
