import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smithackathon/function/custom_function.dart';

class AllDoctorScreen extends StatefulWidget {
  const AllDoctorScreen({super.key});

  @override
  State<AllDoctorScreen> createState() => _AllDoctorScreenState();
}

class _AllDoctorScreenState extends State<AllDoctorScreen> {
  
  CustomFunction func = CustomFunction();
    File? profilePic;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Column(
    
          children: [
            Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.arrow_back)),
                    SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                     Center(child: Text("AllDoctor".tr ,style: const TextStyle(fontSize: 18),))
                  ],
                ),
            FutureBuilder<Widget>(
                future: func.fetchWholeData(setState, profilePic,),
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
              ) ,
          ],
        )
      ),
    );
  }
}