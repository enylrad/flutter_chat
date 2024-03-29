import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final _fireStore = Firestore.instance;
  static const String _collectionName = 'messages';

  void save({Map<String, dynamic> collectionValues}) {
    _fireStore.collection(_collectionName).add(collectionValues);
  }

  Stream<QuerySnapshot> getMessagesStream() {
    return _fireStore.collection(_collectionName).orderBy("timestamps").snapshots();
  }
}
