import 'package:e_commerce_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final name = nameController.text;
    final email = nameController.text;
    final password = nameController.text;
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
            body: isDesktop ?
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
          );
        }
    );
  }

  Column mobile() {
    return Column(
        children: [
          const Text("Login Page"),
          const SizedBox(height: 20,),
          textField(false, nameController),
          const SizedBox(height: 10,),
          textField(false, emailController),
          const SizedBox(height: 10,),
          textField(true, passwordController),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: register,
              child: const Text("Login")
          ),
          Row(
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
        ]);
  }
}