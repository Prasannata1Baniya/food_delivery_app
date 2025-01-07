import '../entity/user_entity.dart';

abstract class WalletRepo{
 Future<void> addMoney(String userId, int amount);
 Future<int> getWalletBalance(String userId);
 Future<List<UserTransaction>> getTransaction(String userId);
}