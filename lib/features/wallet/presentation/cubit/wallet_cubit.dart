import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use-case/wallet_use_case.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final AddMoneyUseCase addMoneyUseCase;
  final GetWalletBalanceUseCase getWalletBalanceUseCase;

  WalletCubit({
    required this.addMoneyUseCase,
    required this.getWalletBalanceUseCase,
  }) : super(WalletInitialState());

  Future<void> addMoney(String userId, int amount) async {
    emit(WalletLoadingState());
    try {
      await addMoneyUseCase(userId, amount);
      final updatedBalance = await getWalletBalanceUseCase(userId);
      emit(WalletUpdatedState(updatedBalance));
    } catch (e) {
      emit(WalletErrorState(e.toString()));
    }
  }

  Future<void> fetchBalance(String userId) async {
    emit(WalletLoadingState());
    try {
      final balance = await getWalletBalanceUseCase(userId);
      emit(WalletUpdatedState(balance));
    } catch (e) {
      emit(WalletErrorState(e.toString()));
    }
  }
}
