import 'package:flutter/material.dart';

class AboutUI extends StatelessWidget {
  const AboutUI({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('สายด่วน THAILAND')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            const Text(
              'ผู้จัดทำ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 18),
            Image.asset(
              'assets/images/aboutme/saulogo.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),
            const Text(
              'มหาวิทยาลัยเอเชียอาคเนย์',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/aboutme/me.png',
              height: 140,
              width: 140,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'รหัสนักศึกษา',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Text('6819110001', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            const Text(
              'ชื่อ–สกุลนักศึกษา',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Text(
              'Rajesh Kumar Upadhayay',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 14),
            const Text('รายวิชา Flutter / Dart'),
            const Text(
              'Assignment 07: flutter_thai_hotline_app',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              'แอปต้นแบบเพื่อการศึกษา',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Text(
              'ข้อมูลติดต่ออ้างอิงเว็บไซต์หน่วยงาน ตรวจสอบ 21 ต.ค. 2569\nบางแหล่งข้อมูลเผยแพร่ก่อนวันที่ตรวจสอบ หมายเลขอาจเปลี่ยนแปลง\nภาพผู้พัฒนาเป็นภาพประกอบจากชุดทรัพยากร',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
}
