// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mozz_chat/api/api.dart';
// import 'package:mozz_chat/core/helper.dart';
// import 'package:mozz_chat/model/message.dart';
// import 'package:mozz_chat/model/userModel.dart';


// //card to represent a single user in home screen
// class ChatUserCard extends StatefulWidget {
//   final UserModel user;

//   const ChatUserCard({super.key, required this.user});

//   @override
//   State<ChatUserCard> createState() => _ChatUserCardState();
// }

// class _ChatUserCardState extends State<ChatUserCard> {
//   //last message info (if null --> no message)
//   Message? _message;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//       // color: Colors.blue.shade100,
//       elevation: 0.5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: InkWell(
//           onTap: () {
//             //for navigating to chat screen
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (_) => ChatScreen(user: widget.user)));
//           },
//           child: StreamBuilder(
//             stream: APIs.getLastMessage(widget.user),
//             builder: (context, snapshot) {
//               final data = snapshot.data?.docs;
//               final list =
//                   data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
//               if (list.isNotEmpty) _message = list[0];

//               return ListTile(
//                 //user profile picture
//                 leading: InkWell(
                  
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(50),
//                     child: CachedNetworkImage(
//                       width: 50,
//                       height: 50,
//                       imageUrl: widget.user.image,
//                       errorWidget: (context, url, error) => const CircleAvatar(
//                           child: Icon(CupertinoIcons.person)),
//                     ),
//                   ),
//                 ),

//                 //user name
//                 title: Text(widget.user.name),

//                 //last message
//                 subtitle: Text(
//                     _message != null
//                         ? _message!.type == Type.image
//                             ? 'image'
//                             : _message!.msg
//                         : widget.user.about,
//                     maxLines: 1),

//                 //last message time
//                 trailing: _message == null
//                     ? null //show nothing when no message is sent
//                     : _message!.read.isEmpty &&
//                             _message!.fromId != APIs.user.uid
//                         ?
//                         //show for unread message
//                         Container(
//                             width: 15,
//                             height: 15,
//                             decoration: BoxDecoration(
//                                 color: Colors.greenAccent.shade400,
//                                 borderRadius: BorderRadius.circular(10)),
//                           )
//                         :
//                         //message sent time
//                         Text(
//                             MyDateUtil.getLastMessageTime(
//                                 context: context, time: _message!.sent),
//                             style: const TextStyle(color: Colors.black54),
//                           ),
//               );
//             },
//           )),
//     );
//   }
// }