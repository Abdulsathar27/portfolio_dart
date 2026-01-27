import 'package:url_launcher/url_launcher.dart';

class ContactService {
  // Replace with your actual email and phone number
  static const String _myEmail = "abdulsatharnechithodi@gmail.com";
  static const String _myWhatsApp =
      "919747358257"; // International format without +

  Future<void> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: _myEmail,
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Portfolio Contact from $name',
        'body': 'Name: $name\nEmail: $email\n\nMessage:\n$message',
      }),
    );

    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch email client');
    }
  }

  Future<void> sendWhatsApp({required String message}) async {
    // Using WhatsApp Web/Universal link
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$_myWhatsApp?text=${Uri.encodeComponent(message)}",
    );

    if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch WhatsApp');
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}
