import '../repo/wallet_repo.dart';

class AddMoneyUseCase {
  final WalletRepo repository;

  AddMoneyUseCase(this.repository);

  Future<void> call(String userId, int amount) {
    return repository.addMoney(userId, amount);
  }
}

class GetWalletBalanceUseCase {
  final WalletRepo repository;

  GetWalletBalanceUseCase(this.repository);

  Future<int> call(String userId) {
    return repository.getWalletBalance(userId);
  }
}
