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
import 'package:smithackathon/screens/categories/cardiology_screen.dart';
import 'package:smithackathon/screens/categories/dentist.dart';
import 'package:smithackathon/screens/categories/dermotologist.dart';
import 'package:smithackathon/screens/categories/gastrologist.dart';
import 'package:smithackathon/screens/categories/gynecologist.dart';
import 'package:smithackathon/screens/categories/neurologist.dart';
import 'package:smithackathon/screens/categories/opthalmogist.dart';
import 'package:smithackathon/screens/categories/orthopedic.dart';
import 'package:smithackathon/screens/categories/peditrician.dart';
import 'package:smithackathon/screens/categories/psychiatrist.dart';
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                      textMessage: "Categories",
                      textColor: MyColors.blackColor,
                      textSize: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AllDoctors(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.allIcon),
                              ),
                            ),
                            const Text(
                              "all",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CardiologyScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.cardiologyIcon),
                              ),
                            ),
                            const Text(
                              "Cardiology",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DentistScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.dentistIcon),
                              ),
                            ),
                            const Text(
                              "Dentist",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),

                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OrthoPedicScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.orthopedicIcon),
                              ),
                            ),
                            const Text(
                              "OrthoPedic",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        //iske bbd kam krna hee
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DermotologistScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.dermotologistIcon),
                              ),
                            ),
                            const Text(
                              "Dermotologist",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const GastrologistScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.gastrologistIcon),
                              ),
                            ),
                            const Text(
                              "Gastrologist",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),

                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NeurologistScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.neurologistIcon),
                              ),
                            ),
                            const Text(
                              "Neurologist",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PsychiatristScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.psychatristIcon),
                              ),
                            ),
                            const Text(
                              "Psychiatrist",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),

                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const GynecologiistScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.gyneIcon),
                              ),
                            ),
                            const Text(
                              "Gynecologist",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),  Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OpthalmologistScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.psychatristIcon),
                              ),
                            ),
                            const Text(
                              "Optholomogist",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),

                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PeditriationScreen(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                width: 60,
                                child: Image.asset(Myimages.gyneIcon),
                              ),
                            ),
                            const Text(
                              "Peditrician",
                              style: TextStyle(color: MyColors.greyColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //   ElevatedButton(onPressed: (){
            //     func.fecthData();
            //   }, child: const Text("Fetch")),
            //      ElevatedButton(onPressed: (){
            //       func.addUsertoFireBase(context);

            //   }, child: const Text("Add User")),

            //    ElevatedButton(onPressed: (){
            //     provider.toogleTheme();

            //   }, child: const Text("Toogle")),
            FutureBuilder<Widget>(
              future: func.fetchWholeData(
                setState,
                profilePic,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return const Center(child: Text("No Data Found"));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
