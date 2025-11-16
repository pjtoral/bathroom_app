import 'package:bathroom_app/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:bathroom_app/widgets/widgets.dart';
import 'package:bathroom_app/Dashboard/upload/upload_success.dart';

/// Final upload step for adding a review, star rating and tags.
///
/// This widget is controlled by the parent page; it stores the review text in
/// [reviewController] and exposes the current integer [rating].
class ThirdUploadPage extends StatefulWidget {
  const ThirdUploadPage({Key? key}) : super(key: key);

  @override
  State<ThirdUploadPage> createState() => ThirdUploadPageState();
}

class ThirdUploadPageState extends State<ThirdUploadPage> {
  /// Current selected rating (1..5).
  int rating = 2;

  /// Controller for the review text field.
  final TextEditingController reviewController = TextEditingController();

  final List<String> tags = [
    'Test',
    'Bidet',
    'Soap',
    'Clean',
    'Dog water',
    'LGBT-friendly',
  ];

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar row, centered
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 130, 195),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 130, 195),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 130, 195),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 26, 130, 195),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Review',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

              // Stars row -> replaced with StarRating widget (controlled)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StarRating(
                    rating: rating,
                    onChanged: (v) {
                      setState(() {
                        rating = v;
                      });
                    },
                    size: 32,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Review input
              TextField(
                controller: reviewController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Write your review here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Tags Title
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Tags',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

              // Tags input/search (no functionality for search)
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.tag, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Search for tags to add',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Tags list - wrap to next line if overflow
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: tags.map((tag) => TagWidget(text: tag)).toList(),
                  ),
                ),
              ),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const UploadSuccessPage(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 26, 130, 195),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
