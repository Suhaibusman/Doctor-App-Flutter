import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smithackathon/function/custom_function.dart';

class AllDoctors extends StatefulWidget {
  const AllDoctors({super.key});

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  
  CustomFunction func = CustomFunction();
    File? profilePic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
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
    );
  }
}