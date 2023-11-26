import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/constants/images.dart';
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

class FieldsCategories extends StatefulWidget {
  const FieldsCategories({super.key});

  @override
  State<FieldsCategories> createState() => _FieldsCategoriesState();
}

class _FieldsCategoriesState extends State<FieldsCategories> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextWidget(
                      textMessage: "categories".tr,
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
                                      builder: (context) => const AllDoctorScreen(),
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
                             Text(
                              "all".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                             Text(
                              "Cardiology".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                             Text(
                              "Dentist".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                             Text(
                              "OrthoPedic".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                             Text(
                              "Dermotologist".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                             Text(
                              "Gastrologist".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                             Text(
                              "Neurologist".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                             Text(
                              "Psychiatrist".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                             Text(
                              "Gynecologist".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                                child: Image.asset(Myimages.orthomologistIcon),
                              ),
                            ),
                             Text(
                              "Optholomogist".tr,
                              style: const TextStyle(color: MyColors.greyColor),
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
                                child: Image.asset(Myimages.pediatrictaionIcon),
                              ),
                            ),
                             Text(
                              "Peditrician".tr ,
                              style: const TextStyle(color: MyColors.greyColor),
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
            );
  }
}