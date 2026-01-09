import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return SellioBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.local.filter,
            style: context.theme.typography.textTheme.titleMedium
                .copyWith(color: context.theme.colors.title),
          ),
          Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SellioChip(
                label: context.local.all,
                onTap: (){
                  setState(() {
                    _selectedFilter = 'all';
                  });
                }, selected: _selectedFilter == 'all',
                padding: EdgeInsetsDirectional.only(start: 10, end: 10, top: 10, bottom: 10),
              ),
              Gap(8),
              SellioChip(
                label: context.local.near_by_you,
                selected: _selectedFilter == 'near_by_you',
                onTap: (){
                  setState(() {
                    _selectedFilter = 'near_by_you';
                  });
                },
                padding: EdgeInsetsDirectional.only(start: 10, end: 10, top: 10, bottom: 10),
              ),
              Gap(8),
              SellioChip(
                label: context.local.high_rating,
                selected: _selectedFilter == 'high_rating',
                onTap: (){
                  setState(() {
                    _selectedFilter = 'high_rating';
                  });
                },
                padding: EdgeInsetsDirectional.only(start: 10, end: 10, top: 10, bottom: 10),
              ),
            ],
          ),
          Gap(24),
          SellioButton(text: context.local.save, textStyle: context.theme.typography.textTheme.labelMedium
              .copyWith(color: context.theme.colors.onPrimary),
          ),
        ],
      ),
    );
  }
}
