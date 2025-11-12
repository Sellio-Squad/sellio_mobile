import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class ProfilePicturePicker extends StatefulWidget {
  final Function(File?) onImageSelected;
  final File? selectedImage;

  const ProfilePicturePicker({
    super.key,
    required this.onImageSelected,
    this.selectedImage,
  });

  @override
  State<ProfilePicturePicker> createState() => _ProfilePicturePickerState();
}

class _ProfilePicturePickerState extends State<ProfilePicturePicker> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      widget.onImageSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedImage = widget.selectedImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child:Text(
          'Profile photo (optional)',
          style: context.theme.typography.textTheme.titleSmall.copyWith(
            color: context.theme.colors.title,
          ),
        ),
        ),
        const SizedBox(height: 12),
        Center(
          child:
        GestureDetector(
          onTap: _pickImage,
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
                        Assets.upload,
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
                          selectedImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: context.theme.colors.uploadImageTint,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.pencilEdit,
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
}
