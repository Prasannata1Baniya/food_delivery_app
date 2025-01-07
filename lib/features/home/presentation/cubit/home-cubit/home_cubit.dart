import 'package:e_commerce_app/features/home/presentation/cubit/home-cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit():super(const HomeState());

  void togglePizza()=> emit(state.copyWith(isPizza:!state.isPizza));
  void toggleBurger()=> emit(state.copyWith(isBurger: !state.isBurger));
  void toggleChicken()=> emit(state.copyWith(isChicken:!state.isChicken));
}