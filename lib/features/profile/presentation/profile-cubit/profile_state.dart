
import '../../domain/entity/profile_user_entity.dart';

class ProfileState{
  final UserProfile? profile;
  final bool isLoading;
  final String? errorMessage;
  ProfileState({
    this.profile,
    this.isLoading=false,
    this.errorMessage,
});

  ProfileState copyWith({
   UserProfile? profile,
   bool? isLoading,
    String ?errorMessage,
}){
    return ProfileState(
    profile: profile ?? this.profile,
    isLoading: isLoading?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    );
}
}

//class ProfileInitialState extends ProfileState{}

//class ProfileLoadingState extends ProfileState{}

//class ProfileLoadedState extends ProfileState{}

//class ProfileFailureState extends ProfileState{}
