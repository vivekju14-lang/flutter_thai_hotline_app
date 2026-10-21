import 'package:url_launcher/url_launcher.dart';

class PhoneService {
  const PhoneService();
  Future<bool> open(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}
