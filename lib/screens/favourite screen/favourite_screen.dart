import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smithackathon/function/custom_function.dart';
import 'package:smithackathon/screens/navbar/bottomnavigation.dart';

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
      return ListView.builder(
        itemCount: favoriteDoctors!.length,
        itemBuilder: (context, index) {
          DocumentSnapshot doc = favoriteDoctors[index];
          // Build the UI for displaying favorite doctors
          return ListTile(
            title: Text(doc["username"]),
            // Add more widgets to display other doctor information
          );
        },
      );
    } else {
      return Text('No favorite doctors found.');
    }
  },
)
,
      bottomNavigationBar: const CustomBottomNavigationBar(pageindex: 2),
    );
  }
}