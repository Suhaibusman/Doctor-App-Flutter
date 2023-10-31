
import 'package:flutter/material.dart';

import 'package:smithackathon/function/custom_function.dart';


class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
   CustomFunction func = CustomFunction();
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
                    const Center(child: Text("Appointments Details" ,style: TextStyle(fontSize: 18),))
                  ],
                ),
            FutureBuilder<Widget>(
                future: func.fetchAppointmentData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const Center(child: Text("No Fixed Appointment"));
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