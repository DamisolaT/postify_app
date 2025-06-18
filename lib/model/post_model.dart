class Post {
  final num? userId;
  final int? id;
  final String? title;
  final String? body;

  Post({
    required this.userId,
     this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  String toString() {
    return "$userId, $id, $title, $body";
  }
}
