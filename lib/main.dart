import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/data/data_repos/firebase_auth_repo_impl.dart';
import 'package:e_commerce_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/cubits/cubit_state.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/auth_page.dart';
import 'package:e_commerce_app/features/home/presentation/cubit/home-cubit/home_cubit.dart';
import 'package:e_commerce_app/features/home/presentation/pages/bottom_nav.dart';
import 'package:e_commerce_app/features/profile/presentation/profile-cubit/profile_cubit.dart';
import 'package:e_commerce_app/features/storage/data/firebase_storage_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/presentation/cubit/navigation-cubit/navigation_cubit.dart';
import 'features/profile/data/repo/user_profile_iml.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final userProfileRepo=UserProfileImpl(FirebaseFirestore.instance);
  final storageRepo=FirebaseStorageRepo();

    runApp(
      MultiBlocProvider(providers: [
        BlocProvider(create: (_)=> HomeCubit()),
        BlocProvider(create: (_)=> NavigationCubit()),
        BlocProvider(create: (_)=>ProfileCubit(userProfileRepo, storageRepo)),
      ], child: MyApp()),
      );
}

class MyApp extends StatelessWidget {
  final authRepo=AuthRepoImpl();
   MyApp({super.key,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ( context)=> AuthCubit(authRepository: authRepo)..checkUser(),
      child: MaterialApp(
      home:BlocConsumer<AuthCubit,AuthState>(
          builder: (context,state) {
        if(state is AuthenticatedState){
          return const BottomNavbar();
        }
        if(state is UnAuthenticatedState){
          return const AuthPage();
        }
        else{
          return const Scaffold(
            body:CircularProgressIndicator()
          );
        }
      },
          listener: (context,state){
            if(state is ErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)));
            }
          }
      ),
      ),
    );
  }
}

