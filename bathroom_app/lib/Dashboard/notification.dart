import 'package:flutter/material.dart';

class NotificationArea extends StatelessWidget {
  const NotificationArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: const [
              NotificationAreaItem(
                title: 'Your upload has been approved!',
                subtitle:
                    'Your upload with the location named “The walk” has passed our community guidelines and has now been approved. “The Walk” can now be viewed and reviewed by other users. Thank you for your contribution!',
                isNew: true,
                date: 'today',
              ),
              NotificationAreaItem(
                title: 'You have already seen this notif',
                subtitle:
                    'just a template if the user already seen this notif.',
                isNew: false,
                date: '06/19/25',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NotificationAreaItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isNew;
  final String date;

  const NotificationAreaItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isNew,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, color: isNew ? Colors.red : Colors.grey, size: 10),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
