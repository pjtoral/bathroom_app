import 'package:flutter/material.dart';
import 'package:bathroom_app/Dashboard/account_popup.dart';

class AccountIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => const AccountPopup(),
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main account icon
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 255, 182, 98),
              radius: 28,
              child: Icon(
                Icons.account_circle,
                color: const Color.fromARGB(255, 255, 255, 255),
                size: 40,
              ),
            ),

            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                child: const Center(
                  child: Text(
                    '1', // hardcoded for the mean time (notif number)
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
