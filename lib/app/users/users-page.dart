import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mozz_chat/api/api.dart';
import 'package:mozz_chat/app/chat/chat-page.dart';
import 'package:mozz_chat/core/helper.dart';
import 'package:mozz_chat/model/message.dart';
import 'package:mozz_chat/model/userModel.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<UserModel> list = [];
  Message? _message;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: APIs.firestore.collection("users").snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                List<UserModel> list =
                    data?.map((e) => UserModel.fromJson(e.data())).toList() ??
                        [];
                   

                return Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var res = list[index];
                         String fullName = res.name.trim();
                         print(res.name);
                    // int random = Random(3);
                    List<String> names = fullName.split(' ');
                    
                    // Get the first letters of the first and last names
                    String firstLetterFirstName = names.isNotEmpty ? names[0][0].toUpperCase() : '';
                    String firstLetterLastName = names.length > 1 ? names.last[0].toUpperCase() : '';
                        return StreamBuilder(
                            stream: APIs.getLastMessage(res),
                            builder: (context, snapshot) {
                              final data = snapshot.data?.docs;
                              final list = data
                                      ?.map((e) => Message.fromJson(e.data()))
                                      .toList() ??
                                  [];
                              if (list.isNotEmpty) _message = list[0];
                              return Container(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ChatPage(
                                        data: res,
                                      );
                                    }));
                                  },
                                  leading: res.image != ""
                                      ? CircleAvatar(
                                        maxRadius: 25,
                                          backgroundImage:
                                              NetworkImage(res.image),
                                        )
                                      : CircleAvatar(
                                        maxRadius: 25,
                                        backgroundColor:  Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                          child: Text(firstLetterFirstName+firstLetterLastName, 
                                          style: TextStyle(color: Colors.white,fontSize: 20),),
                                        ),
                                  title: Text('${res.name}'),
                                  subtitle: Text(
                                      _message != null
                                          ?  _message?.fromId == APIs.user.uid ? "Вы: ${_message!.msg}" : _message!.msg
                                          : res.about,
                                      maxLines: 1),
                                  trailing: _message == null
                                      ? null 
                                      : _message!.read.isEmpty &&
                                              _message!.fromId != APIs.user.uid
                                          ?

                                          Container(
                                              width: 15,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                  color: Colors
                                                      .greenAccent.shade400,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            )
                                          :

                                          Text(
                                              MyDateUtil.getLastMessageTime(
                                                  context: context,
                                                  time: _message!.sent),
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            ),
                                ),
                              );
                            });
                      }),
                );
            }
          }),
    );
  }
}
