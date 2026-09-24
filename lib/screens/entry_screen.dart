import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../widgets/buddy_logo.dart';
import '../services/worker_auth_service.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final _employeeIdController = TextEditingController(text: '1547-2026-SNT');
  final _pinController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePin = true;
  String? _errorMessage;

  @override
  void dispose() {
    _employeeIdController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _handleSecureLogin() async {
    if (_employeeIdController.text.trim().isEmpty ||
        _pinController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'يرجى إدخال الرقم الوظيفي والرمز السري';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await WorkerAuthService.login(
      employeeId: _employeeIdController.text.trim(),
      pin: _pinController.text.trim(),
    );

    if (!mounted) return;

    if (result.success) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = result.error ?? 'فشل تسجيل الدخول';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // 🎨 الشعار
              const Center(child: BuddyLogo(size: 130)),

              const SizedBox(height: 40),

              // 🛡️ شارة الأمان
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.sageGreen.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    // أيقونة الدرع
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.primaryOrange.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.verified_user_outlined,
                        color: AppColors.primaryOrange,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'تسجيل الدخول الآمن',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '(Privacy by Design) البيانات مشفرة ومجهولة',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.inkLight.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 🆔 رقم الموظف
              _buildLabel('رقم الموظف (ID)'),
              const SizedBox(height: 8),
              TextField(
                controller: _employeeIdController,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: '1547-2026-SNT',
                  hintStyle: TextStyle(
                    color: AppColors.inkLight.withOpacity(0.5),
                  ),
                  prefixIcon: const Icon(
                    Icons.badge_outlined,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔒 الرمز السري
              _buildLabel('الرمز السري (PIN)'),
              const SizedBox(height: 8),
              TextField(
                controller: _pinController,
                obscureText: _obscurePin,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                ),
                decoration: InputDecoration(
                  hintText: '••••••',
                  hintStyle: TextStyle(
                    color: AppColors.inkLight.withOpacity(0.5),
                    letterSpacing: 8,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.sageGreen,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePin ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.inkLight,
                    ),
                    onPressed: () {
                      setState(() => _obscurePin = !_obscurePin);
                    },
                  ),
                  counterText: '',
                ),
              ),

              const SizedBox(height: 12),

              // 🔐 شارة التشفير
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: AppColors.sageGreen,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'تشفير AES-256 نشط محلياً',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.sageGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ⚠️ رسالة الخطأ
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.dangerRed.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.dangerRed.withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.dangerRed,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: AppColors.dangerRed,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // 🚀 زر الدخول
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSecureLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.inkLight.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'دخول آمن',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // 👤 الدخول المجهول
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: Text(
                  'الدخول بشكل مجهول',
                  style: TextStyle(
                    color: AppColors.sageGreenLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🏢 تذييل
              Center(
                child: Column(
                  children: [
                    Text(
                      'Buddy System v1.0.0',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.inkLight.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'متوافق مع ISO 45003 | 45001',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.sageGreen.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }
}
