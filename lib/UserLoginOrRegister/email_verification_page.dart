import 'package:flutter/material.dart';
import 'dart:async';
import '../Backend/Service/auth.dart';
import 'login.dart';

/// Email verification page that WAITS for user to verify,
/// then directs them to the Login page.
class EmailVerificationPage extends StatefulWidget {
  final String email;

  const EmailVerificationPage({super.key, required this.email});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _authService = SupabaseAuthService();

  bool _isResending = false;
  String? _statusMessage;
  bool _isErrorMessage = false;

  Timer? _timer;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _secondsRemaining = 60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  void _handleProceedToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Future<void> _handleResendEmail() async {
    // Prevent spamming if timer is running or currently sending
    if (_secondsRemaining > 0 || _isResending) return;

    setState(() {
      _isResending = true;
      _statusMessage = null;
    });

    try {
      await _authService.resendVerificationEmail(email: widget.email);

      if (mounted) {
        setState(() {
          _statusMessage =
              'Verification email sent successfully! Please check your inbox.';
          _isErrorMessage = false;
        });
        _startResendTimer();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          // Clean up the exception message for better readability
          String errorMsg = e.toString().replaceAll('Exception: ', '');
          _statusMessage = 'Failed to send: $errorMsg';
          _isErrorMessage = true;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color.fromARGB(255, 26, 130, 195),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        size: 80,
                        color: Color.fromARGB(255, 26, 130, 195),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Verify Your Email',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'We\'ve sent a verification link to:',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.email,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Please check your email and click the verification link. After verifying, return to the app and log in.',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),

                      // Status Message Display Area
                      if (_statusMessage != null) ...[
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                _isErrorMessage
                                    ? Colors.red.shade50
                                    : Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  _isErrorMessage
                                      ? Colors.red.shade300
                                      : Colors.green.shade300,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _isErrorMessage
                                    ? Icons.error_outline
                                    : Icons.check_circle_outline,
                                color:
                                    _isErrorMessage
                                        ? Colors.red.shade700
                                        : Colors.green.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _statusMessage!,
                                  style: TextStyle(
                                    color:
                                        _isErrorMessage
                                            ? Colors.red.shade700
                                            : Colors.green.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 32),

                      // Proceed to Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _handleProceedToLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              26,
                              130,
                              195,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Proceed to Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Resend Button with Timer
                      TextButton.icon(
                        onPressed:
                            (_isResending || _secondsRemaining > 0)
                                ? null
                                : _handleResendEmail,
                        icon:
                            _isResending
                                ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.grey,
                                  ),
                                )
                                : Icon(
                                  Icons.refresh,
                                  color:
                                      _secondsRemaining > 0
                                          ? Colors.grey
                                          : const Color.fromARGB(
                                            255,
                                            26,
                                            130,
                                            195,
                                          ),
                                ),
                        label: Text(
                          _isResending
                              ? 'Sending...'
                              : _secondsRemaining > 0
                              ? 'Resend in ${_secondsRemaining}s'
                              : 'Resend Verification Email',
                          style: TextStyle(
                            color:
                                _secondsRemaining > 0
                                    ? Colors.grey
                                    : const Color.fromARGB(255, 26, 130, 195),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
