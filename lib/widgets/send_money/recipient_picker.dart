import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class RecipientPicker extends StatelessWidget {

  const RecipientPicker({
    super.key,
    required this.selectedRecipient,
    required this.selectedPhoneNumber,
    required this.onRecipientSelected,
    this.isInternational = false,
  });
  final String selectedRecipient;
  final String selectedPhoneNumber;
  final Function(String name, String phone) onRecipientSelected;
  final bool isInternational;

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textTertiary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_outline,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isInternational
                    ? 'International Recipient'
                    : 'Select Recipient',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (selectedRecipient.isEmpty)
            _buildRecipientOptions(context)
          else
            _buildSelectedRecipient(context),
        ],
      ),
    );

  Widget _buildRecipientOptions(BuildContext context) => Column(
      children: [
        // Select from contacts
        _buildOptionTile(
          context,
          icon: Icons.contacts,
          title: 'Select from Contacts',
          subtitle: 'Choose from your phone contacts',
          onTap: () => _showContactsDialog(context),
        ),
        const SizedBox(height: 12),
        // Enter manually
        _buildOptionTile(
          context,
          icon: Icons.edit,
          title: 'Enter Manually',
          subtitle: 'Type name and phone number',
          onTap: () => _showManualEntryDialog(context),
        ),
      ],
    );

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.textTertiary.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textTertiary,
              size: 16,
            ),
          ],
        ),
      ),
    );

  Widget _buildSelectedRecipient(BuildContext context) => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.success),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedRecipient,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  selectedPhoneNumber,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onRecipientSelected('', ''),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.error,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );

  void _showContactsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Contact'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView(
            children: [
              _buildContactTile(context, 'John Mwangi', '+254712345678'),
              _buildContactTile(context, 'Mary Wanjiku', '+254723456789'),
              _buildContactTile(context, 'Peter Kimani', '+254734567890'),
              _buildContactTile(context, 'Jane Muthoni', '+254745678901'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactTile(BuildContext context, String name, String phone) => ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: Text(
          name[0],
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(name),
      subtitle: Text(phone),
      onTap: () {
        Navigator.pop(context);
        onRecipientSelected(name, phone);
      },
    );

  void _showManualEntryDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Recipient Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty) {
                Navigator.pop(context);
                onRecipientSelected(nameController.text, phoneController.text);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
