import 'package:flutter/material.dart';
import '../data/hotlines.dart';
import '../services/phone_service.dart';
import '../widgets/hotline_list.dart';

class EmgUI extends StatelessWidget {
  const EmgUI({super.key, required this.phoneService});
  final PhoneService phoneService;
  @override
  Widget build(BuildContext context) => HotlineList(
    title: 'อุบัติเหตุ–เหตุฉุกเฉิน',
    banner: 'assets/images/emergency/emg_0.png',
    entries: emergencyHotlines,
    phoneService: phoneService,
  );
}
