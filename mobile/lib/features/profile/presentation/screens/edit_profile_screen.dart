import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/utils/haptic_feedback.dart';
import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _timezoneController;
  late TextEditingController _passwordController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;
    _nameController = TextEditingController(text: user?.fullname ?? '');
    _timezoneController = TextEditingController(text: user?.timezone ?? '');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timezoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    await AppHaptics.medium();

    final success = await ref
        .read(authProvider.notifier)
        .updateProfile(
          fullname: _nameController.text.trim(),
          timezone: _timezoneController.text.trim(),
          password: _passwordController.text,
        );

    if (success && mounted) {
      await AppHaptics.success();
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } else if (mounted) {
      final error = ref.read(authProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Failed to update profile'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.screenPaddingHorizontal),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PERSONAL INFORMATION', style: AppTypography.statLabel),
              SizedBox(height: AppSpacing.md),
              _buildGlassField(
                label: 'Full Name',
                controller: _nameController,
                icon: Icons.person_outline,
                validator: (val) => val == null || val.isEmpty
                    ? 'Please enter your name'
                    : null,
              ),
              SizedBox(height: AppSpacing.md),
              _buildGlassField(
                label: 'Timezone',
                controller: _timezoneController,
                icon: Icons.public,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Please enter timezone' : null,
              ),
              SizedBox(height: AppSpacing.xl),
              Text('CONFIRMATION', style: AppTypography.statLabel),
              SizedBox(height: AppSpacing.xs),
              Text(
                'Enter your current password to save changes.',
                style: AppTypography.caption,
              ),
              SizedBox(height: AppSpacing.md),
              _buildGlassField(
                label: 'Current Password',
                controller: _passwordController,
                icon: Icons.lock_outline,
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Password is required' : null,
              ),
              SizedBox(height: AppSpacing.xxl),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusMedium,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.caption),
        SizedBox(height: AppSpacing.xs),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border: Border.all(color: AppColors.border),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: AppColors.text, fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 20, color: AppColors.textSecondary),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
