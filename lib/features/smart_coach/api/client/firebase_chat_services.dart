import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fitness/core/enum/sender.dart';

import '../../domain/entity/message_entity.dart';
import 'package:injectable/injectable.dart';




// class FirebaseChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   String get _userId => UserManager().currentUser!.personalInfo!.id!;
//
//
//   CollectionReference<Map<String, dynamic>> get _conversationRef =>
//       _firestore.collection('users').doc(_userId).collection('conversations');
//
//   Future<String> startNewConversation({Map<String, dynamic>? meta}) async {
//
//
//       final doc = await _conversationRef.add({
//         'startedAt': FieldValue.serverTimestamp(),
//         'lastUpdated': FieldValue.serverTimestamp(),
//         'lastMessage': '',
//         ...?meta,
//       });
//       return doc.id;
//
//   }
//
//   Future<DocumentReference> saveMessage({
//     required String conversationId,
//     required MessageEntity message,
//   }) async {
//     final messageData = {
//       'role': message.role.name,
//       'text': message.text,
//       'timestamp': FieldValue.serverTimestamp(),
//       'editedAt': null,
//       'isDeleted': message.isDeleted,
//     };
//
//     final docRef = await _conversationRef
//         .doc(conversationId)
//         .collection('messages')
//         .add(messageData);
//
//     await _conversationRef.doc(conversationId).update({
//       'lastMessage': message.text,
//       'lastUpdated': FieldValue.serverTimestamp(),
//     });
//
//     return docRef;
//   }
//
//   Future<void> updateMessage({
//     required String conversationId,
//     required String messageId,
//     required String newText,
//   }) async {
//     await _conversationRef
//         .doc(conversationId)
//         .collection('messages')
//         .doc(messageId)
//         .update({
//       'text': newText,
//       'editedAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//
//   Future<void> deleteMessage({
//     required String conversationId,
//     required String messageId,
//     bool soft = true,
//   }) async {
//     final ref = _conversationRef
//         .doc(conversationId)
//         .collection('messages')
//         .doc(messageId);
//
//     if (soft) {
//       await ref.update({
//         'isDeleted': true,
//         'editedAt': FieldValue.serverTimestamp(),
//       });
//     } else {
//       await ref.delete();
//     }
//   }
//
//
//   Future<List<MessageEntity>> getChatHistory(String conversationId) async {
//     final snapshot = await _conversationRef
//         .doc(conversationId)
//         .collection('messages')
//         .orderBy('timestamp', descending: false)
//         .get();
//
//     return snapshot.docs.map((doc) {
//       final data = doc.data();
//       return MessageEntity(
//         id: doc.id,
//         role: SenderX.fromString(data['role'] ?? 'user'),
//         text: data['text'] ?? '',
//         timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
//         editedAt: (data['editedAt'] as Timestamp?)?.toDate(),
//         isDeleted: data['isDeleted'] ?? false,
//       );
//     }).toList();
//   }
//
//   Stream<List<MessageEntity>> streamMessages(String conversationId) {
//     return _conversationRef
//         .doc(conversationId)
//         .collection('messages')
//         .orderBy('timestamp', descending: false)
//         .snapshots()
//         .map((snap) => snap.docs.map((doc) {
//       final data = doc.data();
//       return MessageEntity(
//         id: doc.id,
//         role: SenderX.fromString(data['role'] ?? 'user'),
//         text: data['text'] ?? '',
//         timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
//         editedAt: (data['editedAt'] as Timestamp?)?.toDate(),
//         isDeleted: data['isDeleted'] ?? false,
//       );
//     }).toList());
//   }
//
//
//   Future<List<Content>> getMessagesAsGeminiContent(
//       String conversationId) async {
//     final messages = await getChatHistory(conversationId);
//
//     return messages
//         .where((m) => !m.isDeleted)
//         .map((m) => Content(
//       role: m.role.name,
//       parts: [Part.text(m.text)],
//     ))
//         .toList();
//   }
//   Future<List<Map<String, dynamic>>> getAllConversations() async {
//     final snapshot = await _conversationRef.orderBy('lastUpdated',
//         descending: true).get();
//
//     return snapshot.docs.map((doc) {
//       final data = doc.data();
//       return {
//         "id": doc.id,
//         "lastMessage": data["lastMessage"] ?? "",
//         "startedAt": (data["startedAt"] as Timestamp?)?.toDate().toString() ?? "",
//         "lastUpdated": (data["lastUpdated"] as Timestamp?)?.toDate().toString() ?? "",
//       };
//     }).toList();
//   }
//
// }
// @LazySingleton()
// class FirebaseChatServices{
// final FirebaseFirestore _firestore=FirebaseFirestore.instance;
// final userId=UserManager().currentUser!.personalInfo!.id;
// CollectionReference get  _conversationRef=>
//     _firestore.collection("users").doc(userId).collection("conversations");
// Future<String>startNewConversation()async{
//  final conversationRef= await _conversationRef.add({
//     'startedAt': FieldValue.serverTimestamp(),
//   });
//  return conversationRef.id;
// }
// Future<void>setConversionTitle(String conversionId,String title)async{
// _conversationRef.doc(conversionId).update({'title':title});
// }
// Future<void>saveMessage(String conversionId,MessageEntity message)async{
//   _conversationRef.doc(conversionId).collection("messages").add({
//     'text':message.text,
//     'role':message.role.name,
//     'startedAt':message.timestamp
//   });
// }
// Future<List<MessageEntity>> getMessages(String conversionId)async{
//   final  querySnapshot = await _conversationRef.doc(conversionId).collection("messages").orderBy("startedAt")
//       .get();
//   return querySnapshot.docs.map((doc) {
//     final data = doc.data();
//     return MessageEntity(
//       text: data['text'],
//       role: data['role'] == 'user' ? Sender.user : Sender.system,
//     );
//   }).toList();
// }
// Future<List<Map<String, dynamic>>> getConversationSummaries()async{
//  final querySnapShot=await _conversationRef.orderBy( 'startedAt',descending: true).get();
//
// final List<Map<String, dynamic>> summaries = [];
//
//  for (final doc in querySnapShot.docs) {
//    final convoId = doc.id;
//
//    // Fetch the first user message
//    final messageSnapshot = await
//   _conversationRef.
//        doc(convoId)
//        .collection('messages')
//        .orderBy('startedAt')
//        .limit(1)
//        .get();
//
//    String title = 'test';
//    if (messageSnapshot.docs.isNotEmpty) {
//      final messageData = messageSnapshot.docs.first.data();
//      if (messageData['sender'] == 'user' && messageData['text'] != null) {
//        title = messageData['role'];
//      }
//    }
//    summaries.add({
//      'id': convoId,
//      'timestamp': doc['timestamp'],
//      'text': title,
//    });
//  }
//
//  return summaries;
// }
// }

@injectable
class FirebaseChatService {
  final _firestore = FirebaseFirestore.instance;

  String? get userId =>UserManager().currentUser!.personalInfo!.id;
  CollectionReference<Map<String, dynamic>> get _conversationRef =>
      _firestore.collection(Constants.usersCollection).doc(userId).
      collection(Constants.conversationsCollection);
  Future<String> startNewConversation() async {
    final conversationRef = await _conversationRef
        .add({Constants.fieldStartedAt: FieldValue.serverTimestamp()});
    return conversationRef.id;
  }

  Future<void> setConversationTitle(String conversationId, String title) async {
    await
    _conversationRef
        .doc(conversationId)
        .update({Constants.fieldTitle: title});
  }

  Future<void> saveMessage(String conversationId, MessageEntity message) async {
    await
       _conversationRef.
        doc(conversationId)
        .collection(Constants.messagesCollection)
        .add({
         Constants.fieldText: message.text,
         Constants.sender: message.role.name,
         Constants.fieldStartedAt: FieldValue.serverTimestamp(),
    });
  }

  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    final snapshot = await _conversationRef
        .doc(conversationId)
        .collection(Constants.messagesCollection)
        .orderBy(Constants.fieldStartedAt)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return MessageEntity(
        text: data[Constants.fieldText],
        role: data[Constants.sender] == 'user' ? Sender.user : Sender.model,
      );
    }).toList();
  }

  Future<List<Map<String, dynamic>>> fetchConversationSummaries() async {
    final snapshot = await _conversationRef
        .orderBy(Constants.fieldStartedAt, descending: true)
        .get();

    final List<Map<String, dynamic>> summaries = [];

    for (final doc in snapshot.docs) {
      final convoId = doc.id;

      final messageSnapshot = await _conversationRef
          .doc(convoId)
          .collection(Constants.messagesCollection)
          .orderBy(Constants.fieldStartedAt, descending: true)
          .limit(1)
          .get();

      String title = 'No messages yet';

      if (messageSnapshot.docs.isNotEmpty) {
        final data = messageSnapshot.docs.first.data();
        if (data[Constants.fieldText] != null && data[Constants.fieldText].toString().trim().isNotEmpty) {
          title = data[Constants.fieldText];
        }
      }

      summaries.add({
        Constants.id: convoId,

        Constants.fieldStartedAt: doc[Constants.fieldStartedAt],
        Constants.fieldText: title,
      });
      summaries.removeWhere((e)=>e.containsValue("No messages yet"));
    }

    return summaries;
  }

  Future<void> deleteConversation(String conversationId) async {

    final messagesRef = _conversationRef
        .doc(conversationId)
        .collection(Constants.messagesCollection);

    final messagesSnapshot = await messagesRef.get();
    for (final doc in messagesSnapshot.docs) {
      await doc.reference.delete();
    }

    await _conversationRef
        .doc(conversationId)
        .delete();
  }

}