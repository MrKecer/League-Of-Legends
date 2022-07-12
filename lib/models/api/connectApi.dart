import 'package:http/http.dart' as http;

class LolApi {
  static Future getLol() async {
    return await http.get(Uri.parse(
        "https://raw.githubusercontent.com/ngryman/lol-champions/master/champions.json"));
  }
}
