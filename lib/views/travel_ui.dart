import 'package:flutter/material.dart';
import '../data/hotlines.dart';
import '../services/phone_service.dart';
import '../widgets/hotline_list.dart';

class TravelUI extends StatelessWidget {
  const TravelUI({super.key, required this.phoneService});
  final PhoneService phoneService;
  @override
  Widget build(BuildContext context) => HotlineList(
    title: 'การเดินทาง',
    banner: 'assets/images/travel/travel_0.png',
    entries: travelHotlines,
    phoneService: phoneService,
  );
}
