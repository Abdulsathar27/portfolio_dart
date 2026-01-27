import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/services/contact_service.dart';
import 'package:profitillo/widgets/contact_success_popup.dart';
import 'package:profitillo/widgets/custom_button.dart';
import 'package:profitillo/widgets/interactive_text_field.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _contactService = ContactService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        // Default to Email for the main form submission
        // You could add a toggle or separate buttons for WhatsApp if desired
        await _contactService.sendEmail(
          name: _nameController.text,
          email: _emailController.text,
          message: _messageController.text,
        );

        if (mounted) {
          _showSuccessPopup(context);
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error sending message: $e"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.2),
      builder: (context) =>
          ContactSuccessPopup(onDismiss: () => Navigator.of(context).pop()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InteractiveTextField(
            label: "Name",
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1),
          const SizedBox(height: 24),
          InteractiveTextField(
            label: "Email",
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.1),
          const SizedBox(height: 24),
          InteractiveTextField(
            label: "Message",
            maxLines: 5,
            controller: _messageController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a message';
              }
              return null;
            },
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: 40),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomButton(
                  text: "Send Message",
                  onPressed: _submitForm,
                  icon: Icons.send,
                ).animate().fadeIn(delay: 700.ms).scale(),
          const SizedBox(height: 20),
          Center(
            child: TextButton.icon(
              onPressed: () async {
                try {
                  await _contactService.sendWhatsApp(
                    message: "Hi, I'd like to discuss a project.",
                  );
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Could not launch WhatsApp: $e")),
                    );
                  }
                }
              },
              icon: const Icon(Icons.message, size: 18),
              label: const Text("Or chat on WhatsApp"),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
              ),
            ),
          ).animate().fadeIn(delay: 800.ms),
        ],
      ),
    );
  }
}
