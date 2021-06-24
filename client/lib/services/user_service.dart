import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:client/models/user_response.dart';

class UserService {
  String baseUrl =
      'https://rest-retiro-bancario-server.herokuapp.com/api/v1/user';
  final log = Logger();

  Future<bool?> existUser(String email) async {
    final url = formater('/checkuser/$email');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      final checkUserResponse = checkUserResponseFromMap(response.body);
      return checkUserResponse.status;
    }
    return true;
  }

  Future<User?> getUser(String email) async {
    final url = formater('/$email');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      final userResponse = userResponseFromMap(response.body);
      return userResponse.data!;
    }
    log.d(response.body);
    log.d(response.statusCode);
    return null;
  }

  Future<User?> getUserById(String id) async {
    final url = formater('/getuserbyid/$id');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      final userResponse = userResponseFromMap(response.body);
      return userResponse.data!;
    }
    log.d(response.body);
    log.d(response.statusCode);
    return null;
  }

  Future registerUser(User user) async {
    final url = formater('/register');
    final body = userToMap(user);
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return response;
    }
    log.d(response.body);
    log.d(response.statusCode);
  }

  String formater(String url) {
    return baseUrl + url;
  }
}
