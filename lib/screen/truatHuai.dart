import 'package:flutter/material.dart';
import 'package:check_lottery/API/lotteryAPI.dart';

class TruatHuai extends StatefulWidget {
  const TruatHuai({Key? key}) : super(key: key);

  @override
  _TruatHuaiState createState() => _TruatHuaiState();
}

class _TruatHuaiState extends State<TruatHuai> {
  final TextEditingController _numberController = TextEditingController();
  String _result = 'ถูกรางวัลไหนไหมน้า';

  void _checkLottery(BuildContext context) async {
    if (_numberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณาป้อนเลขหวย'),
        ),
      );
      return;
    }

    if (_numberController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณาป้อนเลขหวยให้ครบ 6 ตัว'),
        ),
      );
      return;
    }

    List<dynamic> prizes = await huaiAPI();

    bool found = false;
    for (var prize in prizes) {
      List<String> numbers = List<String>.from(prize['number']);
      if (numbers.contains(_numberController.text)) {
        setState(() {
          _result = 'คุณถูกรางวัล ${prize['name']}';
        });
        found = true;
        break;
      }
    }

    if (!found) {
      String lastThreeDigits = _numberController.text.substring(3);
      for (var prize in prizes) {
        if (prize['id'] == 'runningNumberBackThree') {
          List<String> numbers = List<String>.from(prize['number']);
          if (numbers.contains(lastThreeDigits)) {
            setState(() {
              _result = 'คุณถูกรางวัล ${prize['name']}';
            });
            found = true;
            break;
          }
        }
      }

      if (!found) {
        String lastTwoDigits = _numberController.text.substring(4);
        for (var prize in prizes) {
          if (prize['id'] == 'runningNumberBackTwo') {
            List<String> numbers = List<String>.from(prize['number']);
            if (numbers.contains(lastTwoDigits)) {
              setState(() {
                _result = 'คุณถูกรางวัล ${prize['name']}';
              });
              found = true;
              break;
            }
          }
        }
      }

      if (!found) {
        setState(() {
          _result = 'คุณไม่ถูกรางวัล';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _result,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: 'กรอกเลขหวย 6 ตัว',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _checkLottery(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'ตรวจสอบ',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
