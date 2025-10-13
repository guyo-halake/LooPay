import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/send_money/recipient_picker.dart';
import '../../widgets/send_money/amount_input.dart';
import '../../widgets/send_money/currency_converter.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedRecipient = '';
  String _selectedPhoneNumber = '';
  double _amount = 0;
  String _selectedCurrency = 'KES';
  final String _convertedCurrency = 'USD';
  double _conversionRate = 0.0078;

  // Conversion rates (example rates)
  final Map<String, Map<String, double>> _conversionRates = {
    'KES': {
      'USD': 0.0078,
      'GBP': 0.0061,
      'EUR': 0.0072,
    },
    'USD': {
      'KES': 128.0,
      'GBP': 0.78,
      'EUR': 0.92,
    },
    'GBP': {
      'KES': 164.0,
      'USD': 1.28,
      'EUR': 1.18,
    },
    'EUR': {
      'KES': 139.0,
      'USD': 1.09,
      'GBP': 0.85,
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _updateConversionRate() {
    if (_conversionRates.containsKey(_selectedCurrency) &&
        _conversionRates[_selectedCurrency]!.containsKey(_convertedCurrency)) {
      setState(() {
        _conversionRate =
            _conversionRates[_selectedCurrency]![_convertedCurrency]!;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/dashboard'),
        ),
        title: const Text(
          'Send Money',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          tabs: const [
            Tab(text: 'Local (Kenya)'),
            Tab(text: 'International'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLocalTransfer(),
          _buildInternationalTransfer(),
        ],
      ),
    );

  Widget _buildLocalTransfer() => SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipient Picker
          RecipientPicker(
            selectedRecipient: _selectedRecipient,
            selectedPhoneNumber: _selectedPhoneNumber,
            onRecipientSelected: (name, phone) {
              setState(() {
                _selectedRecipient = name;
                _selectedPhoneNumber = phone;
              });
            },
          ),

          const SizedBox(height: 24),

          // Amount Input
          AmountInput(
            amount: _amount,
            currency: _selectedCurrency,
            onAmountChanged: (amount) {
              setState(() {
                _amount = amount;
              });
            },
            onCurrencyChanged: (currency) {
              setState(() {
                _selectedCurrency = currency;
                _updateConversionRate();
              });
            },
          ),

          const SizedBox(height: 24),

          // M-Pesa Note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.infoLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.info),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColors.info,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Money will be sent via M-Pesa to ${_selectedPhoneNumber.isNotEmpty ? _selectedPhoneNumber : 'selected recipient'}',
                    style: const TextStyle(
                      color: AppColors.info,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Send Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _canSend() ? _sendMoney : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Send Money',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );

  Widget _buildInternationalTransfer() => SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Country Selection
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: AppColors.textTertiary.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Send to Country',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.public,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'United Kingdom',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textTertiary,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Recipient Picker
          RecipientPicker(
            selectedRecipient: _selectedRecipient,
            selectedPhoneNumber: _selectedPhoneNumber,
            onRecipientSelected: (name, phone) {
              setState(() {
                _selectedRecipient = name;
                _selectedPhoneNumber = phone;
              });
            },
            isInternational: true,
          ),

          const SizedBox(height: 24),

          // Amount Input with Currency Converter
          AmountInput(
            amount: _amount,
            currency: _selectedCurrency,
            onAmountChanged: (amount) {
              setState(() {
                _amount = amount;
              });
            },
            onCurrencyChanged: (currency) {
              setState(() {
                _selectedCurrency = currency;
                _updateConversionRate();
              });
            },
          ),

          const SizedBox(height: 16),

          // Currency Converter
          CurrencyConverter(
            fromCurrency: _selectedCurrency,
            toCurrency: _convertedCurrency,
            amount: _amount,
            conversionRate: _conversionRate,
          ),

          const SizedBox(height: 24),

          // International Transfer Note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warningLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.warning),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_outlined,
                  color: AppColors.warning,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'International transfers may take 1-3 business days and include additional fees.',
                    style: const TextStyle(
                      color: AppColors.warning,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Send Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _canSend() ? _sendMoney : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Send Internationally',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );

  bool _canSend() => _selectedRecipient.isNotEmpty &&
        _selectedPhoneNumber.isNotEmpty &&
        _amount > 0;

  void _sendMoney() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Transfer'),
        content: Text(
          'Send $_selectedCurrency ${_amount.toStringAsFixed(2)} to $_selectedRecipient ($_selectedPhoneNumber)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              
              // Process transfer
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              await authProvider.addTransaction(
                type: 'sent',
                recipient: _selectedRecipient,
                amount: _amount,
                currency: _selectedCurrency,
              );
              
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Transfer completed successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
                
                // Navigate back to dashboard
                context.go('/dashboard');
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
