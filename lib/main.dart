import 'dart:convert';
import 'package:cda_members/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(
  new MaterialApp(
    home: new CDAStart()
  )
);

enum AppBarBehavior { normal, pinned, floating, snapping }

class CDAStart extends StatefulWidget {
  @override
  _CDAStartState createState() => new _CDAStartState();
}

class _CDAStartState extends State<CDAStart> with SingleTickerProviderStateMixin {

  Map members;
  List<Member> memberList = new List();

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  _loadMembers()async {
    var url = "https://codingdojo-79fd2.firebaseio.com/members.json";
    var httpClient = createHttpClient();
    var response = await httpClient.get(url);
    print('response'+ response.body);
    setState((){
      members = jsonCodec.decode(response.body);
    });

    for(String member in members.keys){
      print('Disponibilities: ${members[member].disponibilities}');
      memberList.add(new Member(members[member].beltColor, members[member].id, members[member].name, members[member].photoUri));
    }

    print('members.len='+ members.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: members == null ? 0 : members.length,
          itemBuilder: (BuildContext context, int index) {
            return new Row(
              children: <Widget>[
                new CircleAvatar(
                  radius: 30.0,
                  child: new ClipOval(
                    child: new Image.network(
                      memberList[index].photoUri,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

const jsonCodec = const JsonCodec(reviver: _reviver);

_reviver(key, value) {
  if(key != null && value is Map && key.contains("-")){
    return new Member.fromJson(value);
  }
  return value;
}
