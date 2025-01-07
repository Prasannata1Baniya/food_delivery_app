import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repo/wallet_repo.dart';

class WalletRepoImpl implements WalletRepo {
  final FirebaseFirestore firestore;

  WalletRepoImpl(this.firestore);

  @override
  Future<void> addMoney(String userId, int amount) async {
    final userWalletRef = firestore.collection('users').doc(userId);
    final transactionId = DateTime.now().millisecondsSinceEpoch.toString();

    await firestore.runTransaction((transaction) async {
      final walletBalanceDoc = userWalletRef.collection('wallet').doc('balance');
      final transactionsCollection = userWalletRef.collection('wallet').doc('transactions').collection('records');

      // Fetch the balance document
      final walletDoc = await transaction.get(walletBalanceDoc);

      if (!walletDoc.exists) {
        // Create the wallet with initial balance
        transaction.set(walletBalanceDoc, {'balance': amount});
      } else {
        // Update the existing balance
        final currentBalance = walletDoc.get('balance') as int;
        transaction.update(walletBalanceDoc, {'balance': currentBalance + amount});
      }

      // Add a transaction entry
      transaction.set(
        transactionsCollection.doc(transactionId),
        {
          'id': transactionId,
          'amount': amount,
          'type': 'credit',
          'timestamp': FieldValue.serverTimestamp(),
        },
      );
    });
  }

  @override
  Future<int> getWalletBalance(String userId) async {
    final walletBalanceDoc = firestore
        .collection('users')
        .doc(userId)
        .collection('wallet')
        .doc('balance');

    final snapshot = await walletBalanceDoc.get();
    if (snapshot.exists) {
      return snapshot.get('balance') as int;
    } else {
      return 0; // Return 0 if balance document doesn't exist
    }
  }

  @override
  Future<List<UserTransaction>> getTransaction(String userId) async {
    final transactionsCollection = firestore
        .collection('users')
        .doc(userId)
        .collection('wallet')
        .doc('transactions')
        .collection('records');

    final querySnapshot = await transactionsCollection.get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return UserTransaction(
        id: data['id'] ?? '',
        amount: data['amount'] ?? 0,
        type: data['type'] ?? 'unknown',
        timeStamp: (data['timestamp'] as Timestamp).toDate(),
      );
    }).toList();
  }
}






/*import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repo/wallet_repo.dart';

class WalletRepoImpl implements WalletRepo {
  final FirebaseFirestore firestore;

  WalletRepoImpl(this.firestore);

  @override
  Future<void> addMoney(String userId, int amount) async {
    final userWalletRef =
    firestore.collection('users').doc(userId).collection('wallet');
        ///.doc('balance')
        ///.collection('transactions');
    final transactionId = DateTime.now().millisecondsSinceEpoch.toString();

    await firestore.runTransaction((transaction) async {
      final walletDoc = await transaction.get(userWalletRef.doc('balance'));

      if (!walletDoc.exists) {
        // If the wallet doesn't exist, create it with the initial balance
        transaction.set(userWalletRef.doc('balance'), {'balance': amount});
      } else {
        // If the wallet exists, update the balance
        final currentBalance = walletDoc.get('balance') as int;
        transaction.update(userWalletRef.doc('balance'),
            {'balance': currentBalance + amount});
      }

      // Add a transaction entry in the transactions sub-collection
      transaction.set(
        userWalletRef.collection('transactions').doc(transactionId),
        {
          'id': transactionId,
          'amount': amount,
          'type': 'credit',
          'timestamp': FieldValue.serverTimestamp(),
        },
      );
    });
  }

  @override
  Future<int> getWalletBalance(String userId) async {
    final walletDoc = await firestore
        .collection('users')
        .doc(userId)
        .collection('wallet')
        .doc('balance')
        .get();

    if (walletDoc.exists) {
      return walletDoc.get('balance') as int;
    } else {
      return 0; // Return 0 if no wallet exists
    }
  }

  @override
  Future<List<UserTransaction>> getTransaction(String userId) async {
    final transactionDocs = await firestore
        .collection('users')
        .doc(userId)
        .collection('wallet')
        .doc('balance') // Access the balance document
        .collection('transactions') // Access the transactions sub-collection
        .get();

    return transactionDocs.docs.map((doc) {
      final data = doc.data();
      return UserTransaction(
        id: data['id'] ?? '',
        amount: data['amount'] ?? 0,
        type: data['type'] ?? 'unknown',
        timeStamp: (data['timestamp'] as Timestamp).toDate(),
      );
    }).toList();
  }
}
*/