import 'package:e_commerce_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/text_font.dart';
import '../../../home/presentation/pages/bottom_nav.dart';
import '../cubits/cubit_state.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register() {
    final name = nameController.text.trim();
    final email = nameController.text.trim();
    final password = nameController.text.trim();
    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      authCubit.register(name, email, password);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter both email and password"))
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool isDesktop = constraints.maxWidth >= 600;
          return Scaffold(
            body:BlocListener<AuthCubit,AuthState>(
                listener: (context,state)
          {
            if (state is AuthenticatedState) {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const BottomNavbar()));
            }
            else if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)));
            }
           },
                child:isDesktop ?
                Center(
                  child: Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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

  Container mobile() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
          children: [
             Text("Register Page",style: BoldTextStyle.poppins,),
            const SizedBox(height: 20,),
            textField(false, nameController,'userName'),
            const SizedBox(height: 10,),
            textField(false, emailController,'email'),
            const SizedBox(height: 10,),
            textField(true, passwordController,'password'),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed:()=> context.read<AuthCubit>().register(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text.trim()
                ),
                child: const Text("Register")
            ),
            const SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Already a member?"),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text("Login Here!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}