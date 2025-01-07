import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/presentation/profile-cubit/profile_cubit.dart';
import '../../../profile/presentation/profile-cubit/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body:BlocBuilder<ProfileCubit,ProfileState>(
          builder: (context,state){
            if(state.isLoading){
                 return const CircularProgressIndicator();
            }
            if(state.errorMessage !=null){
               return Center(child: Text('Error: ${state.errorMessage}'));
            }
            if(state.profile==null){
              return const Center(child:Text("User not found "));
            }
            final profile=state.profile!;
            return Column(
              children: [
                CircleAvatar(
                   backgroundImage: NetworkImage(profile.profileImage),
                  radius: 50,
                ),
                const SizedBox(height: 16),
                container(context, "Name: ",profile.name),
                const SizedBox(height: 8,),
                container(context, "Email: ",profile.email),
              ],
            );
      }),
    );
  }

  Material container(context,String title,String content){
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin:const  EdgeInsets.all(12.0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Text("Name:"),
            Text(content),
          ],
        ),
      ),
    );
  }
}
