class Lesson {
  final int? id;
  final String title;
  final String content;

  Lesson({this.id, required this.title, required this.content});

  // تبدیل مدل به Map برای ذخیره در دیتابیس
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  // تبدیل Map به مدل Lesson برای نمایش در اپ
  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}