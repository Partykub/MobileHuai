import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> huaiAPI() async {
  final response = await http.get(Uri.parse(
      'https://814554a6-99d2-499d-89aa-cb22216c9c91-00-237tfsgh7pxsr.pike.replit.dev/huai'));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return [
      data[0]['prizes'][0], // รางวัลที่ 1
      data[0]['prizes'][1], // รางวัลข้างเคียงรางวัลที่ 1
      data[0]['prizes'][2], // รางวัลที่ 2
      data[0]['prizes'][3], // รางวัลที่ 3
      data[0]['prizes'][4], // รางวัลที่ 4
      data[0]['prizes'][5], // รางวัลที่ 5
      data[0]['runningNumbers'][0], // รางวัลเลขหน้า 3 ตัว
      data[0]['runningNumbers'][1], // รางวัลเลขท้าย 3 ตัว
      data[0]['runningNumbers'][2], // รางวัลเลขท้าย 2 ตัว
    ];
  } else {
    throw Exception('Failed to load lottery results');
  }
}
