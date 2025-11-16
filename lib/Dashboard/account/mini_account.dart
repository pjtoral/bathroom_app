import 'package:flutter/material.dart';

class AccountPopup extends StatelessWidget {
  final VoidCallback onTapOutside;

  const AccountPopup({super.key, required this.onTapOutside});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onTapOutside,
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Prevent tap dismissal inside popup
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.78,
                  maxHeight: screenHeight * 1,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize:
                        MainAxisSize.min, // Important for natural height
                    children: [
                      // Top row with avatar, name/email, and bell icon
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color.fromARGB(255, 26, 130, 195),
                            radius: 28,
                            child: Icon(
                              Icons.account_circle,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              size: 40,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Lorem Ipsum Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'sample@email.com',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.notifications_none,
                            size: 32,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      const Text(
                        'hello, heres my bio. blah blah',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
