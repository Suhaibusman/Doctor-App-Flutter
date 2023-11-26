import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smithackathon/data.dart';
import 'package:smithackathon/screens/DoctorScreen/doctor_home.dart';
import 'package:smithackathon/screens/home/home_screen.dart';

class LoginController extends GetxController{
  RxBool loading = false.obs;
 final FirebaseFirestore firestore = FirebaseFirestore.instance;
loginWithEmailAndPassword(
       emailController, passwordController) async {
        loading.value =true;
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (emailAddress == "" || password == "") {
      Get.defaultDialog(
        title: "Error",
        middleText: "Please Enter Username and Password"
      );
       loading.value =false;
    }
    else{
      try {
        loading.value =true;
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress, password: password);
  emailController.clear();
  passwordController.clear();
  // currentloginedUid = credential.user!.uid;
  box.write("currentloginedUid", credential.user!.uid);
  final userUid = credential.user!.uid;
  
  // Check if the user exists in the "doctor" collection
  DocumentSnapshot doctorSnapshot = await firestore.collection("doctor").doc(userUid).get();
  if (doctorSnapshot.exists) {
    // User is a doctor
    Map<String, dynamic> doctorData = doctorSnapshot.data() as Map<String, dynamic>;
    box.write("doctorPicture", doctorData["picture"]);
    box.write("doctorEmail", doctorData["emailAddress"]);
         box.write("doctorName", doctorData["username"]);
    String doctorEmail = box.read("doctorEmail");

    String doctorName = box.read("doctorName");
   
    String doctorPicture = box.read("doctorPicture");
    Get.off(DoctorScreen(doctorName: doctorName, doctorEmail: doctorEmail, doctorPicture: doctorPicture),);
    // Navigate to DoctorScreen
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => DoctorScreen(doctorName: doctorName, doctorEmail: doctorEmail, doctorPicture: doctorPicture),
    //   ),
    // );
  } else {
    // Check if the user exists in the "user" collection
    DocumentSnapshot userSnapshot = await firestore.collection("users").doc(userUid).get();
    if (userSnapshot.exists) {
      // User is a regular 
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    
     box.write("currentloginedName", userData["username"]);
     
     box.write("currentloginedEmail", userData["emailAddress"]);
    
      box.write("currentLogineedUserPicture", userData["picture"]);
    
     currentloginedName = box.read("currentloginedName");
     currentloginedEmail =box.read("currentloginedEmail");
       currentLogineedUserPicture =box.read("currentLogineedUserPicture");
      // Navigate to HomeScreen
    Get.off( HomeScreen(userName: currentloginedName, emailAdress: currentloginedEmail, profilePicture:currentLogineedUserPicture),);

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomeScreen(userName: currentloginedName, emailAdress: currentloginedEmail, profilePicture:currentLogineedUserPicture),
      //   ),
      // );
    } else {
       Get.defaultDialog(
        title: "Login Error",
        middleText: "I think You are not a doctor or patient"
      );
      // Handle the case where the user is neither a doctor nor a regular user
    }
  }
} catch (e) {
   Get.defaultDialog(
        title: "Error",
        middleText: e.toString()
      );
  
}

    }
    loading.value =false;

  }


}