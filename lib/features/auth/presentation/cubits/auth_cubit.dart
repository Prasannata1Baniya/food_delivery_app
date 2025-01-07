import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repo.dart';
import 'cubit_state.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthRepository authRepository;
  AppUser? _currentUser;

  AuthCubit({required this.authRepository}):super(AuthInitialState());

  //check user is authenticated or not
  void checkUser() async{
    final AppUser? user= await authRepository.getCurrentUser();

    //if exists
    if(user!=null){
      _currentUser=user;
      emit(AuthenticatedState(user));
    }
    else{
      emit(UnAuthenticatedState());
    }
  }

  //get currentUser
  AppUser? get currentUser => _currentUser;

  //login
  Future<void> login(String email,String password) async {
    try{
      emit(LoadingState());
      final user=await authRepository.loginWithEmailAndPassword(email, password);

      if(user!=null){
        _currentUser=user;
        emit(AuthenticatedState(user));
      }else{
        emit(UnAuthenticatedState());
      }
    }catch(e){
        emit(ErrorState("$e"));
        emit(UnAuthenticatedState());
    }
  }

  //register
Future<void> register(String name, String email,String password) async {
  try {
    emit(LoadingState());
    final user = await authRepository.register(name, email, password);

    if (user != null) {
      _currentUser = user;
      emit(AuthenticatedState(user));
    } else {
      emit(UnAuthenticatedState());
    }
  } catch (e) {
    emit(ErrorState("$e"));
    emit(UnAuthenticatedState());
  }
}

//logout
Future<void> logOut() async{
   authRepository.logOut();
}
}
