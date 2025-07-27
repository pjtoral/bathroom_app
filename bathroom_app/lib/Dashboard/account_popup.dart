import 'package:flutter/material.dart';
import 'package:bathroom_app/Dashboard/upload.dart';

class AccountPopup extends StatelessWidget {
  const AccountPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // User info row
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF29C1F), // orange circle
                  shape: BoxShape.circle,
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
                      style: TextStyle(fontSize: 14, color: Colors.grey),
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
          const SizedBox(height: 20),

          // Options list with dividers
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionTile(
                  context,
                  icon: Icons.edit_outlined,
                  label: 'Edit Account',
                  iconColor: Colors.black,
                  onTap: () {
                    Navigator.of(context).pop();
                    // Add your edit account logic here
                  },
                ),
                const Divider(height: 1),
                _buildOptionTile(
                  context,
                  icon: Icons.upload_outlined,
                  label: 'Upload',
                  iconColor: Colors.black,
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UploadPage(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                _buildOptionTile(
                  context,
                  icon: Icons.logout_outlined,
                  label: 'Logout',
                  iconColor: Colors.red,
                  onTap: () {
                    Navigator.of(context).pop();
                    // Add your logout logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
