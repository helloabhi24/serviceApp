
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:service/main.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {

//     streamChatIntialize()async{
//      final client = StreamChatClient(apiKey , logLevel: Level.INFO);
//    await client.connectUser(
//     User(id: 'tutorial-flutter'),
//     userToken,
//   );
//   final channel = client.channel('messaging', id: 'flutterdevs');
//    await channel.watch();
//   }

//    @override
//   void initState() async{
//    await  streamChatIntialize();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }