import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smithackathon/data.dart';
import 'package:smithackathon/screens/login_screen.dart';

class SignoutController extends GetxController {
  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    box.remove("currentloginedUid");
    box.remove("doctorEmail");

    box.remove("doctorName");

    box.remove("doctorPicture");
    box.remove("currentloginedName");
    box.remove("currentloginedEmail");
    box.remove("currentLogineedUserPicture");
    Get.until((route) => route.isFirst);
    Get.offAll(const LoginScreen());
  }
}
