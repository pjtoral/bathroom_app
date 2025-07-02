import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The data model for the verification screen, managing the verification code
/// and the state of the error message.
class VerificationData extends ChangeNotifier {
  String _verificationCode = '';
  bool _isCodeInvalid = false;

  String get verificationCode => _verificationCode;
  bool get isCodeInvalid => _isCodeInvalid;

  /// Sets the verification code and clears the invalid state if it was previously set.
  void setCode(String value) {
    if (_verificationCode != value) {
      _verificationCode = value;
      // Reset invalid state when user starts typing again
      if (_isCodeInvalid) {
        _isCodeInvalid = false;
      }
      notifyListeners();
    }
  }

  /// Sets the invalid code state, triggering a UI update.
  void setIsCodeInvalid(bool value) {
    if (_isCodeInvalid != value) {
      _isCodeInvalid = value;
      notifyListeners();
    }
  }

  /// Simulates the verification process. Toggles the invalid state for demonstration.
  void verifyCode() {
    // In a real application, this would involve sending the _verificationCode
    // to a backend service and updating _isCodeInvalid based on the response.
    _isCodeInvalid = !_isCodeInvalid; // Toggle for demonstration purposes
    notifyListeners();
  }

  /// Simulates resending the verification code.
  void resendCode() {
    // In a real application, this would trigger an API call to resend the code.
    // For this example, we clear the current code and reset the invalid state.
    debugPrint('Resending code...');
    _verificationCode = ''; // Clear the input field
    _isCodeInvalid = false; // Reset error message
    notifyListeners();
  }
}

/// A custom painter to draw the background with a flat orange top and white bottom.
class WavyBackgroundPainter extends CustomPainter {
  final Color backgroundColor;

  WavyBackgroundPainter({
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = backgroundColor;
    final Paint whitePaint = Paint()..color = Colors.white;

    // Define the height for the flat top edge, making the orange part 30% of the screen height.
    final double flatTopHeight = size.height * 0.30;

    // 1. Draw the main orange background up to the flatTopHeight.
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, flatTopHeight), paint);

    // 2. Draw the flat white rectangle shape on top of the orange background, starting from flatTopHeight.
    final Path flatPath = Path();
    flatPath.moveTo(0, flatTopHeight); // Start at the left edge, at the defined height.
    flatPath.lineTo(size.width, flatTopHeight); // Draw a straight line to the right edge.
    flatPath.lineTo(size.width, size.height); // Go to bottom-right.
    flatPath.lineTo(0, size.height); // Go to bottom-left.
    flatPath.close(); // Close the path to form a solid rectangle.

    canvas.drawPath(flatPath, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Return false as the background is static and doesn't need to repaint unless properties change.
    return false;
  }
}

/// The main screen for code verification, displaying the UI from the image.
class CodeVerificationScreen extends StatelessWidget {
  const CodeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold background color is white, but the CustomPaint will cover it.
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          // The custom painter for the wavy background and dots.
          // It fills the entire stack space, drawing the orange and then the white wave.
          CustomPaint(
            painter: WavyBackgroundPainter(
              backgroundColor: const Color(0xFFFC9D01), // Bright orange color for the background
            ),
            child: Container(), // An empty child as the painter handles drawing.
          ),
          // Content for the screen, positioned on top of the background.
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Spacer to push the content down below the orange section, into the white area.
                  SizedBox(height: MediaQuery.of(context).size.height * 0.32),
                  const Text(
                    'Almost there!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900, // Extra bold for emphasis
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 16.0,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Check your inbox! Enter the code below; '
                              'the code expires in 30 minutes (make sure to check ',
                        ),
                        TextSpan(
                          text: 'spam',
                          style: TextStyle(
                            color: Color(0xFFFC9D01), // Orange color for "spam"
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: ' folder).',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Consumer<VerificationData>(
                    builder: (BuildContext context, VerificationData verificationData, Widget? child) {
                      return Column(
                        children: <Widget>[
                          Visibility(
                            visible: verificationData.isCodeInvalid,
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Invalid code! :(',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          TextField(
                            // Using TextEditingController directly in builder; updates automatically
                            // when verificationData.verificationCode changes due to notifyListeners().
                            controller: TextEditingController(
                                text: verificationData.verificationCode),
                            onChanged: (String value) =>
                                verificationData.setCode(value),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'XXXX-XXXX',
                              hintStyle: const TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFFC9D01), // Orange border
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFFC9D01), // Orange border when focused
                                  width: 2.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24.0),
                  Consumer<VerificationData>(
                    builder: (BuildContext context, VerificationData verificationData, Widget? child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Did not receive code?! ',
                            style: TextStyle(color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: () => verificationData.resendCode(),
                            child: const Text(
                              'Resend',
                              style: TextStyle(
                                color: Color(0xFFFC9D01), // Orange for "Resend"
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 32.0),
                  Consumer<VerificationData>(
                    builder: (BuildContext context, VerificationData verificationData, Widget? child) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => verificationData.verifyCode(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFC9D01), // Orange button
                            padding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 0, // No shadow for a flat look
                          ),
                          child: const Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Back arrow button positioned at the top-left.
          Positioned(
            top: 40.0,
            left: 20.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  // This callback would typically handle navigation back.
                  debugPrint('Back button pressed');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VerificationData>(
      create: (BuildContext context) => VerificationData(),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Hide the debug banner
          theme: ThemeData(
            primarySwatch: Colors.orange, // Define a primary color for the app
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Roboto', // Use Roboto as the default font
          ),
          home: const CodeVerificationScreen(),
        );
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}