import 'package:check_lottery/API/lotteryAPI.dart';
import 'package:flutter/material.dart';

class HuaiExit extends StatelessWidget {
  const HuaiExit({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: huaiAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var prizes = snapshot.data!;
          return ListView.builder(
            itemCount: prizes.length,
            itemBuilder: (context, index) {
              var prize = prizes[index];
              List<String> numbers = List<String>.from(prize['number']);

              int amount = numbers.length;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      prize['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'รางวัลละ: ${prize['reward']}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'จำนวน: $amount รางวัล',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'เลขที่ออก: ${numbers.join(", ")}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
