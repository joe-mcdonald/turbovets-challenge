import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/message_bubble.dart';
import 'package:flutter_app/widgets/typing_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Message {
  final String text;
  final DateTime timestamp;
  final bool isUser;

  Message({required this.text, required this.timestamp, required this.isUser});

  // Convert Message to JSON to save in shared preferences
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isUser': isUser,
    };
  }

  // Convert JSON to Message object
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
      isUser: json['isUser'],
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  Timer? _typingTimer;

  final List<String> _agentReplies = [
    "Hi! How can I assist you today?",
    "Let me look into that, please wait a moment.",
    "Thank you for your patience, I'll get back to you shortly.",
    "Can you please provide more details?",
    "I'm here to help with any questions you have.",
    "Your request has been received!",
    "I'll get back to you shortly!",
    "Is there anything else I can assist you with?",
    "Thank you for reaching out.",
    "I'm glad to assist you.",
    "Ok, noted.",
    "Anything else?",
  ];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    // Cancel any ongoing typing timer and dispose controllers
    _typingTimer?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getStringList('messages') ?? [];

    setState(() {
      _messages.clear();
      for (String messageJson in messagesJson) {
        final Map<String, dynamic> messageMap = jsonDecode(messageJson);
        _messages.add(Message.fromJson(messageMap));
      }
    });

    await Future.delayed(const Duration(milliseconds: 100));

    // scroll to bottom after loading messages
    if (mounted && _scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // Save messages to shared preferences
  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> messagesJson =
        _messages.map((message) {
          return json.encode(message.toJson());
        }).toList();

    await prefs.setStringList('messages', messagesJson);
  }

  // Send and handle agent reply
  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        Message(text: text, timestamp: DateTime.now(), isUser: true),
      );
    });

    _controller.clear();
    _saveMessages();
    _scrollToBottom();

    // Simulate delayed response from agent
    Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isTyping = true;
        });
        _scrollToBottom();

        final reply = (_agentReplies..shuffle()).first;
        final delayMs = (reply.length * 40);

        _typingTimer = Timer(Duration(milliseconds: delayMs), () {
          if (mounted) {
            setState(() {
              _isTyping = false;
              _messages.add(
                Message(text: reply, timestamp: DateTime.now(), isUser: false),
              );
            });
            _saveMessages();
            _scrollToBottom();
          }
        });
      }
    });
  }

  // Scroll function
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 250,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages"), elevation: 2),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    return TypingIndicator(); // Show typing indicator
                  }
                  return MessageBubble(
                    text: _messages[index].text,
                    isUser: _messages[index].isUser,
                    timestamp: _messages[index].timestamp,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: _sendMessage,
                      decoration: const InputDecoration(
                        hintText: "Type your message here",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _sendMessage(_controller.text),
                    icon: Icon(
                      CupertinoIcons.arrow_up_circle_fill,
                      color: Colors.blueAccent,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
