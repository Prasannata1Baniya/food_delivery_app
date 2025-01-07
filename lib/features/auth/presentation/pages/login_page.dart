import 'package:e_commerce_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/text_field.dart';
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
    final String email=emailController.text;
    final String password=passwordController.text;

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
          body: isDesktop?
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
        );
      }
    );
    }

    Column mobile(){
    return Column(
      children: [
        const Text("Login Page"),
        const SizedBox(height: 20,),
        textField(false, emailController),
        const SizedBox(height: 10,),
        textField(true, passwordController),
        const SizedBox(height: 10,),
        ElevatedButton(
            onPressed: login,
            child:const  Text("Login")
        ),
        Row(
          children: [
            const Text("Not register?"),
            GestureDetector(
                onTap: widget.onTap,
                child: const Text("Register Here!")
            ),
          ],
        )
      ],
    );
    }
  }
