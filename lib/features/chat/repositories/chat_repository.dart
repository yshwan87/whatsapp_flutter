import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/utils/utils.dart';
import 'package:whatsapp_flutter/models/chat_contact.dart';
import 'package:whatsapp_flutter/models/user_model.dart';
import 'package:uuid/uuid.dart';
//import 'package:whatsapp_flutter/common/providers/message_reply_provider.dart';
//import 'package:whatsapp_flutter/models/group.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
        senderUser,
        recieverUserData,
        text,
        timeSent,
        recieverUserId,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel? recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
// users -> reciever user id => chats -> current user id -> set data
    var recieverChatContact = ChatContact(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore.collection('users').doc(recieverUserId).collection('chats').doc(auth.currentUser!.uid).set(
          recieverChatContact.toMap(),
        );
    // users -> current user id  => chats -> reciever user id -> set data
    var senderChatContact = ChatContact(
      name: recieverUserData!.name,
      profilePic: recieverUserData.profilePic,
      contactId: recieverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore.collection('users').doc(auth.currentUser!.uid).collection('chats').doc(recieverUserId).set(
          senderChatContact.toMap(),
        );
  }
}
