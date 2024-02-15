// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final User? user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     String greeting = "Welcome to the Community";

//     if (user != null) {
//       if (user!.displayName != null && user!.displayName!.isNotEmpty) {
//         greeting = "Hello, ${user!.displayName}!";
//       } else {
//         greeting = "Hello, ${user!.email}!";
//       }
//     }

//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text("Community"),
//       //   backgroundColor: Colors.green,
//       //   centerTitle: true, // Center the title
//       // ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 greeting,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             CommunityPage(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController bodyController = TextEditingController();
//   TextEditingController commentController = TextEditingController();

//   final CollectionReference postsCollection =
//       FirebaseFirestore.instance.collection('community_posts');
//   final CollectionReference commentsCollection =
//       FirebaseFirestore.instance.collection('comments');

//   User? user = FirebaseAuth.instance.currentUser;

//   Widget _buildPostCommentsCount(String postId) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('community_posts')
//           .doc(postId)
//           .collection('comments')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return SizedBox.shrink();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           final commentCount = snapshot.data?.docs.length ?? 0;
//           return Text('$commentCount Comments');
//         }
//       },
//     );
//   }

//   void _postCommunityPost(String title, String body) async {
//     if (title.isEmpty || body.isEmpty) {
//       // Handle validation, e.g., show an error message
//       return;
//     }

//     // Add the post to Firestore with author information
//     await postsCollection.add({
//       'title': title,
//       'body': body,
//       'timestamp': FieldValue.serverTimestamp(),
//       'authorName': user!.displayName, // Include author's display name
//       'authorEmail': user!.email, // Include author's email
//       // Add more author information as necessary
//     });
//   }

//   void _postComment(String postId, String text) async {
//     if (text.isEmpty) {
//       return;
//     }

//     // Reference to the specific post's comments subcollection
//     final commentsCollection = FirebaseFirestore.instance
//         .collection('community_posts')
//         .doc(postId)
//         .collection('comments');

//     await commentsCollection.add({
//       'text': text,
//       'authorName': user!.displayName,
//       'authorEmail': user!.email,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }

//   Future<void> _showPostDialog() async {
//     String title = '';
//     String body = '';

//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Create a Post'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//                 onChanged: (value) {
//                   title = value;
//                 },
//               ),
//               TextField(
//                 controller: bodyController,
//                 decoration: InputDecoration(labelText: 'Body'),
//                 onChanged: (value) {
//                   body = value;
//                 },
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Post'),
//               onPressed: () {
//                 _postCommunityPost(title, body);
//                 titleController.clear();
//                 bodyController.clear();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _showCommentDialog(String postId) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return CommentDialog(postId: postId, user: user!);
//       },
//     );
//   }

//   Future<void> _editPost(
//       String postId, String currentTitle, String currentBody) async {
//     String updatedTitle = currentTitle;
//     String updatedBody = currentBody;

//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Post'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: TextEditingController(text: currentTitle),
//                 decoration: InputDecoration(labelText: 'Title'),
//                 onChanged: (value) {
//                   updatedTitle = value;
//                 },
//               ),
//               TextField(
//                 controller: TextEditingController(text: currentBody),
//                 decoration: InputDecoration(labelText: 'Body'),
//                 onChanged: (value) {
//                   updatedBody = value;
//                 },
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Update'),
//               onPressed: () {
//                 _updatePost(postId, updatedTitle, updatedBody);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _updatePost(
//       String postId, String updatedTitle, String updatedBody) async {
//     await postsCollection.doc(postId).update({
//       'title': updatedTitle,
//       'body': updatedBody,
//     });
//   }

//   Future<void> _deletePost(String postId) async {
//     await postsCollection.doc(postId).delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         InkWell(
//           onTap: _showPostDialog,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'assets/images/newimage/new-post.png',
//               width: 100,
//               height: 100,
//             ),
//           ),
//         ),
//         SizedBox(height: 16),
//         StreamBuilder<QuerySnapshot>(
//           stream: postsCollection
//               .orderBy('timestamp', descending: true)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return Text('No posts available.');
//             } else {
//               return Column(
//                 children: snapshot.data!.docs.map((post) {
//                   final title = post['title'];
//                   final body = post['body'];
//                   final postId = post.id;
//                   final authorEmail = post['authorEmail'];
//                   final postDate = post['timestamp'] != null
//                       ? (post['timestamp'] as Timestamp).toDate()
//                       : DateTime.now();

//                   final isCurrentUserPost = user!.email == authorEmail;

//                   return Card(
//                     margin: EdgeInsets.all(16),
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Container(
//                       constraints: BoxConstraints(maxWidth: 600),
//                       decoration: BoxDecoration(
//                         color: Colors.lightGreen[100],
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (isCurrentUserPost)
//                               Padding(
//                                 padding: const EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   'Your Post',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               ),
//                             Text(
//                               title,
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 12),
//                             Text(
//                               'Posted by: $authorEmail',
//                               style:
//                                   TextStyle(fontSize: 14, color: Colors.grey),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'On $postDate',
//                               style:
//                                   TextStyle(fontSize: 14, color: Colors.grey),
//                             ),
//                             SizedBox(height: 16),
//                             Text(
//                               body,
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             SizedBox(height: 36),
//                             ElevatedButton.icon(
//                               onPressed: () => _showCommentDialog(postId),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.lightGreen[100],
//                               ),
//                               icon: Image.asset(
//                                 'assets/images/newimage/chat.png',
//                                 width: 50,
//                                 height: 50,
//                               ),
//                               label: Text('Comments',
//                                   style: TextStyle(color: Colors.black)),
//                             ),
//                             SizedBox(height: 16),
//                             _buildPostCommentsCount(postId),
//                             if (isCurrentUserPost)
//                               Row(
//                                 children: [
//                                   Spacer(),
//                                   ElevatedButton.icon(
//                                     onPressed: () =>
//                                         _editPost(postId, title, body),
//                                     style: ElevatedButton.styleFrom(
//                                       primary: Colors.orange,
//                                     ),
//                                     icon: Icon(Icons.edit),
//                                     label: Text('Edit'),
//                                   ),
//                                   SizedBox(width: 16),
//                                   ElevatedButton.icon(
//                                     onPressed: () => _deletePost(postId),
//                                     style: ElevatedButton.styleFrom(
//                                       primary: Colors.red,
//                                     ),
//                                     icon: Icon(Icons.delete),
//                                     label: Text('Delete'),
//                                   ),
//                                 ],
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// class CommentDialog extends StatefulWidget {
//   final String postId;
//   final User user;

//   CommentDialog({required this.postId, required this.user});

//   @override
//   _CommentDialogState createState() => _CommentDialogState();
// }

// class _CommentDialogState extends State<CommentDialog> {
//   TextEditingController commentController = TextEditingController();

//   void _postComment(String text) async {
//     if (text.isEmpty) {
//       return;
//     }

//     await FirebaseFirestore.instance
//         .collection('community_posts')
//         .doc(widget.postId)
//         .collection('comments')
//         .add({
//       'text': text,
//       'authorName': widget.user.displayName,
//       'authorEmail': widget.user.email,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }

//   void _deleteComment(String commentId) async {
//     await FirebaseFirestore.instance
//         .collection('community_posts')
//         .doc(widget.postId)
//         .collection('comments')
//         .doc(commentId)
//         .delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(16),
//         width: double.infinity,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Comments',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('community_posts')
//                     .doc(widget.postId)
//                     .collection('comments')
//                     .orderBy('timestamp', descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return Text('No comments available.');
//                   } else {
//                     return Expanded(
//                       child: ListView(
//                         shrinkWrap: true,
//                         children: snapshot.data!.docs.map((comment) {
//                           final commentId = comment.id;
//                           final text = comment['text'];
//                           final authorEmail = comment['authorEmail'];
//                           final commentDate = comment['timestamp'] != null
//                               ? (comment['timestamp'] as Timestamp).toDate()
//                               : DateTime.now();
//                           final isCurrentUserComment =
//                               widget.user.email == authorEmail;

//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 isCurrentUserComment
//                                     ? 'Your Comment'
//                                     : 'Comment',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color:
//                                       isCurrentUserComment ? Colors.blue : null,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 text,
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Commented by: $authorEmail on $commentDate',
//                                 style:
//                                     TextStyle(fontSize: 14, color: Colors.grey),
//                               ),
//                               SizedBox(height: 16),
//                               if (isCurrentUserComment)
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         _deleteComment(commentId);
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         primary: Colors.red,
//                                       ),
//                                       child: Text('Delete Comment'),
//                                     ),
//                                   ],
//                                 ),
//                               Divider(
//                                 thickness: 1,
//                                 color: Colors.grey,
//                               ),
//                               SizedBox(height: 16),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//             TextField(
//               controller: commentController,
//               decoration: InputDecoration(labelText: 'Add a Comment'),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   child: Text('Cancel'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _postComment(commentController.text);
//                     commentController.clear();
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Post Comment'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:capstone_project/pages/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String greeting = "Welcome to the Community";

    if (user != null) {
      if (user!.displayName != null && user!.displayName!.isNotEmpty) {
        greeting = "Hello, ${user!.displayName}!";
      } else {
        greeting = "Hello, ${user!.email}!";
      }
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Community"),
      //   backgroundColor: Colors.green,
      //   centerTitle: true, // Center the title
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                greeting,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            CommunityPage(),
          ],
        ),
      ),
    );
  }
}

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('community_posts');
  final CollectionReference commentsCollection =
      FirebaseFirestore.instance.collection('comments');

  User? user = FirebaseAuth.instance.currentUser;

  Widget _buildPostCommentsCount(String postId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('community_posts')
          .doc(postId)
          .collection('comments')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final commentCount = snapshot.data?.docs.length ?? 0;
          return Text('$commentCount Comments');
        }
      },
    );
  }

  void _postCommunityPost(String title, String body) async {
    if (title.isEmpty || body.isEmpty) {
      // Handle validation, e.g., show an error message
      return;
    }

    // Add the post to Firestore with author information
    await postsCollection.add({
      'title': title,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
      'authorName': user!.displayName, // Include author's display name
      'authorEmail': user!.email, // Include author's email
      // Add more author information as necessary
    });
  }

  void _postComment(String postId, String text) async {
    if (text.isEmpty) {
      return;
    }

    // Reference to the specific post's comments subcollection
    final commentsCollection = FirebaseFirestore.instance
        .collection('community_posts')
        .doc(postId)
        .collection('comments');

    await commentsCollection.add({
      'text': text,
      'authorName': user!.displayName,
      'authorEmail': user!.email,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _showPostDialog() async {
    String title = '';
    String body = '';

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create a Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(labelText: 'Body'),
                onChanged: (value) {
                  body = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Post'),
              onPressed: () {
                _postCommunityPost(title, body);
                titleController.clear();
                bodyController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCommentDialog(String postId) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CommentDialog(postId: postId, user: user!);
      },
    );
  }

  Future<void> _editPost(
      String postId, String currentTitle, String currentBody) async {
    String updatedTitle = currentTitle;
    String updatedBody = currentBody;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: TextEditingController(text: currentTitle),
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  updatedTitle = value;
                },
              ),
              TextField(
                controller: TextEditingController(text: currentBody),
                decoration: InputDecoration(labelText: 'Body'),
                onChanged: (value) {
                  updatedBody = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                _updatePost(postId, updatedTitle, updatedBody);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updatePost(
      String postId, String updatedTitle, String updatedBody) async {
    await postsCollection.doc(postId).update({
      'title': updatedTitle,
      'body': updatedBody,
    });
  }

  Future<void> _deletePost(String postId) async {
    await postsCollection.doc(postId).delete();
  }

  void _showPostDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailPage(post: post),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: _showPostDialog,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/newimage/new-post.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
        SizedBox(height: 16),
        StreamBuilder<QuerySnapshot>(
          stream: postsCollection
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('No posts available.');
            } else {
              return Column(
                children: snapshot.data!.docs.map((post) {
                  final title = post['title'];
                  final body = post['body'];
                  final postId = post.id;
                  final authorEmail = post['authorEmail'];
                  final postDate = post['timestamp'] != null
                      ? (post['timestamp'] as Timestamp).toDate()
                      : DateTime.now();
                  final isCurrentUserPost = user!.email == authorEmail;

                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'By: $authorEmail\nOn: $postDate',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.comment),
                          onPressed: () => _showCommentDialog(postId),
                        ),
                        onTap: () => _showPostDetail(post),
                      ),
                      if (isCurrentUserPost)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => _editPost(postId, title, body),
                              child: Text('Edit'),
                            ),
                            TextButton(
                              onPressed: () => _deletePost(postId),
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      Divider(),
                    ],
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
    );
  }
}

class CommentDialog extends StatefulWidget {
  final String postId;
  final User user;

  CommentDialog({required this.postId, required this.user});

  @override
  _CommentDialogState createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  TextEditingController commentController = TextEditingController();

  void _postComment(String text) async {
    if (text.isEmpty) {
      return;
    }

    await FirebaseFirestore.instance
        .collection('community_posts')
        .doc(widget.postId)
        .collection('comments')
        .add({
      'text': text,
      'authorName': widget.user.displayName,
      'authorEmail': widget.user.email,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void _deleteComment(String commentId) async {
    await FirebaseFirestore.instance
        .collection('community_posts')
        .doc(widget.postId)
        .collection('comments')
        .doc(commentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('community_posts')
                    .doc(widget.postId)
                    .collection('comments')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('No comments available.');
                  } else {
                    return Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((comment) {
                          final commentId = comment.id;
                          final text = comment['text'];
                          final authorEmail = comment['authorEmail'];
                          final commentDate = comment['timestamp'] != null
                              ? (comment['timestamp'] as Timestamp).toDate()
                              : DateTime.now();
                          final isCurrentUserComment =
                              widget.user.email == authorEmail;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isCurrentUserComment
                                    ? 'Your Comment'
                                    : 'Comment',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isCurrentUserComment ? Colors.blue : null,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                text,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Commented by: $authorEmail on $commentDate',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              SizedBox(height: 16),
                              if (isCurrentUserComment)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _deleteComment(commentId);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                      child: Text('Delete Comment'),
                                    ),
                                  ],
                                ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(labelText: 'Add a Comment'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    _postComment(commentController.text);
                    commentController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text('Post Comment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
