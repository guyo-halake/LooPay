import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/dashboard/hero_card.dart';
import '../../widgets/dashboard/quick_action_button.dart';
import '../../widgets/dashboard/transaction_list_item.dart';

enum FavoriteType { paybill, buyGoods, sendMoney }

class FavoritePin {
  // Account number (for paybill)

  const FavoritePin({
    required this.type,
    required this.name,
    required this.primary,
    this.secondary,
  });
  final FavoriteType type;
  final String name; // Display name of receiver
  final String primary; // Paybill or Till or Phone Number
  final String? secondary;
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _heroCardController = PageController();
  int _currentCardIndex = 0;
  bool _balanceVisible = true;
  String _selectedCurrency = 'KES';
  final List<FavoritePin> _favorites = [];

  List<Map<String, dynamic>> _heroCards = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadTransactions();
  }

  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;

    if (user != null) {
      setState(() {
        _heroCards = [
          {
            'type': 'mpesa',
            'name': 'M-Pesa',
            'balance': user.balance,
            'currency': 'KES',
            'gradient': [
              AppColors.accent.withOpacity(0.8),
              AppColors.accentLight.withOpacity(0.6),
            ],
          },
        ];
      });
    }
  }

  final List<Map<String, dynamic>> _quickActions = [
    {
      'icon': Icons.send_rounded,
      'title': 'Send Money',
      'subtitle': 'Local & International',
      'color': AppColors.primary,
      'route': '/send-money',
    },
    {
      'icon': Icons.receipt_long,
      'title': 'Pay Bill',
      'subtitle': 'Pay Bills both locally and internationally',
      'color': AppColors.accent,
      'route': '/pay-bill',
    },
    {
      'icon': Icons.store,
      'title': 'Lipa na M-Pesa',
      'subtitle': 'Buy Goods & Services',
      'color': AppColors.info,
      'route': '/lipa-mpesa',
    },
    {
      'icon': Icons.phone_android,
      'title': 'Buy Airtime',
      'subtitle': 'For Self & Others',
      'color': AppColors.warning,
      'route': '/buy-airtime',
    },
    {
      'icon': Icons.currency_bitcoin,
      'title': 'Crypto',
      'subtitle': 'Coming soon',
      'color': AppColors.textSecondary,
      'route': '/crypto',
    },
    {
      'icon': Icons.savings,
      'title': 'Savings & Goals',
      'subtitle': 'Coming Soon',
      'color': AppColors.success,
      'route': '/savings-goals',
    },
    {
      'icon': Icons.group,
      'title': 'Split w/ Friends',
      'subtitle': 'Split Bills',
      'color': AppColors.error,
      'route': '/split-friends',
    },
    {
      'icon': Icons.account_balance,
      'title': 'Bank Transfers',
      'subtitle': 'Link Bank Accounts',
      'color': AppColors.primary,
      'route': '/bank-transactions',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Excahnge rates relative to Ksh. Connetc Api later
    final fxRatesToKes = <String, double>{
      'KES': 1.0,
      'USD': 130.0,
      'GBP': 165.0,
      'EUR': 140.0,
    };
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : AppColors.background,
      drawerEdgeDragWidth: 120,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0.5,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(ctx).removeCurrentSnackBar();
              Scaffold.of(ctx).openDrawer();
            },
          ),
        ),
        title: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Text(
            'Hello, ${authProvider.userName?.split(' ').first ?? 'User'}',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: Open notifications
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: isDark
                  ? [const Color(0xFF0B0B0B), const Color(0xFF111111)]
                  : [const Color(0xFFF8FAFC), const Color(0xFFF1F5F9)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Cards
              SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: _heroCardController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentCardIndex = index;
                    });
                  },
                  itemCount: _heroCards.length,
                  itemBuilder: (context, index) {
                    return HeroCard(
                      card: _heroCards[index],
                      isVisible: _balanceVisible,
                      onToggleVisibility: () {
                        setState(() {
                          _balanceVisible = !_balanceVisible;
                        });
                      },
                      onCurrencyTap: () {
                        _showCurrencySelector();
                      },
                      selectedCurrency: _selectedCurrency,
                      conversionRates: fxRatesToKes,
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Page Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    _heroCards.length,
                    (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentCardIndex == index ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentCardIndex == index
                                ? AppColors.primary
                                : AppColors.textTertiary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        )),
              ),

              const SizedBox(height: 16),

              // Quick Actions (3x3 Grid)
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _quickActions.length,
                itemBuilder: (context, index) {
                  final action = _quickActions[index];
                  return QuickActionButton(
                    icon: action['icon'],
                    title: action['title'],
                    subtitle: action['subtitle'],
                    color: action['color'],
                    onTap: () {
                      context.go(action['route']);
                    },
                  );
                },
              ),

              const SizedBox(height: 16),

              // Favorites & Pins
              Text(
                'Favorites & Pins',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (final fav in _favorites)
                            GestureDetector(
                              onTap: () => _startQuickPay(context, fav),
                              child: _favoritePill(
                                icon: fav.type == FavoriteType.paybill
                                    ? Icons.receipt_long
                                    : fav.type == FavoriteType.buyGoods
                                        ? Icons.store
                                        : Icons.send_rounded,
                                label: fav.name,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    _addFavoriteButton(context),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Recent Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to full transaction history
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Transaction List
              ...List.generate(
                  3,
                  (index) => Padding(
                        padding: EdgeInsets.only(bottom: index < 2 ? 12 : 0),
                        child: TransactionListItem(
                          transaction: _getMockTransaction(index),
                        ),
                      )),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void addFavorite(FavoritePin fav) {
    setState(() {
      _favorites.add(fav);
    });
  }

  void _showCurrencySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Currency',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ...['KES', 'USD', 'GBP', 'EUR'].map((currency) => ListTile(
                  leading: Text(
                    currency == 'KES'
                        ? '🇰🇪'
                        : currency == 'USD'
                            ? '🇺🇸'
                            : currency == 'GBP'
                                ? '🇬🇧'
                                : '🇪🇺',
                    style: const TextStyle(fontSize: 20),
                  ),
                  title: Text(currency),
                  trailing: _selectedCurrency == currency
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedCurrency = currency;
                    });
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _transactions = [];

  Future<void> _loadTransactions() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final transactions = await authProvider.getUserTransactions();

    setState(() {
      _transactions = transactions;
    });
  }

  Map<String, dynamic> _getMockTransaction(int index) {
    if (index < _transactions.length) {
      final transaction = _transactions[index];
      return {
        'type': transaction['type'],
        'recipient': transaction['recipient'],
        'amount': transaction['amount'],
        'date': _formatDate(transaction['date']),
        'status': transaction['status'],
      };
    }

    // Fallback mock data
    return {
      'type': 'sent',
      'recipient': 'No transactions yet',
      'amount': 0.0,
      'date': 'No recent activity',
      'status': 'completed',
    };
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown';
    }
  }
}

Widget _favoritePill({required IconData icon, required String label}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.textTertiary.withOpacity(0.2)),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(label,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );

Widget _addFavoriteButton(BuildContext context) => InkWell(
      onTap: () {
        _showAddFavoriteSheet(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        child: const Icon(Icons.add, color: AppColors.primary, size: 22),
      ),
    );

void _showAddFavoriteSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      FavoriteType? selected;
      final paybillController = TextEditingController();
      final accountController = TextEditingController();
      final nameController = TextEditingController();
      final tillController = TextEditingController();
      final phoneController = TextEditingController();

      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Add Favorite',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Paybill'),
                      selected: selected == FavoriteType.paybill,
                      onSelected: (_) =>
                          setState(() => selected = FavoriteType.paybill),
                    ),
                    ChoiceChip(
                      label: const Text('Buy Goods'),
                      selected: selected == FavoriteType.buyGoods,
                      onSelected: (_) =>
                          setState(() => selected = FavoriteType.buyGoods),
                    ),
                    ChoiceChip(
                      label: const Text('Send Money'),
                      selected: selected == FavoriteType.sendMoney,
                      onSelected: (_) =>
                          setState(() => selected = FavoriteType.sendMoney),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (selected == FavoriteType.paybill) ...[
                  TextField(
                      controller: paybillController,
                      decoration:
                          const InputDecoration(labelText: 'Paybill Number')),
                  const SizedBox(height: 8),
                  TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name')),
                  const SizedBox(height: 8),
                  TextField(
                      controller: accountController,
                      decoration:
                          const InputDecoration(labelText: 'Account Number')),
                ] else if (selected == FavoriteType.buyGoods) ...[
                  TextField(
                      controller: tillController,
                      decoration:
                          const InputDecoration(labelText: 'Till Number')),
                  const SizedBox(height: 8),
                  TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name')),
                ] else if (selected == FavoriteType.sendMoney) ...[
                  TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name')),
                  const SizedBox(height: 8),
                  TextField(
                      controller: phoneController,
                      decoration:
                          const InputDecoration(labelText: 'Phone Number')),
                ],
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: selected == null
                          ? null
                          : () {
                              final fav = selected == FavoriteType.paybill
                                  ? FavoritePin(
                                      type: FavoriteType.paybill,
                                      name: nameController.text.trim(),
                                      primary: paybillController.text.trim(),
                                      secondary: accountController.text.trim(),
                                    )
                                  : selected == FavoriteType.buyGoods
                                      ? FavoritePin(
                                          type: FavoriteType.buyGoods,
                                          name: nameController.text.trim(),
                                          primary: tillController.text.trim(),
                                        )
                                      : FavoritePin(
                                          type: FavoriteType.sendMoney,
                                          name: nameController.text.trim(),
                                          primary: phoneController.text.trim(),
                                        );
                              // Add to state via helper
                              final state = context.findAncestorStateOfType<
                                  _DashboardScreenState>();
                              state?.addFavorite(fav);
                              Navigator.pop(ctx);
                            },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _startQuickPay(BuildContext context, FavoritePin fav) {
  final amountController = TextEditingController();
  final pinController = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick Pay - ${fav.name}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount')),
            const SizedBox(height: 8),
            TextField(
                controller: pinController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'PIN')),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel')),
                const SizedBox(width: 8),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Pay')),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Drawer _buildDrawer(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  final authProvider = Provider.of<AuthProvider>(context);
  return Drawer(
    child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    (authProvider.userName ?? 'U')
                        .substring(0, 1)
                        .toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.userName ?? 'Guest User',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authProvider.userPhone ?? '-',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          _buildDrawerItem(
            context: context,
            icon: Icons.person,
            title: 'Profile Settings',
            route: '/profile-settings',
          ),
          SwitchListTile(
            value: themeProvider.isDarkMode,
            onChanged: (_) => themeProvider.toggleTheme(),
            secondary: const Icon(Icons.dark_mode),
            title: const Text(
              'Dark / Light Mode',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.receipt,
            title: 'Transactions & Tariffs',
            route: '/transactions-tariffs',
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.privacy_tip,
            title: 'Privacy & Policy',
            route: '/privacy-policy',
          ),

          const Spacer(),

          // Logout placed above footer
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.primary),
            title: const Text(
              'Log Out',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<AuthProvider>(context, listen: false).logout();
              context.go('/login');
            },
          ),

          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Text(
                  'All rights reserved  2025 LooPay - M Developers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Developed by© ©guyo-halake',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildDrawerItem({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String route,
  String? subtitle,
  Color? color,
}) =>
    ListTile(
      leading: Icon(icon, color: color ?? AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style:
                  const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            )
          : null,
      onTap: () {
        Navigator.of(context).pop();
        context.go(route);
      },
    );
