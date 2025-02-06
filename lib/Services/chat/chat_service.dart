import 'package:chat_app1/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String,dynamic>>> getUserStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
       return snapshot.docs.map((doc){
         //go through each individual
         final user = doc.data();
         //return the user
         return user;
       }).toList();
    });
  }


  Future<void> sendMessage(String receiverId, message) async {

    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //newMessage
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId,receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore.collection("ChatRoom").doc(chatRoomId).collection("Messages").add(newMessage.toMap());

  }

  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("Messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

}