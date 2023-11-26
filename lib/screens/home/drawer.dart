// import 'package:flutter/material.dart';

// class DrawerDefault extends StatelessWidget {
//   const DrawerDefault({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Drawer(
//          child: ListView(
//           children: <Widget>[
//               UserAccountsDrawerHeader(
//                  decoration: const BoxDecoration(
//           color: MyColors.purpleColor, // Set the background color to purple
//         ),
//               accountName: Text(widget.userName ??""),
//               accountEmail:Text(widget.emailAdress ??""),
//               currentAccountPicture: widget.profilePicture != null ? CircleAvatar(
//   radius: 50,
//   backgroundColor: Colors.transparent, // Set the background color to transparent
//   child: ClipOval(
    
//     child: Image.network(widget.profilePicture ?? "https://www.freepnglogos.com/uploads/camera-logo-png/camera-icon-download-17.png",
//      width: 80,  // Adjust the width and height as needed
//     height: 80,
//     fit: BoxFit.cover,),
//   ),


// )
//      :InkWell(
//                           onTap: () async {
//                             XFile? selectedImage = await ImagePicker()
//                                 .pickImage(source: ImageSource.gallery);
//                             print("Image Selected");
                    
//                             if (selectedImage != null) {
//                               File convertedFile = File(selectedImage.path);
//                            UploadTask uploadimage = FirebaseStorage.instance
//             .ref()
//             .child("profilepictures")
//             .child(currentloginedUid)
//             .putFile(profilePic!);

//         TaskSnapshot taskSnapshot = await uploadimage;
//         String downloadurl = await taskSnapshot.ref.getDownloadURL();
//         await FirebaseFirestore.instance.collection("users").doc(currentloginedUid).update({
//           "picture": downloadurl
//         });

//                               //  await FirebaseStorage.instance.ref().child("profilepictures").child(const Uuid().v1()).putFile(profilePic!);
//                               setState(() {
//                                 profilePic = convertedFile;
//                               });
//             //                    UploadTask uploadimage = FirebaseStorage.instance
//             // .ref()
//             // .child("profilepictures")
//             // .child(currentloginedUid!)
//             // .putFile(profilePic!);
//                               print("Image Selected!");
//                             } else {
//                               print("No Image Selected!");
//                             }
//                           },
//                           child: CircleAvatar(
//                             radius: 25,
//                             backgroundColor: Colors.grey,
//                             backgroundImage: (profilePic != null)
//                                 ? FileImage(profilePic!)
//                                 : null,
//                           ),
//                         )       ),
//             const ListTile(
//               leading: Icon(Icons.phone),
//               title: Text('Contact Number'),
//               subtitle: Text('+92311-2136120'),
//             ),
//            Padding(
//              padding: const EdgeInsets.only(left :10 ,right :10),
//              child: Row(
//               mainAxisAlignment: 
//               MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("Dark Theme" , style:  TextStyle( fontSize: 16 , fontWeight: FontWeight.bold),),
//                            Obx(
//               () => Switch(
//                   value: themeController.isSwitched.value,
//                   onChanged: (value) {
//                     themeController.setIsSwitched(value);
//                   }),
//             ),
//                                 ],
//                       ),
//            ),
//              Padding(
//              padding: const EdgeInsets.only(left :10 ,right :10),
//              child: Row(
//               mainAxisAlignment: 
//               MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("Sign Out" , style:  TextStyle( fontSize: 16 , fontWeight: FontWeight.bold),),
//                             IconButton(onPressed: (){
//                              signoutController.signout();
//                             }, icon: const Icon(Icons.logout))
//                         ],
//                       ),
//            )
         
                  

//           ],
//         ),
//         ),
//         ;
//   }
// }