// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/constants/images.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/provider/theme/theme_provider.dart';
import 'package:smithackathon/screens/categories/all_doctors.dart';
import 'package:smithackathon/screens/home/widgets/all_doctors.dart';
import 'package:smithackathon/screens/home/widgets/field_categories.dart';

import 'package:smithackathon/screens/navbar/bottomnavigation.dart';
import 'package:smithackathon/widgets/textwidget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String? uid;
  String loginedUsername;
  HomeScreen({
    Key? key,
    this.uid,
    required this.loginedUsername,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CustomFunction func = CustomFunction();
  File? profilePic;



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
            key: _scaffoldKey,
         drawer: Drawer(
         child: ListView(
          children: <Widget>[
              UserAccountsDrawerHeader(
                 decoration: const BoxDecoration(
          color: MyColors.purpleColor, // Set the background color to purple
        ),
              accountName: const Text('Muhammad Suhaib Usman'),
              accountEmail: const Text('Suhaibusman54@gmail.com'),
              currentAccountPicture:  CircleAvatar(
  radius: 50,
  backgroundColor: Colors.transparent, // Set the background color to transparent
  child: ClipOval(
    child: Image.asset(Myimages.mypic),
  ),
)
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact Number'),
              subtitle: Text('+92311-2136120'),
            ),
           Padding(
             padding: const EdgeInsets.only(left :10 ,right :10),
             child: Row(
              mainAxisAlignment: 
              MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Dark Theme" , style:  TextStyle( fontSize: 16 , fontWeight: FontWeight.bold),),
                          Consumer<ThemeProvider>(
                            builder: (context, provider, child) => Switch(
                              value: provider.themeMode == ThemeData.dark(),
                              onChanged: (newValue) {
                                provider.toogleTheme();
                              },
                            ),
                          ),
                                ],
                      ),
           ),
             Padding(
             padding: const EdgeInsets.only(left :10 ,right :10),
             child: Row(
              mainAxisAlignment: 
              MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Sign Out" , style:  TextStyle( fontSize: 16 , fontWeight: FontWeight.bold),),
                            IconButton(onPressed: (){
                              func.signout(context);
                            }, icon: const Icon(Icons.logout))
                        ],
                      ),
           )
         
                  

          ],
        ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                color: MyColors.purpleColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                              // func.signout(context);
                            },
                            child: Image.asset(Myimages.drawerIcon)),
                        InkWell(
                          onTap: () async {
                            XFile? selectedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            print("Image Selected");
                    
                            if (selectedImage != null) {
                              File convertedFile = File(selectedImage.path);
                    
                              //  await FirebaseStorage.instance.ref().child("profilepictures").child(const Uuid().v1()).putFile(profilePic!);
                              setState(() {
                                profilePic = convertedFile;
                              });
                              print("Image Selected!");
                            } else {
                              print("No Image Selected!");
                            }
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey,
                            backgroundImage: (profilePic != null)
                                ? FileImage(profilePic!)
                                : null,
                          ),
                        )
                      ],
                    ),
                     TextWidget(
                        textMessage: "Welcome ${widget.loginedUsername}",
                        textColor: MyColors.whiteColor,
                        textSize: 15),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: const TextWidget(
                            textMessage: "Lets find your Top Doctor",
                            textColor: MyColors.whiteColor,
                            textSize: 36)),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextWidget(
                        textMessage: "Doctor's Inn",
                        textColor: MyColors.whiteColor,
                        textSize: 36),
                   
                  ],
                ),
              ),
            ),
            const FieldsCategories(),

          const AllDoctorData()
           ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(pageindex: 0),
      ),
    );
  }
}
