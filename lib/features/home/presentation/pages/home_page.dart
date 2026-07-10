import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/text_font.dart';
import '../cubit/home-cubit/home_cubit.dart';
import '../cubit/home-cubit/home_state.dart';
import 'details_of_food.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFFF5722);
    const darkOnboard = Color(0xFF1E1E24);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text('Gourmet Express', style: AppBarTitleText.poppins.copyWith(color: Colors.white)),
        centerTitle: true,
        backgroundColor: darkOnboard,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome and Cart Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Friend 👋",
                          style: LightTextStyle.poppins.copyWith(fontSize: 16, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Pick Something Delicious",
                          style: BoldTextStyle.poppins.copyWith(fontSize: 22, color: darkOnboard),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10)
                        ],
                      ),
                      child: const Icon(Icons.shopping_cart_outlined, color: primaryOrange),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Premium Category Filter Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    categoryCard(
                      onTap: () => homeCubit.togglePizza(),
                      imagePath: "assets/material/pizza.png",
                      isSelected: state.isPizza,
                      label: "Pizza",
                      accentColor: primaryOrange,
                    ),
                    categoryCard(
                      onTap: () => homeCubit.toggleBurger(),
                      imagePath: "assets/material/burger.png",
                      isSelected: state.isBurger,
                      label: "Burger",
                      accentColor: primaryOrange,
                    ),
                    categoryCard(
                      onTap: () => homeCubit.toggleChicken(),
                      imagePath: "assets/material/fried_chicken.png",
                      isSelected: state.isChicken,
                      label: "Chicken",
                      accentColor: primaryOrange,
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                Text("Popular Choices", style: BoldTextStyle.poppins.copyWith(fontSize: 18, color: darkOnboard)),
                const SizedBox(height: 16),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      foodItemTile(context, "Pepperoni Pizza", "Fresh Mozzarella", "\$25",
                          "assets/material/pizza.png"),
                      foodItemTile(context, "Cheese Burger", "Smoked Cheddar", "\$18",
                          "assets/material/burger.png"),
                      foodItemTile(context, "Cheese Burger", "Smoked Cheddar",
                          "\$18", "assets/material/fried_chicken.png"),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                Text("Special Offers", style: BoldTextStyle.poppins.copyWith(fontSize: 18, color: darkOnboard)),
                const SizedBox(height: 16),

                // Bottom Long Combo Promo Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15, offset: const Offset(0, 8))
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: Colors.grey.shade100,
                          height: 80,
                          width: 80,
                          child: const Icon(Icons.fastfood_rounded, color: primaryOrange, size: 40),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Family Combo Deal", style: BoldTextStyle.poppins.copyWith(fontSize: 15)),
                            const SizedBox(height: 4),
                            Text("Get 2 Burgers + Large Fries", style: LightTextStyle.poppins.copyWith(fontSize: 13, color: Colors.grey)),
                            const SizedBox(height: 6),
                            Text("\$28", style: SemiBoldTextStyle.poppins.copyWith(color: primaryOrange)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget foodItemTile(BuildContext context, String title, String subtitle, String price, String assetPath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsPage()));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16, bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 6))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 140,
              decoration: BoxDecoration(
                color: const Color(0xFFFBFBFB),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.restaurant_menu_rounded, color: Colors.grey, size: 40), // Placeholder until images match perfectly
            ),
            const SizedBox(height: 12),
            Text(title, style: BoldTextStyle.poppins.copyWith(fontSize: 14)),
            Text(subtitle, style: LightTextStyle.poppins.copyWith(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            Text(price, style: SemiBoldTextStyle.poppins.copyWith(color: const Color(0xFFFF5722))),
          ],
        ),
      ),
    );
  }

  Widget categoryCard({
    required VoidCallback onTap,
    required String imagePath,
    required bool isSelected,
    required String label,
    required Color accentColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isSelected ? accentColor : Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: isSelected ? accentColor.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Icon(
              Icons.fastfood_outlined,
              color: isSelected ? Colors.white : Colors.grey.shade700,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? accentColor : Colors.grey.shade600,
            ),
          )
        ],
      ),
    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/text_font.dart';
import '../cubit/home-cubit/home_cubit.dart';
import '../cubit/home-cubit/home_state.dart';
import 'details_of_food.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page',style:AppBarTitleText.poppins),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<HomeCubit,HomeState>(
        builder: (context, state) {
         return Container(
            margin: const EdgeInsets.only(top: 50, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Hello Prasannata!"),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.shopping_cart,color: Colors.white,)
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                 Text("Pick Something",style: BoldTextStyle.poppins,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /*GestureDetector(
                      onTap: ()=>context.read<HomeCubit>().togglePizza(),
                      child: images(,"assets/material/pizza.png",
                          state.isPizza? Colors.black:Colors.white),
                    ),*/
                    images(context.read<HomeCubit>().togglePizza(), "assets/material/pizza.png",
                        state.isPizza? Colors.black:Colors.white),
                    images(context.read<HomeCubit>().toggleBurger(), "assets/material/pizza.png",
                        state.isBurger? Colors.black:Colors.white),
                    images(context.read<HomeCubit>().toggleChicken(), "assets/material/pizza.png",
                        state.isChicken? Colors.black:Colors.white)
                  ],
                ),
                const SizedBox(height: 15),

                Text("Delicious Food",style:BoldTextStyle.poppins),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      food(context),
                      food(context),
                      food(context),
                      food(context),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          "", height: 100, width: 150, fit: BoxFit.cover,),
                        SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 2,
                            child: Text("", style: BoldTextStyle.poppins,)),
                        const SizedBox(height: 10,),
                        SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 2,
                            child: Text("", style: LightTextStyle.poppins,)),
                        const SizedBox(height: 10,),
                        SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 2,
                            child: Text("\$28",
                              style: SemiBoldTextStyle.poppins,)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
    ),
    );
  }

GestureDetector food(context){
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => const DetailsPage()));
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("", height: 150, width: 150,),
              Text("", style: BoldTextStyle.poppins,),
              Text("", style: SemiBoldTextStyle.poppins,),
              Text("\$25", style: LightTextStyle.poppins,),
            ],
          ),
        ),
      ),
    );
  }


  GestureDetector images(void function,String image,Color color){
    return GestureDetector(
    onTap: ()=>function,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
            ),
            child: Image.asset(image, height: 50,
              width:60,fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
*/