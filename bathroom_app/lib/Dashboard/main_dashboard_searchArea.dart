import 'package:flutter/material.dart';

class DraggablePanel extends StatelessWidget {
  const DraggablePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1, // collapsed height
      minChildSize: 0.1,
      maxChildSize: 0.9, // expanded height
      builder: (context, scrollController) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 10),
              ],
            ),
            child: ListView(
              controller: scrollController,
              children: const [
                SizedBox(height: 12),
                Center(
                  child: Icon(Icons.drag_handle, color: Colors.grey),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}