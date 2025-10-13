# LooPay - Fintech App for Kenyans Abroad

A modern Flutter application designed for Kenyans living abroad to send money home quickly and securely through M-Pesa integration.

## 🌟 Features

### ✅ Implemented Features

#### 1. Onboarding Experience
- **3 Swipeable Intro Screens** with smooth animations
- **Kenyan-inspired Design** with green (#1B5E20), black, white, and orange (#FF9800) color scheme
- **Custom Animations** for each screen:
  - Phone sending cash → M-Pesa logo
  - Calculator with floating coins
  - Kenya flag with M-Pesa shield
- **Skip Button** and **Get Started** CTA

#### 2. Authentication System
- **Login Screen** with email/phone and password
- **Signup Flow** with 3-step process:
  - Personal Information
  - Contact Information  
  - Security & KYC
- **Form Validation** with shake animations for errors
- **Google Login** placeholder
- **Biometric Login** placeholder (Coming Soon)
- **OTP Verification** placeholder

#### 3. Main Dashboard
- **Personalized Welcome** with user's name
- **Wallet Balance Card** with KYC verification status
- **Quick Action Buttons**:
  - Send Money (primary action)
  - Transaction History
  - Profile
- **Recent Transactions** list with transaction details
- **Coming Soon Features** grid:
  - Bills payment
  - Airtime top-up
  - Crypto trading
  - SME Tools
  - Savings
  - Business features

#### 4. Design & UX
- **Minimalist Design** - max 3 taps for main actions
- **Transparent UI** - clear fee and exchange rate display
- **Trust Signals** - KYC verification badges and security icons
- **Smooth Animations** - fade-ins, sliding transitions
- **Modern Typography** - Google Fonts (Inter/Poppins)

## 🛠 Technical Stack

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **Navigation**: GoRouter
- **Animations**: Flutter Animate
- **Fonts**: Google Fonts (Inter, Poppins)
- **Icons**: Material Icons, Font Awesome
- **Architecture**: Clean Architecture with providers

## 📱 Screenshots

### Onboarding Screens
- Screen 1: "Send money in minutes, not days" with phone-to-M-Pesa animation
- Screen 2: "Lower fees, transparent rates" with calculator and coins animation  
- Screen 3: "Powered by M-Pesa, built for Kenyans abroad" with Kenya flag and M-Pesa shield

### Authentication
- Clean login form with validation
- 3-step signup process with progress indicator
- KYC upload placeholder

### Dashboard
- Wallet balance card with verification status
- Quick action buttons for main features
- Recent transactions list
- Coming soon features grid

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd loopay
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Project Structure

```
lib/
├── main.dart                 # App entry point
├── providers/               # State management
│   ├── auth_provider.dart
│   └── theme_provider.dart
├── screens/                 # App screens
│   ├── onboarding/
│   ├── auth/
│   └── dashboard/
├── widgets/                 # Reusable widgets
│   ├── onboarding/
│   ├── auth/
│   └── dashboard/
└── utils/                   # Utilities
    ├── app_colors.dart
    ├── app_router.dart
    ├── app_constants.dart
    └── app_text_styles.dart
```

## 🎨 Design System

### Colors
- **Primary Green**: #1B5E20 (Kenyan flag green)
- **Accent Orange**: #FF9800 (Kenyan flag orange)
- **Black**: #000000
- **White**: #FFFFFF
- **Success**: #4CAF50
- **Error**: #E53E3E
- **Warning**: #FF9800
- **Info**: #2196F3

### Typography
- **Headings**: Poppins (Bold)
- **Body Text**: Inter (Regular)
- **Buttons**: Inter (Semi-bold)

### Animations
- **Page Transitions**: 300ms ease-in-out
- **Form Animations**: 600ms fade-in with slide
- **Button Interactions**: 200ms scale
- **Loading States**: Circular progress indicators

## 🔧 Configuration

### Environment Setup
1. Update `lib/utils/app_constants.dart` with your API endpoints
2. Configure Google Fonts in `pubspec.yaml`
3. Add your app icons to `assets/icons/`
4. Customize colors in `lib/utils/app_colors.dart`

### API Integration
The app is ready for API integration. Update the following:
- `AuthProvider` for real authentication
- Transaction data fetching
- KYC upload functionality
- Real-time balance updates

## 🚧 Future Enhancements

### Phase 2 Features
- [ ] Real M-Pesa API integration
- [ ] OTP verification system
- [ ] Biometric authentication
- [ ] Push notifications
- [ ] Offline support
- [ ] Multi-language support (Swahili)

### Phase 3 Features
- [ ] Bills payment integration
- [ ] Airtime top-up
- [ ] Crypto trading
- [ ] SME business tools
- [ ] Savings accounts
- [ ] Investment options

## 📋 Development Checklist

- [x] Project setup with dependencies
- [x] Onboarding screens with animations
- [x] Login and signup screens
- [x] Main dashboard
- [x] Navigation and routing
- [x] State management
- [x] Form validation
- [x] Responsive design
- [x] Error handling
- [ ] Unit tests
- [ ] Integration tests
- [ ] API integration
- [ ] Performance optimization

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email support@loopay.com or join our Slack channel.

## 🙏 Acknowledgments

- M-Pesa for providing the payment infrastructure
- Flutter team for the amazing framework
- Kenyan diaspora community for feedback and requirements

---

**Built with ❤️ for Kenyans abroad**
