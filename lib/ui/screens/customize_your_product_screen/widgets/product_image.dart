import 'dart:io';
import 'package:flutter/material.dart';

class ProductImage extends StatefulWidget {
  final File? overlayImage;

  const ProductImage({super.key, this.overlayImage});

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  Offset overlayPosition = const Offset(100, 80);
  Size overlaySize = const Size(100, 100);
  bool isDragging = false;
  bool isResizing = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 260,
        color: Colors.grey[200],
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              'assets/images/product_3.webp',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            if (widget.overlayImage != null)
              Positioned(
                left: overlayPosition.dx,
                top: overlayPosition.dy,
                child: _buildDraggableOverlay(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableOverlay() {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          overlayPosition = Offset(
            overlayPosition.dx + details.delta.dx,
            overlayPosition.dy + details.delta.dy,
          );
        });
      },
      onPanStart: (_) {
        setState(() {
          isDragging = true;
        });
      },
      onPanEnd: (_) {
        setState(() {
          isDragging = false;
        });
      },
      child: Container(
        width: overlaySize.width,
        height: overlaySize.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF520826),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // The overlay image
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.file(
                    widget.overlayImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Corner handles (resizable)
            _buildResizableCorner(Alignment.topLeft),
            _buildResizableCorner(Alignment.topRight),
            _buildResizableCorner(Alignment.bottomLeft),
            _buildResizableCorner(Alignment.bottomRight),

            // Size label at bottom
            if (isDragging || isResizing)
              Positioned(
                bottom: -30,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B9AFF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${overlaySize.width.toInt()} × ${overlaySize.height.toInt()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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

  Widget _buildResizableCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: Offset(
          alignment.x * 8,
          alignment.y * 8,
        ),
        child: GestureDetector(
          onPanStart: (_) {
            setState(() {
              isResizing = true;
            });
          },
          onPanUpdate: (details) {
            setState(() {
              // Calculate new size based on which corner is being dragged
              double newWidth = overlaySize.width;
              double newHeight = overlaySize.height;
              double newX = overlayPosition.dx;
              double newY = overlayPosition.dy;

              // Horizontal resizing
              if (alignment.x > 0) {
                // Right side corners
                newWidth += details.delta.dx;
              } else {
                // Left side corners
                newWidth -= details.delta.dx;
                newX += details.delta.dx;
              }

              // Vertical resizing
              if (alignment.y > 0) {
                // Bottom corners
                newHeight += details.delta.dy;
              } else {
                // Top corners
                newHeight -= details.delta.dy;
                newY += details.delta.dy;
              }

              // Maintain minimum size
              if (newWidth >= 50 && newHeight >= 50) {
                overlaySize = Size(newWidth, newHeight);
                overlayPosition = Offset(newX, newY);
              }
            });
          },
          onPanEnd: (_) {
            setState(() {
              isResizing = false;
            });
          },
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFF520826),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}