import 'package:e_commerce_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/cubits/cubit_state.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/text_field.dart';
import 'package:e_commerce_app/features/constants/text_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      context.read<AuthCubit>().login(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please enter both email and password"),
          backgroundColor: Colors.redAccent.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
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
    // Premium Food Delivery Color Palette
    const primaryOrange = Color(0xFFFF5722);
    const darkOnboard = Color(0xFF1E1E24);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.redAccent.shade700,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            bool isDesktop = constraints.maxWidth >= 600;

            if (isDesktop) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryOrange.withValues(alpha: 0.05), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 650,
                    width: 460,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: mobileView(primaryOrange, darkOnboard),
                    ),
                  ),
                ),
              );
            }
            return SafeArea(child: mobileView(primaryOrange, darkOnboard));
          },
        ),
      ),
    );
  }

  Widget mobileView(Color accentColor, Color darkColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                // Brand Aesthetic Icon & Heading Block
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.fastfood_rounded,
                      size: 42,
                      color: accentColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    "Welcome Back",
                    style: BoldTextStyle.poppins.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: darkColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    "Gourmet meals delivered straight to your door",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Form Inputs Block
                Text(
                  "EMAIL ADDRESS",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                textField(false, emailController, 'Enter your email'),

                const SizedBox(height: 24),

                Text(
                  "PASSWORD",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                textField(true, passwordController, 'Enter your password'),

                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {}, // Optional: Add forgot password handling
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),


                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shadowColor: accentColor.withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Bottom Router Link
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Craving something new? ",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register Here",
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}