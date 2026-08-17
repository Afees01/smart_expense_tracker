import 'package:file_picker/file_picker.dart';
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

import 'package:smart_expense_tracker/features/transactions/data/models/transaction_model.dart';
import 'package:smart_expense_tracker/shared/widgets/wealthflow_app_bar.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({
    super.key,
  });

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _isExpense = true;

  String? _selectedCategory;
  DateTime? _selectedDate;

  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  final _descriptionController = TextEditingController();

  PlatformFile? selectedReceipt;

  final List<String> _categories = [
    'Shopping',
    'Food',
    'Dining',
    'Transport',
    'Rent',
    'Entertainment',
    'Health',
    'Bills',
    'Salary',
    'Investment',
    'Education',
    'Travel',
    'Freelance',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  // ============================================================
  // DATE
  // ============================================================

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // ============================================================
  // SAVE
  // ============================================================

  void _saveTransaction() {
    final title = _titleController.text.trim();

    final subtitle = _descriptionController.text.trim();

    final amount = double.tryParse(
          _amountController.text.trim(),
        ) ??
        0.0;

    final category = _selectedCategory ?? 'Other';

    final date = _selectedDate ?? DateTime.now();

    // -----------------------------
    // Validate title
    // -----------------------------

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Enter a transaction title',
          ),
        ),
      );

      return;
    }

    // -----------------------------
    // Validate amount
    // -----------------------------

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Enter a valid amount',
          ),
        ),
      );

      return;
    }

    // -----------------------------
    // Create model
    // -----------------------------

    final transaction = TransactionModel(
      // Backend will generate ID
      id: 0,

      title: title,

      subtitle: subtitle.isEmpty ? 'New transaction' : subtitle,

      amount: amount,

      type: _isExpense ? TransactionType.expense : TransactionType.income,

      date: date,

      category: category,
    );

    // -----------------------------
    // Send to BLoC
    // -----------------------------

    context.read<TransactionBloc>().add(
          AddTransaction(
            transaction,
          ),
        );

    // -----------------------------
    // Clear form
    // -----------------------------

    _titleController.clear();
    _amountController.clear();
    _descriptionController.clear();

    setState(() {
      _selectedCategory = null;
      _selectedDate = null;
      _isExpense = true;
      selectedReceipt = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Transaction saved',
        ),
      ),
    );
  }

  // ============================================================
  // RECEIPT
  // ============================================================

  Future<void> filePickerDemo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
      ],
    );

    if (result != null) {
      setState(() {
        selectedReceipt = result.files.single;
      });
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

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
            // TYPE

            TransactionTypeToggle(
              isExpense: _isExpense,
              onToggle: (value) {
                setState(() {
                  _isExpense = value;
                });
              },
            ),

            const SizedBox(
              height: AppSpacing.stackLg,
            ),

            // FORM CARD

            Container(
              padding: const EdgeInsets.all(
                AppSpacing.stackLg,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(
                  12,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE

                  _FormField(
                    label: 'Title',
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'e.g. Coffee Shop',
                        filled: true,
                        fillColor: AppColors.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          borderSide: const BorderSide(
                            color: AppColors.outlineVariant,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.stackMd,
                  ),

                  // AMOUNT

                  Center(
                    child: AmountInputField(
                      controller: _amountController,
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.stackLg,
                  ),

                  // CATEGORY + DATE

                  Row(
                    children: [
                      Expanded(
                        child: _FormField(
                          label: 'Category',
                          child: DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            hint: const Text(
                              'Select Category',
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.surfaceContainerLow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ),
                              ),
                            ),
                            items: _categories.map(
                              (
                                category,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(
                                    category,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: AppSpacing.stackMd,
                      ),
                      Expanded(
                        child: _FormField(
                          label: 'Date',
                          child: GestureDetector(
                            onTap: _pickDate,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(
                                  8,
                                ),
                                border: Border.all(
                                  color: AppColors.outlineVariant,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedDate != null
                                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                          : 'Select Date',
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: AppSpacing.stackMd,
                  ),

                  // DESCRIPTION

                  _FormField(
                    label: 'Description',
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'What was this for?',
                        filled: true,
                        fillColor: AppColors.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.stackMd,
                  ),

                  // RECEIPT

                  ReceiptUploadArea(
                    onTap: filePickerDemo,
                    fileName: selectedReceipt?.name,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: AppSpacing.stackLg,
            ),

            // SAVE BUTTON

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveTransaction,
                icon: const Icon(
                  Icons.check_circle,
                ),
                label: const Text(
                  'Save Transaction',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// FORM FIELD
// ============================================================

class _FormField extends StatelessWidget {
  final String label;
  final Widget child;

  const _FormField({
    required this.label,
    required this.child,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        child,
      ],
    );
  }
}
