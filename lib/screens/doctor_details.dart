import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/widgets/buttonwidget.dart';
import 'package:smithackathon/widgets/textwidget.dart';

class DoctorDetails extends StatefulWidget {
  final String username;
  final String speciality;
  final String profileimages;

  const DoctorDetails({super.key, required this.username, required this.speciality, required this.profileimages});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left:20, right: 20),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back)),
                  SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                  const Center(child: Text("Appointment" ,style: TextStyle(fontSize: 18),))
                ],
              ),
        
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 123,
                    width: 89,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(widget.profileimages)),
                    TextWidget(textMessage: widget.username, textColor: MyColors.blackColor, textSize: 25),
                ],
              ),
              
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  const Icon(Icons.data_saver_on_sharp, color: Colors.red,),
                  const SizedBox(width: 10,),
                   TextWidget(textMessage: widget.speciality, textColor: MyColors.greyColor, textSize: 15),
                 ],
               ),
        
               const SizedBox(
                height: 30,
               ),
              Container(
                height: 106,
                width: MediaQuery.of(context).size.width,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyColors.purpleColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                                    height: 76,
                                    width: 80,
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: MyColors.whiteColor
                                    ),
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                           TextWidget(textMessage: "350 +" ,textColor: MyColors.purpleColor, textSize: 26),
                                                TextWidget(textMessage: "Patients" ,textColor: MyColors.purpleColor, textSize: 12),
                                    
                                      ],
                                    ),
                                    ),
                    )
                  
                      ,Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                                    height: 76,
                                    width: 80,
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: MyColors.whiteColor
                                    ),
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                           TextWidget(textMessage: "15+" ,textColor: MyColors.greenColor, textSize: 26),
                                                TextWidget(textMessage: "Patients" ,textColor: MyColors.greenColor, textSize: 12),
                                    
                                      ],
                                    ),
                                    ),
                    ),
                        Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                                    height: 76,
                                    width: 80,
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: MyColors.whiteColor
                                    ),
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                           TextWidget(textMessage: "284+" ,textColor: MyColors.pinkColor, textSize: 26),
                                                TextWidget(textMessage: "Reviews" ,textColor: MyColors.pinkColor, textSize: 12),
                                    
                                      ],
                                    ),
                                    ),
                    )
                  
                  
                  ],
                ),
              ),
              const SizedBox(height: 10,),
               const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   TextWidget(textMessage: "About Doctor" ,textColor: MyColors.blackColor, textSize: 20),
                 ],
               ),
                const SizedBox(height: 10,),
                 TextWidget(textMessage: "${widget.username} is the top most ${widget.speciality} specialist in Nanyang Hospitalat London. She is available for private consultation." ,textColor: MyColors.greyColor, textSize: 15),
                 const SizedBox(height: 10,),
                 const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   TextWidget(textMessage: "Schedule Doctor" ,textColor: MyColors.blackColor, textSize: 20),
                   TextWidget(textMessage: "October" ,textColor: MyColors.blackColor, textSize: 20),

                 ],
               ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                         firestore.collection(widget.username).add({"Datetime": DateTime.now(), 
                         });
                  },
                  child: const CustomButtonWidget(bgColor: MyColors.purpleColor, textMessage: "FixAppointment", textColor: MyColors.whiteColor, textSize: 15, buttonWidth: 200))
                 , const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TextWidget(textMessage: "Visit Hour" ,textColor: MyColors.blackColor, textSize: 20),
                    ],
                  ),
            ],
          ),
        ),


      ),
    );
  }
}

