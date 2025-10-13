import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/bank_transfers/bank_transfers_screen.dart';
import '../screens/buy_airtime/buy_airtime_screen.dart';
import '../screens/crypto/crypto_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/lipa_mpesa/lipa_mpesa_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/pay_bill/pay_bill_screen.dart';
import '../screens/privacy_policy/privacy_policy_screen.dart';
import '../screens/profile_settings/profile_settings_screen.dart';
import '../screens/savings_goals/savings_goals_screen.dart';
import '../screens/send_money/send_money_screen.dart';
import '../screens/split_friends/split_friends_screen.dart';
import '../screens/transactions_tariffs/transactions_tariffs_screen.dart';

class AppRouter {
  static GoRouter createRouter(AuthProvider auth) => GoRouter(
        initialLocation: '/onboarding',
        refreshListenable: auth,
        redirect: (context, state) {
          final path = state.uri.path;

          final isAuthPage =
              path == '/login' || path == '/signup' || path == '/onboarding';
          final isLoggedIn = auth.isLoggedIn;

          if (isLoggedIn && isAuthPage) {
            return '/dashboard';
          }

          if (!isLoggedIn && path == '/dashboard') {
            return '/login';
          }

          return null;
        },
        routes: [
          GoRoute(
            path: '/onboarding',
            builder: (context, state) => const OnboardingScreen(),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: '/signup',
            builder: (context, state) => const SignupScreen(),
          ),
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/send-money',
            builder: (context, state) => const SendMoneyScreen(),
          ),
          GoRoute(
            path: '/pay-bill',
            builder: (context, state) => const PayBillScreen(),
          ),
          GoRoute(
            path: '/lipa-mpesa',
            builder: (context, state) => const LipaMpesaScreen(),
          ),
          GoRoute(
            path: '/buy-airtime',
            builder: (context, state) => const BuyAirtimeScreen(),
          ),
          GoRoute(
            path: '/crypto',
            builder: (context, state) => const CryptoScreen(),
          ),
          GoRoute(
            path: '/savings-goals',
            builder: (context, state) => const SavingsGoalsScreen(),
          ),
          GoRoute(
            path: '/split-friends',
            builder: (context, state) => const SplitFriendsScreen(),
          ),
          GoRoute(
            path: '/bank-transactions',
            builder: (context, state) => const BankTransfersScreen(),
          ),
          GoRoute(
            path: '/profile-settings',
            builder: (context, state) => const ProfileSettingsScreen(),
          ),
          GoRoute(
            path: '/transactions-tariffs',
            builder: (context, state) => const TransactionsTariffsScreen(),
          ),
          GoRoute(
            path: '/privacy-policy',
            builder: (context, state) => const PrivacyPolicyScreen(),
          ),
        ],
      );
}
