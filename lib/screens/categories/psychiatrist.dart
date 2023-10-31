import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smithackathon/function/custom_function.dart';

class PsychiatristScreen extends StatefulWidget {
  const PsychiatristScreen({super.key});

  @override
  State<PsychiatristScreen> createState() => _PsychiatristScreenState();
}

class _PsychiatristScreenState extends State<PsychiatristScreen> {
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
                  const Center(child: Text("Psychiatrist Doctor" ,style: TextStyle(fontSize: 18),))
                ],
              ),
            FutureBuilder<Widget>(
                future: func.fetchPsychiatrististData(setState, profilePic,),
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