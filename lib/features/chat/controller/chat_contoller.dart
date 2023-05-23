import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:uuid/uuid.dart';
//import 'package:whatsapp_flutter/common/enums/message_enum.dart';
//import 'package:whatsapp_flutter/common/providers/message_reply_provider.dart';
//import 'package:whatsapp_flutter/models/chat_contact.dart';
//import 'package:whatsapp_flutter/models/group.dart';
//import 'package:whatsapp_flutter/models/message.dart';

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
}
