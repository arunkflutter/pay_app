import '../../../../exports.dart';

class HomeController extends GetxController with BaseClass {
  final List<Map<String, dynamic>> dummyTransactions = [
    {
      "name": "Anna Smith",
      "amount": 20,
      "time": "Today, 10:45 AM",
      "isCredit": true,
    },
    {
      "name": "John Carter",
      "amount": 45,
      "time": "Today, 09:30 AM",
      "isCredit": false,
    },
    {
      "name": "Emily Brown",
      "amount": 120,
      "time": "Yesterday, 06:15 PM",
      "isCredit": true,
    },
    {
      "name": "Michael Lee",
      "amount": 75,
      "time": "Yesterday, 02:40 PM",
      "isCredit": false,
    },
    {
      "name": "Sophia Wilson",
      "amount": 300,
      "time": "12 Aug, 11:20 AM",
      "isCredit": true,
    },
  ];
}
