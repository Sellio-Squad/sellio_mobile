import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:design_system/design_system.dart';

import 'package:design_system/design_system.dart';

class ProfilePicturePickerWidget extends StatelessWidget {
  final Function(File?) onImageSelected;
  final File? selectedImage;

  const ProfilePicturePickerWidget({
    super.key,
    required this.onImageSelected,
    this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
            'Profile photo (optional)',
            style: context.theme.typography.textTheme.titleSmall.copyWith(
              color: context.theme.colors.title,
            ),
          ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: () => _pickImage(context),
            child: Container(
              width: 144,
              height: 112,
              decoration: BoxDecoration(
                color: context.theme.colors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.theme.colors.stroke,
                  width: 0.5,
                ),
              ),
              child: selectedImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.upload,
                          width: 48,
                          height: 78,
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _pickImage(context),
                              child: Container(
                                height: 32,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          context.theme.colors.uploadImageTint,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppImages.pencilEdit,
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      context.theme.colors.onPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        onImageSelected(File(image.path));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: ${e.toString()}'),
            backgroundColor: context.theme.colors.red,
          ),
        );
      }
    }
  }
}
