class TodoModel {
  final int id;
  final String title;
  final bool completed;
  final String createdAt;
  final String updatedAt;

  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        completed = json['completed'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
