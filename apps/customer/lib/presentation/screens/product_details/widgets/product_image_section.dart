import 'package:flutter/material.dart';

Widget productImagesSection() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 110,
                height: 110,
                color: Colors.grey[200],
                child: Image.asset(
                  'assets/images/lemon_popsicle.jpg',
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 110,
                height: 110,
                color: Colors.grey[200],
                child: Image.asset(
                  'assets/images/lemon_cheesecake.jpg',
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 224,
              color: Colors.grey[200],
              child: Image.asset(
                'assets/images/lemon_cake_main.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 60,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
