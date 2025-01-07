import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../storage/domain/repo/storage_repo.dart';
import '../../domain/entity/profile_user_entity.dart';
import '../../domain/repo/user_profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState>{
  final UserProfileRepo userProfileRepo;
  final StorageRepo storageRepo;
  ProfileCubit(this.userProfileRepo,this.storageRepo):super(ProfileState());

    Future<void> fetchUserProfile(String userId) async{
       emit(state.copyWith(isLoading:true));
      try{
        final profile=await userProfileRepo.fetchUserProfile(userId);
        emit(state.copyWith(profile: profile,isLoading: false));
      }catch(e){
        emit(state.copyWith(isLoading: false,errorMessage:e.toString() ));
      }
    }

    //updating profileImage
    Future<void> updateProfile({required String uid}) async{
  emit(ProfileState(isLoading: true));
  
    }

    Future<void> saveUserProfile(String userId,UserProfile profile)async {
      emit(state.copyWith(isLoading:true));
      try {
         await userProfileRepo.saveUserProfile(userId, profile);
         emit(state.copyWith(profile: profile,isLoading: false));
      } catch (e) {
            emit(state.copyWith(errorMessage: e.toString()));
      }
    }

}