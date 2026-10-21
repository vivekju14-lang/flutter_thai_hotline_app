import 'package:flutter/material.dart';
import '../data/hotlines.dart';
import '../services/phone_service.dart';
import '../widgets/hotline_list.dart';

class BankUI extends StatelessWidget {
  const BankUI({super.key, required this.phoneService});
  final PhoneService phoneService;
  @override
  Widget build(BuildContext context) => HotlineList(
    title: 'ธนาคาร',
    banner: 'assets/images/bank/bank_0.png',
    entries: bankHotlines,
    phoneService: phoneService,
  );
}
