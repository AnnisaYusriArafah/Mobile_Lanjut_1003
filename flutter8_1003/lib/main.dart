import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var faker = new Faker();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Extract widget"),
        ),
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index){
            return ChatItem(
            imageUrl: "https://picsum.photos/id/$index/200/300",
            title: faker.person.name(),
            subtitle: faker.lorem.sentence(),
            );
        }
          //children: [
          //   ChatItem(
          //     imageUrl: "https://picsum.photos/id/1/200/300",
          //     title: faker.person.name(),
          //     subtitle: faker.lorem.sentence()
          //     ),
          //   ChatItem(
          //       imageUrl: "https://picsum.photos/id/2/200/300",
          //       title: faker.person.name(),
          //       subtitle: faker.lorem.sentence()
          //   ),
          //   ChatItem(
          //       imageUrl: "https://picsum.photos/id/3/200/300",
          //       title: faker.person.name(),
          //       subtitle: faker.lorem.sentence()
          //   ),
          //   ChatItem(
          //       imageUrl: "https://picsum.photos/id/4/200/300",
          //       title: faker.person.name(),
          //       subtitle: faker.lorem.sentence()
          //   ),
          // ],
            // ListTile(
            //   leading: CircleAvatar(),
            //   title: Text("Nama"),
            //   subtitle: Text("subtitle"),
            //   trailing: Text("10:00 PM"),
            // ),
            // ListTile(
            //   leading: CircleAvatar(),
            //   title: Text("Nama"),
            //   subtitle: Text("subtitle"),
            //   trailing: Text("10:00 PM"),
            // ),

        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  ChatItem({this.imageUrl= "", this.title= "", this.subtitle= ""});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text("10:00 PM"),
    );
  }
}
