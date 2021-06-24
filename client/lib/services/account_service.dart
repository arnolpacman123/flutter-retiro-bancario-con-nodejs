import 'package:client/models/account_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AccountService {
  String baseUrl =
      'https://rest-retiro-bancario-server.herokuapp.com/api/v1/account';
  final log = Logger();

  Future<bool?> checkBalance(int number, int amount) async {
    final url = formater('/checkbalance/$number/$amount');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      final checkBalanceResponse = checkBalanceResponseFromMap(response.body);
      return checkBalanceResponse.status;
    }
    return false;
  }

  String formater(String url) {
    return baseUrl + url;
  }
}
