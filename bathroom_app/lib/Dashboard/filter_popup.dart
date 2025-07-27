import 'package:flutter/material.dart';

class FilterPopup extends StatelessWidget {
  const FilterPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filter',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Align(alignment: Alignment.centerLeft, child: Text('Sort by')),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: 'None',
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD9D9D9),
            ),
            items: const [
              DropdownMenuItem(value: 'None', child: Text('None')),
              // Add more sorting options here if needed
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Include tags'),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: 'None',
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFD9D9D9),
            ),
            items: const [
              DropdownMenuItem(value: 'None', child: Text('None')),
              // Add more tag options here if needed
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 200),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF29C1F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Apply',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
