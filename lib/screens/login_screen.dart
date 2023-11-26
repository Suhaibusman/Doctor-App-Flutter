import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/constants/images.dart';
import 'package:smithackathon/controller/login_controller.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/screens/sign_up_screen.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textfieldwidget.dart';
import 'package:smithackathon/widgets/textwidget.dart';

class LoginScreen extends StatefulWidget {
 
   const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginController loginController =Get.put(LoginController());
  CustomFunction func = CustomFunction();
bool isPassword =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Column(
                  children: [
                      const SizedBox(
                  height: 50,
                ),
                    Image.asset(Myimages.loginOrSignUpImage),
                    const SizedBox(
                  height: 20,
                ),
                const TextWidget(
                    textMessage: "Login",
                    textColor: MyColors.blackColor,
                    textSize: 29),
               
                  ],
                ),
             
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextWidget(
                        textMessage: "Username:",
                        textColor: MyColors.greyColor,
                        textSize: 15),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                        textFieldController: emailController,
                        hintText: "Email Address",
                        textFieldIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.person),
                          color: MyColors.iconColor,
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    const TextWidget(
                        textMessage: "Password:",
                        textColor: MyColors.greyColor,
                        textSize: 15),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                        textFieldController: passwordController,
                        isPass: isPassword,
                        hintText: "Password",
                        textFieldIcon: IconButton(
                          onPressed: () {
                           setState(() {
                              isPassword =! isPassword;
                           });
                          },
                          icon: const Icon(Icons.remove_red_eye),
                          color: MyColors.iconColor,
                        )),
                  ],
                ),
                Image.asset(Myimages.orLine),
                Obx(() => loginController.loading.value ?const CircularProgressIndicator(): InkWell(
                    onTap: () {
                     loginController.loginWithEmailAndPassword( emailController, passwordController);
                    },
                    child: CustomButtonWidget(
                        bgColor: MyColors.purpleColor,
                        textMessage: "Login",
                        textColor: MyColors.whiteColor,
                        textSize: 15,
                        buttonWidth: MediaQuery.of(context).size.width))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextWidget(
                        textMessage: "Do You Want To Create an account? ",
                        textColor: MyColors.textFieldBorderColor,
                        textSize: 12),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ));
                        },
                        child: const TextWidget(
                            textMessage: " Sign up",
                            textColor: MyColors.blackColor,
                            textSize: 12)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
