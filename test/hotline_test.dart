import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_thai_hotline_app/main.dart';
import 'package:flutter_thai_hotline_app/data/hotlines.dart';
import 'package:flutter_thai_hotline_app/services/phone_service.dart';
import 'package:flutter_thai_hotline_app/views/about_ui.dart';
import 'package:flutter_thai_hotline_app/views/home_ui.dart';

class FakePhone extends PhoneService {
  final opened = <Uri>[];
  bool available = true;
  @override
  Future<bool> open(Uri uri) async {
    opened.add(uri);
    return available;
  }
}

Future<void> start(WidgetTester t, FakePhone phone) async {
  await t.pumpWidget(
    ThaiHotlineApp(
      phoneService: phone,
      splashDuration: const Duration(milliseconds: 100),
    ),
  );
  await t.pump(const Duration(milliseconds: 100));
  await t.pumpAndSettle();
}

void main() {
  test(
    '44 records have unique IDs, supplied assets and normalized dial numbers',
    () {
      expect(allHotlines.length, 44);
      expect(allHotlines.map((e) => e.id).toSet().length, 44);
      for (final e in allHotlines) {
        expect(e.dialNumber, matches(RegExp(r'^\d{3,10}$')));
        expect(e.phoneUri.scheme, 'tel');
        expect(Uri.parse(e.source).scheme, 'https');
        expect(File(e.asset).lengthSync(), greaterThan(0));
      }
      expect(
        emergencyHotlines
            .singleWhere((e) => e.name == 'การแพทย์ฉุกเฉิน')
            .number,
        '1669',
      );
      expect(pubutilHotlines.last.number, '1888');
      expect(
        bankHotlines
            .singleWhere((e) => e.name.startsWith('ลูกค้าเดิมซิตี้'))
            .dialNumber,
        '022851555',
      );
    },
  );
  testWidgets('Splash automatically enters HomeUI without back entry', (
    t,
  ) async {
    await t.pumpWidget(ThaiHotlineApp(phoneService: FakePhone()));
    expect(find.text('THAI HOTLINE APP'), findsOneWidget);
    await t.pump(const Duration(seconds: 2));
    await t.pumpAndSettle();
    expect(find.byType(HomeUI), findsOneWidget);
    expect(find.text('THAI HOTLINE APP'), findsNothing);
    expect(Navigator.of(t.element(find.byType(HomeUI))).canPop(), isFalse);
  });
  testWidgets('All four tabs show their own rows', (t) async {
    await start(t, FakePhone());
    for (final item in [
      ('การเดินทาง', travelHotlines.first.name),
      ('เหตุฉุกเฉิน', emergencyHotlines.first.name),
      ('ธนาคาร', bankHotlines.first.name),
      ('สาธารณูปโภค', pubutilHotlines.first.name),
    ]) {
      await t.tap(find.text(item.$1));
      await t.pumpAndSettle();
      expect(find.text(item.$2), findsOneWidget);
    }
  });
  testWidgets(
    'Cancel call never invokes external service; confirm uses tel URI',
    (t) async {
      final phone = FakePhone();
      await start(t, phone);
      await t.tap(find.byTooltip('โทร ${travelHotlines.first.name}'));
      await t.pumpAndSettle();
      expect(phone.opened, isEmpty);
      await t.tap(find.text('ยกเลิก'));
      await t.pumpAndSettle();
      expect(phone.opened, isEmpty);
      await t.tap(find.byTooltip('โทร ${travelHotlines.first.name}'));
      await t.pumpAndSettle();
      await t.tap(find.text('เปิดโทรศัพท์'));
      await t.pumpAndSettle();
      expect(phone.opened, [Uri.parse('tel:1197')]);
    },
  );
  testWidgets('Failure to open a dialer shows fallback feedback', (t) async {
    final phone = FakePhone()..available = false;
    await start(t, phone);
    await t.tap(find.byTooltip('โทร ${travelHotlines.first.name}'));
    await t.pumpAndSettle();
    await t.tap(find.text('เปิดโทรศัพท์'));
    await t.pumpAndSettle();
    expect(
      find.text(
        'ไม่พบแอปที่เปิดลิงก์นี้ได้ โปรดใช้หมายเลขที่แสดงเพื่อติดต่อโดยตรง',
      ),
      findsOneWidget,
    );
  });
  testWidgets('Row details show number and open the documented source', (
    t,
  ) async {
    final phone = FakePhone();
    await start(t, phone);
    await t.tap(find.byKey(ValueKey(travelHotlines.first.id)));
    await t.pumpAndSettle();
    expect(find.byType(SelectableText), findsOneWidget);
    await t.tap(find.text('ดูแหล่งข้อมูลทางการ'));
    await t.pumpAndSettle();
    expect(phone.opened, [Uri.parse(travelHotlines.first.source)]);
  });
  testWidgets(
    'About uses correct student identity and back returns to category',
    (t) async {
      await start(t, FakePhone());
      await t.tap(find.byTooltip('ผู้จัดทำ'));
      await t.pumpAndSettle();
      expect(find.byType(AboutUI), findsOneWidget);
      expect(find.text('6819110001'), findsOneWidget);
      expect(find.text('Rajesh Kumar Upadhayay'), findsOneWidget);
      await t.pageBack();
      await t.pumpAndSettle();
      expect(find.text(travelHotlines.first.name), findsOneWidget);
    },
  );
  testWidgets(
    '320x568 layout, long bank labels and final utility remain usable',
    (t) async {
      t.view.physicalSize = const Size(320, 568);
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.resetPhysicalSize);
      addTearDown(t.view.resetDevicePixelRatio);
      await start(t, FakePhone());
      await t.tap(find.text('ธนาคาร'));
      await t.pumpAndSettle();
      await t.scrollUntilVisible(
        find.byKey(ValueKey(bankHotlines.last.id)),
        250,
      );
      await t.pumpAndSettle();
      expect(find.text(bankHotlines.last.name), findsOneWidget);
      await t.tap(find.text('สาธารณูปโภค'));
      await t.pumpAndSettle();
      await t.scrollUntilVisible(
        find.byKey(ValueKey(pubutilHotlines.last.id)),
        250,
      );
      await t.pumpAndSettle();
      expect(find.text('NT (เดิม TOT)'), findsOneWidget);
      expect(t.takeException(), isNull);
    },
  );
}
