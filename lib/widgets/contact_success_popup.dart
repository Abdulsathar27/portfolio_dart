import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_colors.dart';

class ContactSuccessPopup extends StatelessWidget {
  final VoidCallback onDismiss;

  const ContactSuccessPopup({super.key, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_circle_outline,
                                  color: AppColors.primary,
                                  size: 40,
                                ),
                              )
                              .animate()
                              .scale(duration: 400.ms, curve: Curves.elasticOut)
                              .then()
                              .shake(hz: 4, curve: Curves.easeInOut),
                          const SizedBox(height: 16),
                          const Text(
                            "Message Sent!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Thanks for reaching out. I'll get back to you soon!",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: onDismiss,
                            child: const Text(
                              "Close",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 300.ms)
              .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack),
    );
  }
}
