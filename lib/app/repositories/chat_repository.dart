import 'dart:io';

import '../models/chat_model.dart';
import '../models/message_model.dart';

import 'dart:async';
import 'dart:io';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  Future<void> addUserInfo(userData) async {
    // Firebase removed - method no longer available
    throw UnimplementedError("Firebase has been removed from this app");
  }

  getUserInfo(String token) async {
    // Firebase removed - method no longer available
    throw UnimplementedError("Firebase has been removed from this app");
  }

  searchByName(String searchField) {
    // Firebase removed - method no longer available
    throw UnimplementedError("Firebase has been removed from this app");
  }

  // Create Message
  Future<void> createMessage(Message message) {
    // Firebase removed - method no longer available
    throw UnimplementedError("Firebase has been removed from this app");
  }

  // to remove message from firebase
  Future<void> deleteMessage(Message message) {
    // Firebase removed - method no longer available
    throw UnimplementedError("Firebase has been removed from this app");
  }

  Stream<dynamic> getUserMessages(String userId, {perPage = 10}) {
    // Firebase removed - method no longer available
    return Stream.empty();
  }

  Future<Message> getMessage(Message message) {
    // Firebase removed - method no longer available
    throw UnimplementedError("Firebase has been removed from this app");
  }

  Stream<dynamic> getUserMessagesStartAt(String userId, dynamic lastDocument, {perPage = 10}) {
    // Firebase removed - method no longer available
    return Stream.empty();
  }

  Stream<List<Chat>> getChats(Message message) {
    // Firebase removed - method no longer available
    return Stream.value(<Chat>[]);
  }

  Future<void> addMessage(Message message, Chat chat) async {
    // Firebase removed - method no longer available
    throw UnimplementedError("Firebase has been removed from this app");
  }

  Future<void> updateMessage(String messageId, Map<String, dynamic> message) {
    // Firebase removed - method no longer available
    throw UnimplementedError("Firebase has been removed from this app");
  }

  Future<String> uploadFile(File _imageFile) async {
    // Firebase removed - method no longer available
    throw UnimplementedError("Firebase has been removed from this app");
  }
}
