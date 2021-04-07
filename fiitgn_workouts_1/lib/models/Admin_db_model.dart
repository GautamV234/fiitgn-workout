import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AdminDbModel {
  final String emailId;
  final String uniqueId;
  final String name;

  AdminDbModel({
    @required this.emailId,
    @required this.name,
    @required this.uniqueId,
  });

  factory AdminDbModel.fromJson(dynamic json) {
    return AdminDbModel(
        emailId: "${json['id']}",
        uniqueId: "${json['url']}",
        name: "${json['name']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'id': emailId,
        'name': name,
        'url': uniqueId,
      };
}

class GetAdminDataFromGoogleSheetProvider with ChangeNotifier {
  List<AdminDbModel> _listAdmin = List<AdminDbModel>();
  static const URL =
      "https://script.google.com/macros/s/AKfycbx57muC0PlTGKmlkLTfrKP4Om9QJn1pjtVShNxc0Hxv7F5z9Sx5JB1xxhxGyiwchOw/exec";
  Future<List<AdminDbModel>> getListOfAdmins() async {
    await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      _listAdmin =
          jsonFeedback.map((json) => AdminDbModel.fromJson(json)).toList();
      notifyListeners();
    });
  }

  List<AdminDbModel> get listAdmin {
    return [..._listAdmin];
  }
}
