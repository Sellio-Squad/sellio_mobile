import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/presentation/screens/store_details/about_store/widgets/store_map_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/localization/l10n/localization_service.dart';

class AddressItem extends StatelessWidget {
  final String address;
  final double? latitude;
  final double? longitude;
  final String? storeName;

  const AddressItem({
    super.key,
    required this.address,
    this.latitude,
    this.longitude,
    this.storeName,
  });

  bool get _hasLocation =>
      latitude != null && longitude != null && storeName != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.local.address,
            style: context.theme.typography.textTheme.titleMedium.copyWith(
              color: context.theme.colors.title,
            ),
          ),
          GestureDetector(
            onTap: () => _openMap(latitude!, longitude!, storeName!),
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
                    child: SvgPicture.asset(
                      AppImages.pinLocation,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    address,
                    style: context.theme.typography.textTheme.labelMedium
                        .copyWith(color: context.theme.colors.body),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (_hasLocation) ...[
            const SizedBox(height: 8),
            StoreMapView(
              latitude: latitude!,
              longitude: longitude!,
              storeName: storeName!,
              onTap: () => _openMap(latitude!, longitude!, storeName!),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openMap(
    double latitude,
    double longitude,
    String storeName,
  ) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
