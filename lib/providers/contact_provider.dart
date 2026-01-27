import 'package:flutter/material.dart';
import 'package:profitillo/services/contact_service.dart';

class ContactProvider extends ChangeNotifier {
  final ContactService _contactService = ContactService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<bool> submitForm() async {
    if (formKey.currentState!.validate()) {
      _isLoading = true;
      notifyListeners();

      try {
        await _contactService.sendEmail(
          name: nameController.text,
          email: emailController.text,
          message: messageController.text,
        );

        // Clear form on success
        nameController.clear();
        emailController.clear();
        messageController.clear();

        _isLoading = false;
        notifyListeners();
        return true;
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        rethrow;
      }
    }
    return false;
  }

  Future<void> sendWhatsApp() async {
    await _contactService.sendWhatsApp(
      message: "Hi, I'd like to discuss a project.",
    );
  }
}
