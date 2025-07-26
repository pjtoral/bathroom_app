import 'package:flutter/material.dart';

class PlaceInfo extends StatefulWidget {
  final Map<String, dynamic> placeData;

  const PlaceInfo({Key? key, required this.placeData}) : super(key: key);

  @override
  State<PlaceInfo> createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  int _currentPhoto = 0;

  @override
  Widget build(BuildContext context) {
    final features = widget.placeData['features'] as List<String>? ?? [];
    final photosList = widget.placeData['photosList'] as List? ?? [];
    final reviewsList = widget.placeData['reviewsList'] as List? ?? [];
    final rating = widget.placeData['rating'] ?? 4.93;
    final reviewsCount = widget.placeData['reviews'] ?? 30;

    void openGallery() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feature Coming Soon')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.orange),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Top image
          Container(
            height: 160,
            width: double.infinity,
            color: Colors.grey[300],
            child: Center(
              child: Icon(Icons.image, size: 80, color: Colors.grey[500]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Place name and status
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.placeData['title'] ?? 'Place Name',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.placeData['status'] ?? 'Negative',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.placeData['address'] ?? 'Address not available',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                // Feature tags
                Wrap(
                  spacing: 8,
                  children: features.map((f) => Chip(
                    label: Text(f, style: const TextStyle(color: Colors.white)),
                    backgroundColor: Colors.orange,
                  )).toList(),
                ),
                const SizedBox(height: 16),
                // Photos section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Photos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    TextButton(
                      onPressed: openGallery,
                      child: const Text('see all', style: TextStyle(color: Colors.orange)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 110,
                  child: PageView.builder(
                    itemCount: photosList.length,
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (idx) => setState(() => _currentPhoto = idx),
                    itemBuilder: (context, idx) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 110,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(Icons.image, size: 40, color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Reviews section
                const Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      rating.toStringAsFixed(2),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 120,
                          height: 8,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 4),
                        Text('out of 5\n($reviewsCount reviews)', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Example review cards
                ...reviewsList.map((review) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange[200],
                      child: Text(
                        (review['author'] ?? 'U')[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(review['author'] ?? 'User'),
                        const SizedBox(width: 8),
                        Row(
                          children: List.generate(
                            review['rating'] ?? 5,
                            (i) => const Icon(Icons.star, color: Colors.amber, size: 16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(review['date'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    subtitle: Text(review['text'] ?? ''),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 120,
                          height: 8,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 4),
                        Text('out of 5\n($reviewsCount reviews)', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Example review cards
                ...reviewsList.map((review) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange[200],
                      child: Text(
                        (review['author'] ?? 'U')[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(review['author'] ?? 'User'),
                        const SizedBox(width: 8),
                        Row(
                          children: List.generate(
                            review['rating'] ?? 5,
                            (i) => const Icon(Icons.star, color: Colors.amber, size: 16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(review['date'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    subtitle: Text(review['text'] ?? ''),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
