// class Crop {
//   final String name;
//   final String imagePath;
//   final String details;
//   final Map<String, String> topicContent; // Map to store topic-specific content

//   Crop({
//     required this.name,
//     required this.imagePath,
//     required this.details,
//     required this.topicContent,
//   });
// }

class Crop {
  final String name;
  final String imagePath;
  final String details;
  final Map<String, String> topicContent;
  final String youtubeVideoId;

  Crop({
    required this.name,
    required this.imagePath,
    required this.details,
    required this.topicContent,
    required this.youtubeVideoId,
  });
}
