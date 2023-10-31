import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smithackathon/function/custom_function.dart';

class AllDoctorData extends StatefulWidget {
  const AllDoctorData({super.key});

  @override
  State<AllDoctorData> createState() => _AllDoctorDataState();
}

class _AllDoctorDataState extends State<AllDoctorData> {
  CustomFunction func = CustomFunction();
  File? profilePic;

  @override
  Widget build(BuildContext context) {
    return   FutureBuilder<Widget>(
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
            );
          
  }
}