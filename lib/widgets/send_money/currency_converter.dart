import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CurrencyConverter extends StatelessWidget {

  const CurrencyConverter({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.conversionRate,
  });
  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double conversionRate;

  @override
  Widget build(BuildContext context) {
    final convertedAmount = amount * conversionRate;

    // Don't show converter if amount is 0
    if (amount <= 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.swap_horiz,
                color: AppColors.info,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Currency Conversion',
                style: TextStyle(
                  color: AppColors.info,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From: $fromCurrency',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${_getCurrencySymbol(fromCurrency)}${amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.info,
                size: 16,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'To: $toCurrency',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${_getCurrencySymbol(toCurrency)}${convertedAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Exchange Rate: 1 $fromCurrency = ${conversionRate.toStringAsFixed(4)} $toCurrency',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrencySymbol(String currency) {
    switch (currency) {
      case 'KES':
        return 'KSh';
      case 'USD':
        return r'$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      default:
        return currency;
    }
  }
}
