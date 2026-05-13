import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../../core/utils/snackbar_helper.dart';

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
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.local.profile_photo_optional,
          style: textTheme.titleSmall.copyWith(color: colors.title),
        ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: () => _pickImage(context),
            child: _buildPickerContainer(context, colors),
          ),
        ),
      ],
    );
  }

  Widget _buildPickerContainer(BuildContext context, dynamic colors) {
    return Container(
      width: 144,
      height: 112,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.stroke, width: 0.5),
      ),
      child: selectedImage == null
          ? _buildUploadPlaceholder()
          : _buildSelectedImage(context, colors),
    );
  }

  Widget _buildUploadPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppImages.upload,
          width: 48,
          height: 78,
          fit: BoxFit.scaleDown,
        ),
      ],
    );
  }

  Widget _buildSelectedImage(BuildContext context, dynamic colors) {
    return ClipRRect(
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
                      color: colors.uploadImageTint,
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
                      colors.onPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
        SnackBarHelper.showError(
          context,
          context.local.something_went_wrong,
        );
      }
    }
  }
}
