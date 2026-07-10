import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void togglePizza() {
    emit(state.copyWith(isPizza: true,
      isBurger: false,
      isChicken: false,
    ));
  }

  void toggleBurger() {
    emit(state.copyWith(
      isPizza: false,
      isBurger: true,
      isChicken: false,
    ));
  }

  void toggleChicken() {
    emit(state.copyWith(
      isPizza: false,
      isBurger: false,
      isChicken: true,
    ));
  }
}