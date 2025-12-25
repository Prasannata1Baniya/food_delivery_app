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