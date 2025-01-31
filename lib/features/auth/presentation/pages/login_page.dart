import 'package:e_commerce_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/cubits/cubit_state.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/text_field.dart';
import 'package:e_commerce_app/features/constants/text_font.dart';
import 'package:e_commerce_app/features/home/presentation/pages/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  void login(){
    final String email=emailController.text.trim();
    final String password=passwordController.text.trim();

    final authCubit=context.read<AuthCubit>();
    if(email.isNotEmpty && password.isNotEmpty){
      authCubit.login(email, password);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter both email and password")));
    }
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isDesktop = constraints.maxWidth >=600;
        return Scaffold(
          body: BlocListener(listener: (context,state){
            if(state is AuthenticatedState){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>const BottomNavbar()));
            }
            else if(state is ErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)));
            }
          },
          child: isDesktop?
            Center(
            child: Container(
            height: 600,
            width:500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black,
                width: 0.5,
              ),
            ),
            child: mobile(),
          ),
        )
            : mobile(),
          ),
        );
      }
    );
    }
    Container mobile(){
    return Container(
      margin:const  EdgeInsets.all(10),
      child: Column(
        children: [
           Text("Login Page",style: BoldTextStyle.poppins,),
          const SizedBox(height: 20,),
          const Text("Email"),
          textField(false, emailController,'email'),
          const SizedBox(height: 10,),
          const Text("Password"),
          textField(true, passwordController,'password'),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                context.read<AuthCubit>().login(
                    emailController.text.trim(),
                    passwordController.text.trim()
                );
              },
              child:const  Text("Login")
          ),
          Row(
            children: [
              const Text("Not register?"),
              GestureDetector(
                  onTap: widget.onTap,
                  child: const Text("Register Here!",
                    style: TextStyle(fontWeight: FontWeight.bold),)
              ),
            ],
          )
        ],
      ),
    );
    }
  }
