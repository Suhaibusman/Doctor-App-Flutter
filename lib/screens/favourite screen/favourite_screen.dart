import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/screens/doctor_details.dart';
import 'package:smithackathon/screens/navbar/bottomnavigation.dart';
import 'package:smithackathon/widgets/textwidget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
   CustomFunction func = CustomFunction();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<DocumentSnapshot>>(
  future: func.getFavoriteDoctors(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (snapshot.hasData) {
     
      List<DocumentSnapshot<Object?>>? favoriteDoctors = snapshot.data;
 if (favoriteDoctors!.isEmpty) {
              return const Center(child: TextWidget(textMessage: "No Favourite Doctor Found", textColor: MyColors.blackColor, textSize: 20));
            }
      return ListView.builder(
        itemCount: favoriteDoctors.length,
        itemBuilder: (context, index) {
          DocumentSnapshot doc = favoriteDoctors[index];
          // Build the UI for displaying favorite doctors
          return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetailsScreen(
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
                                        NetworkImage(doc["profileimages"]),
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
                                        child:  Center(
                                          child:IconButton(onPressed: (){
                                              func.removeFromFavorites(doc.id); 
                                              setState(() {});
                                          }, icon: const Icon(Icons.favorite,
                                            color: Colors.red,))
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
      );
    } else {
      return const Text('No favorite doctors found.');
    }
  },
)
,
      bottomNavigationBar: const CustomBottomNavigationBar(pageindex: 2),
    );
  }
}