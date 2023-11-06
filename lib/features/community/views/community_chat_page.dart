import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/colours.dart';

// import '../../auth/controller/auth_controller.dart';

// https://pub.dev/packages/chatview2/install
// https://flutterawesome.com/a-flutter-package-that-allows-you-to-integrate-chat-view-with-highly-customization-options-2/

class CommunityChatPage extends ConsumerStatefulWidget {
  final String communityId;
  const CommunityChatPage({super.key, required this.communityId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommunityChatPageState();
}

class _CommunityChatPageState extends ConsumerState<CommunityChatPage> {
  List<Map<String, String>> messages = [
    {"text": "Hello, everyone!", "sender": "me"},
    {"text": "How's it going?", "sender": "me"},
    {"text": "This is a sample message.", "sender": "me"},
    {
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "sender": "other"
    },
    {
      "text":
          "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "sender": "other"
    },
    {
      "text":
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
      "sender": "me"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.of(context).size;
    // final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Chat Room",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: TColor.white,
      body: Column(
        children: [
          // Display the chat messages
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message["sender"] == "me";

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.blue
                          : Colors.green, // Customize message bubble color
                      borderRadius: isMe
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )
                          : const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                    ),
                    child: Text(
                      message["text"]!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Add the sent message to the list of messages
                    setState(() {
                      messages.add({"text": "New message", "sender": "me"});
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
