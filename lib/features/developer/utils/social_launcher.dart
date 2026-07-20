import 'package:url_launcher/url_launcher.dart';

class SocialLauncher {
  SocialLauncher._();

  static Future<void> open(String url) async {
    if (url.trim().isEmpty) return;

    final uri = Uri.parse(url);

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  static Future<void> email(String email) async {
    final uri = Uri(
      scheme: "mailto",
      path: email,
    );

    await launchUrl(uri);
  }

  static Future<void> phone(String phone) async {
    final uri = Uri(
      scheme: "tel",
      path: phone,
    );

    await launchUrl(uri);
  }

  static Future<void> map(String location) async {
    final uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}",
    );

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}