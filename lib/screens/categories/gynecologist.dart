import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smithackathon/function/custom_function.dart';

class GynecologiistScreen extends StatefulWidget {
  const GynecologiistScreen({super.key});

  @override
  State<GynecologiistScreen> createState() => _GynecologiistScreenState();
}

class _GynecologiistScreenState extends State<GynecologiistScreen> {
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
                  const Center(child: Text("GyneCologist Doctor" ,style: TextStyle(fontSize: 18),))
                ],
              ),
            FutureBuilder<Widget>(
                future: func.fetchGynecologistData(setState, profilePic,),
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