import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetailPage extends StatelessWidget {
  final DocumentSnapshot post;

  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    final title = post['title'];
    final body = post['body'];
    final authorEmail = post['authorEmail'];
    final postDate = post['timestamp'] != null
        ? (post['timestamp'] as Timestamp).toDate()
        : DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'By: $authorEmail\nOn: $postDate',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              body,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
