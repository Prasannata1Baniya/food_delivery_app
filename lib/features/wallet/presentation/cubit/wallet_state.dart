abstract class WalletState {}

class WalletInitialState extends WalletState {}

class WalletLoadingState extends WalletState {}

class WalletUpdatedState extends WalletState {
  final int balance;

  WalletUpdatedState(this.balance);
}

class WalletErrorState extends WalletState {
  final String error;

  WalletErrorState(this.error);
}
