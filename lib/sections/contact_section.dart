import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/widgets/contact_success_popup.dart';
import 'package:profitillo/widgets/custom_button.dart';
import 'package:profitillo/widgets/interactive_text_field.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      width: double.infinity,
      child: Stack(
        children: [
          // Background Elements (Particles/Mesh placeholder)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Column(
            children: [
              Text(
                AppStrings.contact,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
              const SizedBox(height: 20),
              Text(
                "Interested in working together? Let's talk!",
                style: Theme.of(context).textTheme.titleLarge,
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 60),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).cardColor.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          const InteractiveTextField(
                            label: "Name",
                          ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1),
                          const SizedBox(height: 24),
                          const InteractiveTextField(
                            label: "Email",
                          ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.1),
                          const SizedBox(height: 24),
                          const InteractiveTextField(
                            label: "Message",
                            maxLines: 5,
                          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                          const SizedBox(height: 40),
                          CustomButton(
                            text: "Send Message",
                            onPressed: () => _showSuccessPopup(context),
                            icon: Icons.send,
                          ).animate().fadeIn(delay: 700.ms).scale(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.2),
      builder: (context) =>
          ContactSuccessPopup(onDismiss: () => Navigator.of(context).pop()),
    );
  }
}
