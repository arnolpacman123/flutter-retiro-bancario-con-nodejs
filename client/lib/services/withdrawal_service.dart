import 'package:client/models/withdrawal_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class WithdrawalService {
  String baseUrl =
      'https://rest-retiro-bancario-server.herokuapp.com/api/v1/withdrawal';
  final log = Logger();

  Future registerWithdrawal(int amount, String account) async {
    final url = formater('/register');
    final body = requestWithDrawalToMap(RequestWithDrawal(amount: amount, account: account));
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
