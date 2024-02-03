import 'dart:developer';
import 'dart:io';

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozz_chat/api/api.dart';
import 'package:mozz_chat/app/chat/message-card.dart';
import 'package:mozz_chat/core/helper.dart';
import 'package:mozz_chat/model/message.dart';
import 'package:mozz_chat/model/userModel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.data});

  final UserModel data;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> _list = [];
  bool _showEmoji = false, _isUploading = false;
   final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.arrow_back),
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(),
      ),
      body: Column(
        children: [
           Expanded(
                  child: StreamBuilder(
                    stream: APIs.getAllMessages(widget.data),
                    builder: (context, snapshot) {
                      
                      switch (snapshot.connectionState) {
                        //if data is loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const SizedBox();

                        //if some or all data is loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _list = data
                                  ?.map((e) => Message.fromJson(e.data()))
                                  .toList() ??
                              [];

                          if (_list.isNotEmpty) {
                            return ListView.builder(
                                reverse: true,
                                itemCount: _list.length,
                                padding: EdgeInsets.only(top: 10),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return MessageCard(message: _list[index]);
                                });
                          } else {
                            return const Center(
                              child: Text('Привет 👋',
                                  style: TextStyle(fontSize: 20)),
                            );
                          }
                      }
                    },
                  ),
                ),
          _chatInput(),
        ],
      ),
    );
  }
                         
  Widget _appBar() {
    String fullName = widget.data.name.trim();

List<String> names = fullName.split(' ');
                    
                    // Get the first letters of the first and last names
                    String firstLetterFirstName = names.isNotEmpty ? names[0][0].toUpperCase() : '';
                    String firstLetterLastName = names.length > 1 ? names.last[0].toUpperCase() : '';
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: StreamBuilder(
        stream: APIs.getUserInfo(widget.data),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];

          return Row(
            children: [
              //back button
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black54)),

              //user profile picture
             
              widget.data.image != "" ? CircleAvatar(
                                        maxRadius: 25,
                                          backgroundImage:
                                              NetworkImage(widget.data.image),
                                        )
                                      : CircleAvatar(
                                        maxRadius: 25,
                                        backgroundColor:  Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                          child: Text(firstLetterFirstName+firstLetterLastName, 
                                          style: TextStyle(color: Colors.white,fontSize: 20),),
                                        ),

              //for adding some space
              const SizedBox(width: 10),

              //user name & last seen time
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //user name
                  Text(list.isNotEmpty ? list[0].name : widget.data.name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500)),

                  //for adding some space
                  const SizedBox(height: 2),

                  Text(
                      list.isNotEmpty
                          ? list[0].isOnline
                              ? 'Online'
                              : MyDateUtil.getLastActiveTime(
                                  context: context,
                                  lastActive: list[0].lastActive)
                          : MyDateUtil.getLastActiveTime(
                              context: context,
                              lastActive: widget.data.lastActive),
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              )
            ],
          );
        },
      ),
    );
  }


   Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: 1),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 70);

                        // uploading & sending image one by one
                        for (var i in images) {
                          log('Image Path: ${i.path}');
                          setState(() => _isUploading = true);
                          await APIs.sendChatImage(widget.data, File(i.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.image,
                          color: Colors.blueAccent, size: 26)),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Сообщение...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  //adding some space
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                if (_list.isEmpty) {
                  //on first message (add user to my_user collection of chat user)
                  APIs.sendFirstMessage(
                      widget.data, _textController.text, Type.text);
                } else {
                  //simply send message
                  APIs.sendMessage(
                      widget.data, _textController.text, Type.text);
                }
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
          
          ]));
   }


}
