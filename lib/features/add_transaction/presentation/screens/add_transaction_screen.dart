import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/core/constants/app_spacing.dart';
import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';
import 'package:smart_expense_tracker/features/add_transaction/widgets/amount_input_field.dart';
import 'package:smart_expense_tracker/features/add_transaction/widgets/receipt_upload_area.dart';
import 'package:smart_expense_tracker/features/add_transaction/widgets/transaction_type_toggle.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:smart_expense_tracker/shared/models/transaction_model.dart';
import 'package:smart_expense_tracker/shared/widgets/wealthflow_app_bar.dart';


class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _isExpense = true;
  String? _selectedCategory;
  DateTime? _selectedDate;
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _categories = [
    'Shopping',
    'Food & Dining',
    'Transportation',
    'Housing',
    'Entertainment',
    'Healthcare',
    'Income',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.onPrimary,
              surface: AppColors.surface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WealthFlowAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.marginMobile,
          vertical: AppSpacing.stackMd,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TransactionTypeToggle(
              isExpense: _isExpense,
              onToggle: (v) => setState(() => _isExpense = v),
            ),
            const SizedBox(height: AppSpacing.stackLg),

            // Form card
            Container(
              padding: const EdgeInsets.all(AppSpacing.stackLg),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount
                  Center(
                    child: AmountInputField(controller: _amountController),
                  ),
                  const SizedBox(height: AppSpacing.stackLg),

                  // Category + Date row
                  Row(
                    children: [
                      Expanded(
                        child: _FormField(
                          label: 'Category',
                          child: DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            hint: Text(
                              'Select Category',
                              style: AppTextStyles.bodyMd.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.outlineVariant),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.outlineVariant),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: AppColors.primaryContainer, width: 1.5,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.surfaceContainerLow,
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.onSurfaceVariant),
                            items: _categories.map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(c, style: AppTextStyles.bodyMd),
                            )).toList(),
                            onChanged: (v) => setState(() => _selectedCategory = v),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.stackMd),
                      Expanded(
                        child: _FormField(
                          label: 'Date',
                          child: GestureDetector(
                            onTap: _pickDate,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.outlineVariant),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedDate != null
                                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                          : 'Select Date',
                                      style: AppTextStyles.bodyMd.copyWith(
                                        color: _selectedDate != null
                                            ? AppColors.onSurface
                                            : AppColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 18,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.stackMd),

                  // Description
                  _FormField(
                    label: 'Description',
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 2,
                      style: AppTextStyles.bodyMd,
                      decoration: InputDecoration(
                        hintText: 'What was this for?',
                        hintStyle: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primaryContainer, width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.surfaceContainerLow,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.stackMd),

                  const ReceiptUploadArea(),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.stackLg),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final amount = double.tryParse(_amountController.text) ?? 0.0;
                  final category = _selectedCategory ?? 'Other';
                  final date = _selectedDate ?? DateTime.now();
                  final description = _descriptionController.text.trim();
                  if (amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter a valid amount')),
                    );
                    return;
                  }

                  final transaction = TransactionModel(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    title: category,
                    subtitle: description.isEmpty ? 'New transaction' : description,
                    amount: amount,
                    type: _isExpense ? TransactionType.expense : TransactionType.income,
                    date: date,
                    category: category,
                    icon: TransactionModel.iconForCategory(category),
                  );
                  context.read<TransactionBloc>().add(AddTransaction(transaction));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transaction saved')),
                  );
                  setState(() {
                    _amountController.clear();
                    _descriptionController.clear();
                    _selectedCategory = null;
                    _selectedDate = null;
                    _isExpense = true;
                  });
                },
                icon: const Icon(Icons.check_circle, size: 22),
                label: const Text('Save Transaction'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: AppTextStyles.headlineMd,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final Widget child;

  const _FormField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
