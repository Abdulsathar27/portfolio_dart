import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/providers/contact_provider.dart';
import 'package:profitillo/views/widgets/contact_success_popup.dart';
import 'package:profitillo/views/widgets/custom_button.dart';
import 'package:profitillo/views/widgets/interactive_text_field.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

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
    final contactProvider = Provider.of<ContactProvider>(
      context,
      listen: false,
    );

    return Form(
      key: contactProvider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InteractiveTextField(
            label: "Name",
            controller: contactProvider.nameController,
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
            controller: contactProvider.emailController,
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
            controller: contactProvider.messageController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a message';
              }
              return null;
            },
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: 40),
          Consumer<ContactProvider>(
            builder: (context, provider, child) {
              return provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: "Send Message",
                      onPressed: () async {
                        try {
                          final success = await provider.submitForm();
                          if (success && context.mounted) {
                            _showSuccessPopup(context);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error sending message: $e"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      icon: Icons.send,
                    ).animate().fadeIn(delay: 700.ms).scale();
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton.icon(
              onPressed: () async {
                try {
                  await contactProvider.sendWhatsApp();
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
                foregroundColor: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ).animate().fadeIn(delay: 800.ms),
        ],
      ),
    );
  }
}
