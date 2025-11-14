import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../models/contact_info.dart';

class ContactInfoItem extends StatelessWidget {
  final ContactInfo contactInfo;
  final Function() onTap;

  const ContactInfoItem({
    super.key,
    required this.contactInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.theme.colors.primaryVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 40,
            width: 40,
            child: Center(
              child: SvgPicture.asset(contactInfo.icon, width: 24, height: 24),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contactInfo.title,
                  style: context.theme.typography.textTheme.bodySmall.copyWith(
                    color: context.theme.colors.body,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  contactInfo.provider,
                  style: context.theme.typography.textTheme.labelMedium
                      .copyWith(color: context.theme.colors.title),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
