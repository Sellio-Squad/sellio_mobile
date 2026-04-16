import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:design_system/design_system.dart';

class UploadLogoSection extends StatefulWidget {
  final Function(File?) onImageSelected;
  final File? selectedImage;

  const UploadLogoSection({
    super.key,
    required this.onImageSelected,
    this.selectedImage,
  });

  @override
  State<UploadLogoSection> createState() => _UploadLogoSectionState();
}

class _UploadLogoSectionState extends State<UploadLogoSection> {
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
        Text(
          context.local.upload_logo_or_image,
          style: context.theme.typography.textTheme.titleMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: context.theme.colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.theme.colors.disabled,
                width: 1,
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
                    borderRadius: BorderRadius.circular(12),
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
                              height: 40,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  const BoxShadow(
                                    color: Color(0x70000000),
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
      ],
    );
  }
}
