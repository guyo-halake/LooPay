import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeroCard extends StatelessWidget {

  const HeroCard({
    super.key,
    required this.card,
    required this.isVisible,
    required this.onToggleVisibility,
    required this.onCurrencyTap,
    required this.selectedCurrency,
    required this.conversionRates,
  });
  final Map<String, dynamic> card;
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onCurrencyTap;
  final String selectedCurrency;
  final Map<String, double> conversionRates;

  @override
  Widget build(BuildContext context) {
    final baseCurrency = card['currency'] as String? ?? 'KES';
    final baseBalance = (card['balance'] as num).toDouble();
    final baseToKes =
        conversionRates[baseCurrency] ?? 1.0; // assume KES baseline
    final selectedRate = conversionRates[selectedCurrency] ?? 1.0;
    // Convert from base -> KES -> selected
    final balanceInSelected = (baseBalance / baseToKes) * selectedRate;

    final currencySymbol = <String, String>{
      'KES': 'KSh ',
      'USD': r'$',
      'GBP': '£',
      'EUR': '€',
    };
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: currencySymbol[selectedCurrency] ?? '',
    );

    final currencyFlag = <String, String>{
      'KES': '🇰🇪',
      'USD': '🇺🇸',
      'GBP': '🇬🇧',
      'EUR': '🇪🇺',
    };

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.92),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card['name'],
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      card['type'] == 'mpesa' ? 'Mobile Money' : 'Bank Account',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onCurrencyTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4,),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          children: [
                            Text(currencyFlag[selectedCurrency] ?? '',
                                style: const TextStyle(fontSize: 12),),
                            const SizedBox(width: 6),
                            Text(
                              selectedCurrency,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onToggleVisibility,
                      child: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            // Balance
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Balance',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                if (isVisible)
                  Text(
                    formatter.format(balanceInSelected),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  Container(
                    height: 28,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
              ],
            ),

            const Spacer(),

            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Secure',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (card['type'] == 'mpesa')
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'M-Pesa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
