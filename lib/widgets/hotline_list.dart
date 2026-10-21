import 'package:flutter/material.dart';
import '../models/hotline.dart';
import '../services/phone_service.dart';

class HotlineList extends StatelessWidget {
  const HotlineList({
    super.key,
    required this.title,
    required this.banner,
    required this.entries,
    required this.phoneService,
  });
  final String title, banner;
  final List<Hotline> entries;
  final PhoneService phoneService;
  Future<void> _open(BuildContext context, Uri uri) async {
    final ok = await phoneService.open(uri);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'ไม่พบแอปที่เปิดลิงก์นี้ได้ โปรดใช้หมายเลขที่แสดงเพื่อติดต่อโดยตรง',
          ),
        ),
      );
    }
  }

  Future<void> _call(BuildContext context, Hotline entry) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(entry.name),
        content: Text('เปิดแอปโทรศัพท์ไปที่ ${entry.number}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('ยกเลิก'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('เปิดโทรศัพท์'),
          ),
        ],
      ),
    );
    if (yes == true && context.mounted) {
      await _open(context, entry.phoneUri);
    }
  }

  void _details(BuildContext context, Hotline entry) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SelectableText(
                entry.number,
                style: const TextStyle(fontSize: 26),
              ),
              if (entry.note.isNotEmpty) Text(entry.note),
              const SizedBox(height: 12),
              const Text(
                'ตรวจสอบแหล่งข้อมูล: 21 ตุลาคม 2569',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              TextButton.icon(
                onPressed: () => _open(context, Uri.parse(entry.source)),
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('ดูแหล่งข้อมูลทางการ'),
              ),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _call(context, entry);
                },
                icon: const Icon(Icons.phone_outlined),
                label: const Text('เปิดแอปโทรศัพท์'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ListView(
    key: PageStorageKey(title),
    padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
    children: [
      Text(
        'สายด่วน\n$title',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w600,
          height: 1.15,
        ),
      ),
      const SizedBox(height: 14),
      Center(
        child: Image.asset(
          banner,
          height: 150,
          width: 240,
          fit: BoxFit.contain,
        ),
      ),
      const SizedBox(height: 16),
      ...entries.map(
        (entry) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Material(
            color: Colors.white,
            elevation: .7,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              key: ValueKey(entry.id),
              borderRadius: BorderRadius.circular(10),
              onTap: () => _details(context, entry),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E2E2)),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFD3D3D3)),
                      ),
                      child: Image.asset(entry.asset, fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            entry.number,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF454545),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      key: ValueKey('call-${entry.id}'),
                      tooltip: 'โทร ${entry.name}',
                      onPressed: () => _call(context, entry),
                      icon: const Icon(Icons.phone_outlined, size: 22),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'แตะรายการเพื่อดูรายละเอียดและแหล่งข้อมูล',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    ],
  );
}
