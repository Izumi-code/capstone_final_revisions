// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AdminPage extends StatefulWidget {
//   @override
//   _AdminPageState createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AdminPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   int _selectedIndex = 0;

//   void _logout(BuildContext context) async {
//     await _auth.signOut();
//     Navigator.pop(context); // Pop the admin page
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     Navigator.pop(context); // Close the drawer
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AgroSense Admin'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () => _logout(context),
//           ),
//         ],
//       ),
//       drawer: AdminDrawer(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Welcome Admin!'),
//             SizedBox(height: 20),
//             if (_selectedIndex == 0)
//               Text(
//                 'Registered Users',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             if (_selectedIndex == 1)
//               Text(
//                 'Community Posts',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             SizedBox(height: 10),
//             Expanded(
//               child: _selectedIndex == 0 ? UserList() : CommunityPosts(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AdminDrawer extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final int selectedIndex;
//   final void Function(int) onItemTapped;

//   AdminDrawer({
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   void _logout(BuildContext context) async {
//     await _auth.signOut();
//     Navigator.pop(context); // Pop the drawer
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Admin Options',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Registered Users'),
//             selected: selectedIndex == 0,
//             onTap: () => onItemTapped(0),
//           ),
//           ListTile(
//             title: Text('Community Posts'),
//             selected: selectedIndex == 1,
//             onTap: () => onItemTapped(1),
//           ),
//           // Divider(), // Add a divider for visual separation
//           // ListTile(
//           //   title: Text('Sign Out'),
//           //   onTap: () => _logout(context),
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class UserList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('users').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }

//         List<QueryDocumentSnapshot> users = snapshot.data!.docs;
//         users.removeWhere(
//             (user) => user['email'] == 'agrosensemoderator@gmail.com');

//         return Column(
//           children: [
//             Text('Total Users: ${users.length}'),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   var user = users[index];
//                   return ListTile(
//                     title: Text(user['email']),
//                     subtitle: Text(user['uid']),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class CommunityPosts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream:
//           FirebaseFirestore.instance.collection('community_posts').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }

//         List<QueryDocumentSnapshot> posts = snapshot.data!.docs;

//         return Column(
//           children: [
//             Text('Community Posts: ${posts.length}'),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: posts.length,
//                 itemBuilder: (context, index) {
//                   var post = posts[index];
//                   return CommunityPostTile(post: post);
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class CommunityPostTile extends StatelessWidget {
//   final QueryDocumentSnapshot post;

//   CommunityPostTile({required this.post});

//   Future<void> _deletePost(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Post'),
//           content: Text('Are you sure you want to delete this post?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Implement the logic to delete the post
//                 FirebaseFirestore.instance
//                     .collection('community_posts')
//                     .doc(post.id)
//                     .delete();
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Convert timestamp to DateTime
//     DateTime postDateTime = (post['timestamp'] as Timestamp).toDate();

//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       color: Colors.lightGreen[50], // Background color for better readability
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(
//               'Title: ${post['title']}',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[900],
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 5),
//                 Text(
//                   'Author: ${post['authorEmail']}',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontStyle: FontStyle.italic,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Created at: ${_formatDateTime(postDateTime)}',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Body: ${post['body']}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () => _deletePost(context),
//             ),
//           ),
//           // Display comments
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Divider(
//               color: Colors.green,
//               thickness: 2,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             'Comments:',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.green[900],
//             ),
//           ),
//           CommentList(postId: post.id),
//         ],
//       ),
//     );
//   }

//   // Helper function to format DateTime
//   String _formatDateTime(DateTime dateTime) {
//     return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
//   }
// }

// class CommentList extends StatelessWidget {
//   final String postId;

//   CommentList({required this.postId});

//   Future<void> _deleteComment(BuildContext context, String commentId) async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Comment'),
//           content: Text('Are you sure you want to delete this comment?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Implement the logic to delete the comment
//                 FirebaseFirestore.instance
//                     .collection('community_posts')
//                     .doc(postId)
//                     .collection('comments')
//                     .doc(commentId)
//                     .delete();
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('community_posts')
//           .doc(postId)
//           .collection('comments')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }

//         List<QueryDocumentSnapshot> comments = snapshot.data!.docs;

//         if (comments.isEmpty) {
//           return Text('No comments available.');
//         }

//         return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: comments.length,
//           itemBuilder: (context, index) {
//             var comment = comments[index];
//             // Convert comment timestamp to DateTime
//             DateTime commentDateTime =
//                 (comment['timestamp'] as Timestamp).toDate();

//             return ListTile(
//               title: Text(
//                 comment['text'],
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black87,
//                 ),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 5),
//                   Text(
//                     'Author: ${comment['authorEmail']}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontStyle: FontStyle.italic,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'Created at: ${_formatDateTime(commentDateTime)}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                 ],
//               ),
//               trailing: IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: () => _deleteComment(context, comment.id),
//               ),
//               // Add any other comment details you want to display
//             );
//           },
//         );
//       },
//     );
//   }

//   // Helper function to format DateTime
//   String _formatDateTime(DateTime dateTime) {
//     return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 1; // Set the default index to 1 for Community Posts

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pop(context); // Pop the admin page
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgroSense Admin'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      drawer: AdminDrawer(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome Admin!'),
            SizedBox(height: 20),
            if (_selectedIndex ==
                1) // Only display if the selected index is 1 (Community Posts)
              Text(
                'Community Posts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 10),
            Expanded(
              child: _selectedIndex == 1 ? CommunityPosts() : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final int selectedIndex;
  final void Function(int) onItemTapped;

  AdminDrawer({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pop(context); // Pop the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Admin Options',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Community Posts'),
            selected: selectedIndex == 1,
            onTap: () => onItemTapped(1),
          ),
        ],
      ),
    );
  }
}

class CommunityPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('community_posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<QueryDocumentSnapshot> posts = snapshot.data!.docs;

        return Column(
          children: [
            Text('Community Posts: ${posts.length}'),
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  var post = posts[index];
                  return CommunityPostTile(post: post);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class CommunityPostTile extends StatelessWidget {
  final QueryDocumentSnapshot post;

  CommunityPostTile({required this.post});

  Future<void> _deletePost(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Post'),
          content: Text('Are you sure you want to delete this post?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement the logic to delete the post
                FirebaseFirestore.instance
                    .collection('community_posts')
                    .doc(post.id)
                    .delete();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Convert timestamp to DateTime
    DateTime postDateTime = (post['timestamp'] as Timestamp).toDate();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.lightGreen[50], // Background color for better readability
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Title: ${post['title']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  'Author: ${post['authorEmail']}',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Created at: ${_formatDateTime(postDateTime)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Body: ${post['body']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deletePost(context),
            ),
          ),
          // Display comments
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Colors.green,
              thickness: 2,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Comments:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
          ),
          CommentList(postId: post.id),
        ],
      ),
    );
  }

  // Helper function to format DateTime
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}

class CommentList extends StatelessWidget {
  final String postId;

  CommentList({required this.postId});

  Future<void> _deleteComment(BuildContext context, String commentId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Comment'),
          content: Text('Are you sure you want to delete this comment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement the logic to delete the comment
                FirebaseFirestore.instance
                    .collection('community_posts')
                    .doc(postId)
                    .collection('comments')
                    .doc(commentId)
                    .delete();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('community_posts')
          .doc(postId)
          .collection('comments')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<QueryDocumentSnapshot> comments = snapshot.data!.docs;

        if (comments.isEmpty) {
          return Text('No comments available.');
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            var comment = comments[index];
            // Convert comment timestamp to DateTime
            DateTime commentDateTime =
                (comment['timestamp'] as Timestamp).toDate();

            return ListTile(
              title: Text(
                comment['text'],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Author: ${comment['authorEmail']}',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Created at: ${_formatDateTime(commentDateTime)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteComment(context, comment.id),
              ),
              // Add any other comment details you want to display
            );
          },
        );
      },
    );
  }

  // Helper function to format DateTime
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}
