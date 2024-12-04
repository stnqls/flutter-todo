import 'package:dio/dio.dart';

class ApiService {
  static String baseUrl = 'https://iskkiri.com/api';
  static String todos = 'todos';

  static final dio = Dio();

  static postTodo(String text) async {
    final response = await dio.post('$baseUrl/$todos', data: {'title': text});
    return response.data;
  }
}
