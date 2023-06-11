import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testingflutter/components/my_textfield.dart';
import 'package:testingflutter/components/wall_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // text controller

  final textController = TextEditingController();

// signout

void signOut() {
  FirebaseAuth.instance.signOut();
}

// post mewssage
void postMessage() {
 // only post if hterer is something in the textfield
if (textController.text.isNotEmpty) {
  // store in firebase
  FirebaseFirestore.instance.collection("User Posts").add({
    'UserEmail': currentUser.email,
    'Message': textController.text,
    'TimeStamp': Timestamp.now(),
  });
}

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Social feed"),
      actions: [
      IconButton(
        onPressed: signOut,
        icon: Icon(Icons.logout),
        ),
      ],
      ),

      body: Center(
        child: Column(
        children: [

              // feed
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy("TimeStamp",
                   descending: false,
                  
                  )
                  .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // get the message
                          final post = snapshot.data!.docs[index];
                          return WallPost(
                            message: post['Message'],
                             user: post['UserEmail'],

                          );
                        },
                        );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error${snapshot.error}'),
                      );
                    }
                    return const Center(child: CircularProgressIndicator(),
                    );
                  },
                ),
                ),
      
              // post messages
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
              
                    Expanded(
                      child: MyTextField(
                        controller: textController,
                        hintText: 'Write a new post to add to the feed',
                        obscureText: false,
                      ),
                      ),
              
                      // post button
              
                      IconButton(
                        onPressed: postMessage,
                        icon: const Icon(Icons.arrow_circle_up),
                        )
                      
              
              
              
                  ],
                  ),
              ),

      
              // logged in as
              Text("Logged in as: " + currentUser.email!),
      
        ],
        ),
      ),
    );
  }
}
