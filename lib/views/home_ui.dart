import 'package:flutter/material.dart';
import '../services/phone_service.dart';
import 'travel_ui.dart';
import 'emg_ui.dart';
import 'bank_ui.dart';
import 'pub_ui.dart';
import 'about_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key, required this.phoneService});
  final PhoneService phoneService;
  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      TravelUI(phoneService: widget.phoneService),
      EmgUI(phoneService: widget.phoneService),
      BankUI(phoneService: widget.phoneService),
      PubUI(phoneService: widget.phoneService),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('สายด่วน THAILAND'),
        actions: [
          IconButton(
            tooltip: 'ผู้จัดทำ',
            icon: const Icon(Icons.info_outline, size: 23),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const AboutUI()),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'การเดินทาง',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency_outlined),
            label: 'เหตุฉุกเฉิน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            label: 'ธนาคาร',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service_outlined),
            label: 'สาธารณูปโภค',
          ),
        ],
      ),
    );
  }
}
