import 'package:flutter/material.dart';
import '../data/hotlines.dart';
import '../services/phone_service.dart';
import '../widgets/hotline_list.dart';

class PubUI extends StatelessWidget {
  const PubUI({super.key, required this.phoneService});
  final PhoneService phoneService;
  @override
  Widget build(BuildContext context) => HotlineList(
    title: 'สาธารณูปโภค',
    banner: 'assets/images/pubutil/pub_0.png',
    entries: pubutilHotlines,
    phoneService: phoneService,
  );
}
