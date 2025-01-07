import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/order_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/profile_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/wallet_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/navigation-cubit/navigation_cubit.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return const Center(child: Text("User not logged in!"));
    }
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit,int>(
          builder: (context,currentTabIndex){
        return CurvedNavigationBar(
          animationDuration: const Duration(milliseconds:300),
          backgroundColor: Colors.white,
          color:Colors.black,
          onTap: (index){
            context.read<NavigationCubit>().updateTab(index);
          },
          items:const  [
            Icon(Icons.home_outlined,color: Colors.white,),
            Icon(Icons.shopping_bag_outlined,color: Colors.white),
            Icon(Icons.wallet_outlined,color:Colors.white,),
            Icon(Icons.person_outlined,color: Colors.white,),
          ],
        );
      }),
      body: BlocBuilder<NavigationCubit,int>(
          builder: (context,currentTabIndex){
           switch(currentTabIndex){
             case 0:
               return const HomePage();
             case 1:
               return const OrderPage();
             case 2:
               return  WalletPage(userId: userId,);
             case 3:
               return const ProfilePage();
             default:
               return const Center(child:Text("Other Pages"));
           }
      }),
    );
  }
}










/*import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/order_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/profile_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/wallet_page.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentTabIndex=0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomePage home;
  late ProfilePage profile;
  late OrderPage order;
  late WalletPage wallet;

  @override
  void initState() {
    home=const HomePage();
    order=const OrderPage();
    wallet=const WalletPage();
    profile=const ProfilePage();
    pages=[home,order,wallet,profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          animationDuration: const Duration(milliseconds:300),
          backgroundColor: Colors.white,
          color:Colors.black,
          onTap: (int index){
            setState(() {
              currentTabIndex=index;
            });
          },
          items:const  [
            Icon(Icons.home_outlined,color: Colors.white,),
            Icon(Icons.shopping_bag_outlined,color: Colors.white),
            Icon(Icons.wallet_outlined,color:Colors.white,),
            Icon(Icons.person_outlined,color: Colors.white,),
          ],
      ),
      body: pages[currentTabIndex],
    );
  }
}*/
