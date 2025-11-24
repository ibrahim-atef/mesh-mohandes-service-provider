import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/ui.dart';
import '../../../models/chat_model.dart';
import '../../../models/message_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/chat_repository.dart';
import '../../../repositories/notification_repository.dart';
import '../../../services/auth_service.dart';

class MessagesController extends GetxController {
  final uploading = false.obs;
  var message = Message([]).obs;
  late ChatRepository _chatRepository;
  late NotificationRepository _notificationRepository;
  late AuthService _authService;
  var messages = <Message>[].obs;
  var chats = <Chat>[].obs;
  File? imageFile;
  Rx<dynamic> lastDocument = Rx<dynamic>(null);
  final isLoading = true.obs;
  final isDone = false.obs;
  ScrollController scrollController = ScrollController();
  final chatTextController = TextEditingController();

  MessagesController() {
    _chatRepository = new ChatRepository();
    _notificationRepository = new NotificationRepository();
    _authService = Get.find<AuthService>();
  }

  @override
  void onInit() async {
    // await createMessage(new Message([_authService.user.value], id: UniqueKey().toString(), name: 'Appliance Repair Company'));
    // await createMessage(new Message([_authService.user.value], id: UniqueKey().toString(), name: 'Shifting Home'));
    // await createMessage(new Message([_authService.user.value], id: UniqueKey().toString(), name: 'Pet Car Company'));
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        await listenForMessages();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    chatTextController.dispose();
  }

  Future createMessage(Message _message) async {
    _message.users.insert(0, _authService.user.value);
    _message.lastMessageTime = DateTime.now().millisecondsSinceEpoch;
    String? userId = _authService.user.value.id;
    _message.readByUsers = userId != null ? [userId] : [];

    message.value = _message;

    _chatRepository.createMessage(_message).then((value) {
      listenForChats();
    });
  }

  Future deleteMessage(Message _message) async {
    messages.remove(_message);
    await _chatRepository.deleteMessage(_message);
  }

  Future refreshMessages() async {
    messages.clear();
    lastDocument.value = null;
    await listenForMessages();
  }

  Future listenForMessages() async {
    isLoading.value = true;
    isDone.value = false;
    Stream<dynamic> _userMessages;
    String? userId = _authService.user.value.id;
    if (lastDocument.value == null) {
      if (userId != null) {
        _userMessages = _chatRepository.getUserMessages(userId);
      } else {
        return;
      }
    } else {
      if (userId != null && lastDocument.value != null) {
        _userMessages = _chatRepository.getUserMessagesStartAt(userId, lastDocument.value!);
      } else {
        return;
      }
    }
    _userMessages.listen((dynamic query) {
      // Firebase removed - this functionality is no longer available
      isDone.value = true;
      isLoading.value = false;
    });
  }

  listenForChats() async {
    message.value = await _chatRepository.getMessage(message.value);
    String? userId = _authService.user.value.id;
    if (userId != null) {
      message.value.readByUsers.add(userId);
    }
    _chatRepository.getChats(message.value).listen((event) {
      chats.assignAll(event);
    });
  }

  addMessage(Message _message, String text) {
    Chat _chat = new Chat(text, DateTime.now().millisecondsSinceEpoch, _authService.user.value.id, _authService.user.value);
    if (_message.id == null) {
      _message.id = UniqueKey().toString();
      createMessage(_message);
    }
    _message.lastMessage = text;
    _message.lastMessageTime = _chat.time;
    String? userId = _authService.user.value.id;
    if (userId != null) {
      _message.readByUsers = [userId];
    }
    uploading.value = false;
    _chatRepository.addMessage(_message, _chat).then((value) {}).then((value) {
      List<User> _users = [];
      _users.addAll(_message.users);
      String? currentUserId = _authService.user.value.id;
      if (currentUserId != null) {
        _users.removeWhere((element) => element.id == currentUserId);
        String? messageId = _message.id;
        if (messageId != null) {
          _notificationRepository.sendNotification(_users, _authService.user.value, "App\\Notifications\\NewMessage", text, messageId);
        }
      }
    });
  }

  Future getImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;

    pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }

    if (imageFile != null && pickedFile != null) {
      try {
        uploading.value = true;
        return await _chatRepository.uploadFile(imageFile!);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Please select an image file".tr));
    }
  }
}
