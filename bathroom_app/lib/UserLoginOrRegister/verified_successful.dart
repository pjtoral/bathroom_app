import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wowow Password Reset',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: ChangeNotifierProvider<PasswordResetData>(
        create: (BuildContext context) => PasswordResetData(),
        builder: (BuildContext context, Widget? child) =>
            const PasswordResetScreen(),
      ),
    );
  }
}

/// Data model for the password reset screen.
/// Manages password input, confirmation, and their visibility states.
class PasswordResetData extends ChangeNotifier {
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  bool _isPasswordVisible;
  bool _isConfirmPasswordVisible;

  PasswordResetData()
      : _passwordController = TextEditingController(),
        _confirmPasswordController = TextEditingController(),
        _isPasswordVisible = false,
        _isConfirmPasswordVisible = false;

  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  /// Toggles the visibility of the main password field.
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// Toggles the visibility of the confirm password field.
  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  /// Handles the password update logic.
  /// In a real application, this would include validation and API calls.
  void updatePassword() {
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      // In a real app, show a SnackBar or AlertDialog
      // For this example, we'll just print.
      debugPrint('Password fields cannot be empty.');
      return;
    }

    if (_passwordController.text == _confirmPasswordController.text) {
      debugPrint('Password updated successfully!');
      debugPrint('New Password: ${_passwordController.text}');
      // Here you would typically navigate away or show a success message
    } else {
      // In a real app, show an error message
      debugPrint('Passwords do not match. Please try again.');
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

/// The main screen for resetting a password.
/// Displays a custom wave background, input fields, and an update button.
class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    final PasswordResetData passwordResetData =
        Provider.of<PasswordResetData>(context);
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          // Background flat section
          Positioned.fill(
            child: CustomPaint(
              painter: FlatBackgroundPainter(color: const Color(0xFFF59D1E)),
            ),
          ),
          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16.0,
            left: 16.0,
            child: GestureDetector(
              onTap: () {
                // Navigator.pop(context); // This would typically navigate back
                debugPrint('Back button pressed');
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFFF59D1E),
                  size: 24,
                ),
              ),
            ),
          ),
          // Scrollable Content Area
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Spacing to position content below the background section
                    SizedBox(height: screenHeight * 0.35),
                    const Text(
                      'Wowow',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Verified successful! Set your new password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _PasswordInputField(
                      controller: passwordResetData.passwordController,
                      hintText: 'Enter your Password',
                      isVisible: passwordResetData.isPasswordVisible,
                      onToggleVisibility:
                          passwordResetData.togglePasswordVisibility,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _PasswordInputField(
                      controller: passwordResetData.confirmPasswordController,
                      hintText: 'Re-enter your Password',
                      isVisible: passwordResetData.isConfirmPasswordVisible,
                      onToggleVisibility:
                          passwordResetData.toggleConfirmPasswordVisibility,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        passwordResetData.updatePassword();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF59D1E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Ensures there's enough scroll space at the bottom if needed
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A reusable widget for password input fields with a visibility toggle.
class _PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isVisible;
  final VoidCallback onToggleVisibility;

  const _PasswordInputField({
    required this.controller,
    required this.hintText,
    required this.isVisible,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF59D1E)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF59D1E), width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFFF59D1E),
          ),
          onPressed: onToggleVisibility,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      cursorColor: const Color(0xFFF59D1E),
    );
  }
}

/// Custom painter to draw a flat rectangular background shape.
class FlatBackgroundPainter extends CustomPainter {
  final Color color;

  FlatBackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final Path path = Path();

    // The orange section appears to cover about 35% of the screen height.
    final double topSectionEndHeight = size.height * 0.35;

    // Start at the top-left corner
    path.moveTo(0, 0);
    // Line to the top-right corner
    path.lineTo(size.width, 0);
    // Line down to the bottom-right of the rectangle
    path.lineTo(size.width, topSectionEndHeight);
    // Line across to the bottom-left of the rectangle
    path.lineTo(0, topSectionEndHeight);
    // Close the path, connecting back to the top-left corner
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // The background shape is static.
  }
}