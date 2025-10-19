import 'package:flutter/material.dart';
import 'package:bathroom_app/Dashboard/notification.dart';

class NotificationPopup extends StatelessWidget {
  const NotificationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(), // Close when tapping outside
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        body: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent tap from closing popup
            child: Container(
              width: 350,
              constraints: const BoxConstraints(maxHeight: 500),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // TODO: Add clear logic here
                        },
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            color: Color.fromARGB(255, 26, 130, 195),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Expanded(child: NotificationArea()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
