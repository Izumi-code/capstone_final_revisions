// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class AgritechInformation extends StatefulWidget {
//   @override
//   _AgritechInformationState createState() => _AgritechInformationState();
// }

// class _AgritechInformationState extends State<AgritechInformation> {
//   List<dynamic> newsArticles = [];
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: false);
//   int page = 1; // Initialize page number
//   final int pageSize = 100; // Number of articles per page

//   @override
//   void initState() {
//     super.initState();
//     fetchNews();
//   }

//   Future<void> fetchNews() async {
//     final apiKey =
//         '6cae84d544154934bb2aee256841dae2'; // Replace with your actual API key
//     final apiUrl =
//         'https://newsapi.org/v2/everything?q="agriculture"&"agrikultura"&"DOA"&"department of agriculture"&"rice"&"farm"&"livestock"&sortBy=relevancy&apiKey=$apiKey&page=$page&pageSize=$pageSize'; // Add page and pageSize parameters

//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final result = json.decode(response.body);
//         setState(() {
//           if (result['articles'].isNotEmpty) {
//             newsArticles.addAll(result['articles']);
//             page++; // Increment page number
//           }
//         });
//       } else {
//         print('Failed to load news. Status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error fetching news: $e');
//     }
//   }

//   void _navigateToNewsDetail(dynamic article) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NewsDetailPage(article: article),
//       ),
//     );
//   }

//   Future<void> _onRefresh() async {
//     setState(() {
//       page = 1; // Reset page number
//       newsArticles.clear(); // Clear the existing articles
//     });
//     await fetchNews();
//     _refreshController.refreshCompleted();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Agriculture News"),
//       ),
//       body: SmartRefresher(
//         controller: _refreshController,
//         enablePullDown: true,
//         onRefresh: () => _onRefresh(),
//         child: ListView.builder(
//           itemCount: newsArticles.length,
//           itemBuilder: (BuildContext context, int index) {
//             final article = newsArticles[index];
//             return GestureDetector(
//               onTap: () => _navigateToNewsDetail(article),
//               child: Card(
//                 elevation: 3,
//                 margin: EdgeInsets.all(8),
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       article['urlToImage'] != null
//                           ? Image.network(
//                               article['urlToImage'],
//                               width: 120,
//                               height: 120,
//                               fit: BoxFit.cover,
//                             )
//                           : Container(
//                               width: 120,
//                               height: 120,
//                               color: Colors.grey,
//                             ),
//                       SizedBox(height: 12),
//                       Text(
//                         article['title'] ?? '',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         article['description'] ?? '',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         "Source: ${article['source']['name'] ?? 'Unknown'}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "Published At: ${article['publishedAt'] ?? 'N/A'}",
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Text("Content: ${article['content'] ?? 'N/A'}",
//                           style: TextStyle(
//                             fontSize: 18,
//                           ))
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class NewsDetailPage extends StatelessWidget {
//   final dynamic article;

//   NewsDetailPage({required this.article});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("News Details"),
//       ),
//       body: WebView(
//         initialUrl: article['url'],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: AgritechInformation(),
//   ));
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AgritechInformation extends StatefulWidget {
  @override
  _AgritechInformationState createState() => _AgritechInformationState();
}

class _AgritechInformationState extends State<AgritechInformation> {
  List<dynamic> newsArticles = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int page = 1; // Initialize page number
  final int pageSize = 100; // Number of articles per page
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey =
        '6cae84d544154934bb2aee256841dae2'; // Replace with your actual API key
    final apiUrl =
        'https://newsapi.org/v2/everything?qInTitle=agriculture&language=en&sortBy=popularity&apiKey=$apiKey&page=$page&pageSize=$pageSize'; // Add page and pageSize parameters

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() {
          if (result['articles'].isNotEmpty) {
            newsArticles.addAll(result['articles']);
            page++; // Increment page number
          }
        });
      } else {
        print('Failed to load news. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      page = 1; // Reset page number
      newsArticles.clear(); // Clear the existing articles
    });
    await fetchNews();
    _refreshController.refreshCompleted();
  }

  void _searchNews(String query) async {
    if (query.isNotEmpty) {
      // Clear existing articles when searching
      setState(() {
        newsArticles.clear();
      });

      final apiKey = '6cae84d544154934bb2aee256841dae2';
      final apiUrl =
          'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

      try {
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          setState(() {
            if (result['articles'].isNotEmpty) {
              newsArticles.addAll(result['articles']);
            }
          });
        } else {
          print('Failed to load news. Status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Error fetching news: $e');
      }
    }
  }

  void _navigateToNewsDetail(dynamic article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Agriculture News"),
      //   backgroundColor: Colors.green,
      //   centerTitle: true, // Center the title
      // ),
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        leading: IconButton(
          icon: Image.asset(
            'assets/images/newimage/agrosense.png', // Replace with the actual path to your custom icon
            width: 30, // Adjust the width as needed
            height: 30, // Adjust the height as needed
            // color: Colors.white,
          ),
          onPressed: () {
            // Add functionality when the custom icon is pressed
          },
        ),
        title: Text('AgroSense'), // Customize the app bar title
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search News',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searchNews(_searchController.text);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                onRefresh: () => _onRefresh(),
                child: ListView.builder(
                  itemCount: newsArticles.length,
                  itemBuilder: (BuildContext context, int index) {
                    final article = newsArticles[index];
                    return GestureDetector(
                      onTap: () => _navigateToNewsDetail(article),
                      child: Card(
                        elevation: 3,
                        margin: EdgeInsets.all(8),
                        color: Colors.lightGreen[50],
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              article['urlToImage'] != null
                                  ? Image.network(
                                      article['urlToImage'],
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: 200,
                                      color: Colors.grey,
                                    ),
                              SizedBox(height: 12),
                              Text(
                                article['title'] ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.green[700],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                article['description'] ?? '',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Source: ${article['source']['name'] ?? 'Unknown'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.green[700],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Published At: ${article['publishedAt'] ?? 'N/A'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green[700],
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Content: ${article['content'] ?? 'N/A'}",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final dynamic article;

  NewsDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Details"),
        backgroundColor: Colors.green,
      ),
      body: WebView(
        initialUrl: article['url'],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AgritechInformation(),
  ));
}
