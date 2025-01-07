class UserTransaction{
  final String id;
  final int amount;
  final String type;
  final DateTime timeStamp;

  UserTransaction({required this.id, required this.amount,
    required this.type, required this.timeStamp});

  factory UserTransaction.fromFirestore(Map<String, dynamic> data, String id) {
    return UserTransaction(
      id: data['id'],
      amount: data['amount'],
      type: data['type'],
      timeStamp: DateTime.parse(data['timestamp']),
    );
  }

  // Method to convert a Transaction object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'timeStamp': timeStamp.toIso8601String(),
    };
  }
}