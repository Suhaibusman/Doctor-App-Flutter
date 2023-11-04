import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smithackathon/constants/colors.dart';
import 'package:smithackathon/data.dart';
import 'package:smithackathon/screens/cat%20screen/cat_screen.dart';
import 'package:smithackathon/screens/favourite%20screen/favourite_screen.dart';
import 'package:smithackathon/screens/home/appointments/appointment_screen.dart';
import 'package:smithackathon/screens/home/home_screen.dart';


class CustomBottomNavigationBar extends StatefulWidget {
  final int pageindex;

  const CustomBottomNavigationBar({Key? key, required this.pageindex}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentindex = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  final List<Widget> items = [
    const Icon(Icons.home, size: 30),
    const Icon(Icons.category, size: 30),
    const Icon(Icons.favorite, size: 30),
    const Icon(Icons.more_vert, size: 30),
  ];



  @override
  void initState() {
    super.initState();
    currentindex = widget.pageindex;
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: bottomNavigationKey,
      backgroundColor: const Color(0xffF8F7FB),
      buttonBackgroundColor: MyColors.purpleColor,

      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      items: items,
      height: 70,
      index: currentindex, // Set the initial selected index
      onTap: (pageindex) async {
        setState(() {
          currentindex = pageindex;
        });
        if (pageindex ==0) {
       await   Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeScreen(userName: currentloginedName, emailAdress: currentloginedEmail),));
       setState(() {});
        } else  if (pageindex ==1) {
         await    Navigator.push(context, MaterialPageRoute(builder: (context) => const CatScreen(),));
            setState(() {});
        } 
        else  if (pageindex ==2) {
         await    Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouriteScreen(),));
             setState(() {});
        } 
        else  if (pageindex ==3) {
          await   Navigator.push(context, MaterialPageRoute(builder: (context) =>  AppointmentScreen() ,));
            setState(() {});
        } 
       
      },
    );
  }
}
