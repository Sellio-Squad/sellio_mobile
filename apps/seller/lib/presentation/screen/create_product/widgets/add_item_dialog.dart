import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/sellio_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../../../../domain/entity/product_item.dart';
import '../cubit/create_product_cubit.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  String? _selectedColorId;
  String? _selectedSizeId;

  @override
  void dispose() {
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Product Variant'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SellioTextField(
              controller: _priceController,
              hintText: 'Price',
              inputType: TextInputType.number,
            ),
            const Gap(12),
            SellioTextField(
              controller: _stockController,
              hintText: 'Stock Quantity',
              inputType: TextInputType.number,
            ),
            const Gap(12),
            SellioPickerField<String>(
              hintText: 'Select Color',
              items: const [
                SellioPickerItem('color-red', 'Red'),
                SellioPickerItem('color-blue', 'Blue'),
                SellioPickerItem('color-black', 'Black'),
              ],
              onChanged: (value) => setState(() => _selectedColorId = value),
            ),
            const Gap(12),
            SellioPickerField<String>(
              hintText: 'Select Size',
              items: const [
                SellioPickerItem('size-s', 'Small'),
                SellioPickerItem('size-m', 'Medium'),
                SellioPickerItem('size-l', 'Large'),
              ],
              onChanged: (value) => setState(() => _selectedSizeId = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        SellioButton(
          text: 'Add',
          onTap: () {
            final price = double.tryParse(_priceController.text) ?? 0.0;
            final stock = int.tryParse(_stockController.text) ?? 0;

            final item = ProductItem(
              price: price,
              stock: stock,
              colorId: _selectedColorId,
              sizeId: _selectedSizeId,
              weightId: 0,
            );

            context.read<CreateProductCubit>().addItem(item);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
