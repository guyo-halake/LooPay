import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet";
import {
  Carousel,
  CarouselContent,
  CarouselItem,
} from "@/components/ui/carousel";
import { 
  Send, 
  Receipt, 
  Users, 
  TrendingUp, 
  ShoppingBag,
  ArrowUpRight,
  ArrowDownRight,
  Eye,
  EyeOff,
  Bell,
  Menu,
  Settings,
  User,
  LogOut,
  Shield,
  Banknote,
  FileStack,
  ShoppingCart,
  Wallet,
  CreditCard,
  Moon,
  Sun,
  ChevronUp,
  BarChart3,
  PieChart,
  TrendingDown,
  DollarSign,
  Calendar,
  Target,
  Zap,
  Star,
  Heart,
  Gift,
  Coffee,
  Car,
  Home,
  ShoppingCart as Cart,
  Utensils,
  Gamepad2,
  Music,
  BookOpen,
  Camera,
  Plane,
  Train,
  Bus,
  Bike
} from "lucide-react";
import { useState } from "react";
import { useTheme } from "next-themes";

const Dashboard = () => {
  const [showBalance, setShowBalance] = useState(true);
  const [showAnalytics, setShowAnalytics] = useState(false);
  const [showCurrencySelector, setShowCurrencySelector] = useState(false);
  const [selectedCurrency, setSelectedCurrency] = useState("KES");
  // TODO: Get from user context/API instead of hardcoding
  const userName = "Razak"; // FIXME: This should come from auth context
  const userPhone = "+254 768 141 129"; // HACK: Mock data for now
  const { theme, setTheme } = useTheme();

  // Currency options with proper flag images and exchange rates
  const currencies = [
    { code: "KES", flag: "https://flagcdn.com/w20/ke.png", name: "Kenya", symbol: "KSh", rate: 1 },
    { code: "TZS", flag: "https://flagcdn.com/w20/tz.png", name: "Tanzania", symbol: "TSh", rate: 20.5 },
    { code: "UGX", flag: "https://flagcdn.com/w20/ug.png", name: "Uganda", symbol: "USh", rate: 28.3 },
    { code: "RWF", flag: "https://flagcdn.com/w20/rw.png", name: "Rwanda", symbol: "FRw", rate: 10.8 },
    { code: "ETB", flag: "https://flagcdn.com/w20/et.png", name: "Ethiopia", symbol: "Br", rate: 0.95 },
    { code: "USD", flag: "https://flagcdn.com/w20/us.png", name: "USA", symbol: "$", rate: 0.0077 },
    { code: "GBP", flag: "https://flagcdn.com/w20/gb.png", name: "UK", symbol: "£", rate: 0.0061 },
    { code: "CAD", flag: "https://flagcdn.com/w20/ca.png", name: "Canada", symbol: "C$", rate: 0.011 },
    { code: "AUD", flag: "https://flagcdn.com/w20/au.png", name: "Australia", symbol: "A$", rate: 0.012 },
    { code: "EUR", flag: "https://flagcdn.com/w20/de.png", name: "Germany", symbol: "€", rate: 0.0072 },
    { code: "NGN", flag: "https://flagcdn.com/w20/ng.png", name: "Nigeria", symbol: "₦", rate: 12.2 },
    { code: "GHS", flag: "https://flagcdn.com/w20/gh.png", name: "Ghana", symbol: "₵", rate: 0.12 },
  ];

  // Enhanced spending analytics data
  const spendingData = {
    totalSpent: 45680,
    monthlyBudget: 60000,
    categories: [
      { name: "Food & Dining", amount: 12500, percentage: 27, icon: Utensils, color: "from-orange-400 to-orange-600" },
      { name: "Transport", amount: 8900, percentage: 19, icon: Car, color: "from-blue-400 to-blue-600" },
      { name: "Shopping", amount: 11200, percentage: 25, icon: ShoppingBag, color: "from-pink-400 to-pink-600" },
      { name: "Entertainment", amount: 6800, percentage: 15, icon: Gamepad2, color: "from-purple-400 to-purple-600" },
      { name: "Bills & Utilities", amount: 4200, percentage: 9, icon: Home, color: "from-green-400 to-green-600" },
      { name: "Others", amount: 2080, percentage: 5, icon: Gift, color: "from-gray-400 to-gray-600" }
    ],
    weeklyTrend: [1200, 1800, 1500, 2200, 1900, 2100, 1600],
    monthlyComparison: { current: 45680, previous: 38900, change: 17.4 }
  };

  // Enhanced quick actions 
  const quickActions = [
    { icon: Send, label: "Send Money", color: "from-emerald-400 to-emerald-600", bgColor: "bg-emerald-50 dark:bg-emerald-950" },
    { icon: Receipt, label: "Pay Bills", color: "from-blue-400 to-blue-600", bgColor: "bg-blue-50 dark:bg-blue-950" },
    { icon: Users, label: "Split Bills", color: "from-purple-400 to-purple-600", bgColor: "bg-purple-50 dark:bg-purple-950" },
    { icon: TrendingUp, label: "Invest", color: "from-green-400 to-green-600", bgColor: "bg-green-50 dark:bg-green-950" },
    { icon: Zap, label: "Airtime", color: "from-yellow-400 to-yellow-600", bgColor: "bg-yellow-50 dark:bg-yellow-950" },
    { icon: ShoppingBag, label: "Shop", color: "from-pink-400 to-pink-600", bgColor: "bg-pink-50 dark:bg-pink-950" },
    { icon: Wallet, label: "Withdraw", color: "from-indigo-400 to-indigo-600", bgColor: "bg-indigo-50 dark:bg-indigo-950" },
    { icon: BarChart3, label: "Analytics", color: "from-cyan-400 to-cyan-600", bgColor: "bg-cyan-50 dark:bg-cyan-950" },
    { icon: CreditCard, label: "Cards", color: "from-red-400 to-red-600", bgColor: "bg-red-50 dark:bg-red-950" }
  ];

  const transactions = [
    { type: "send", name: "Jane Kamau", amount: 5000, time: "2 hours ago", status: "completed" },
    { type: "receive", name: "M-PESA Deposit", amount: 15000, time: "Yesterday", status: "completed" },
    { type: "bill", name: "Kenya Power", amount: 3200, time: "2 days ago", status: "completed" },
    { type: "crypto", name: "Bitcoin Purchase", amount: 20000, time: "3 days ago", status: "completed" }
  ];

  // Convert amount to selected currency
  const convertAmount = (amount: number) => {
    const currency = currencies.find(c => c.code === selectedCurrency);
    const converted = amount * (currency?.rate || 1);
    return `${currency?.symbol || 'KSh'} ${converted.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
  };

  // Enhanced balance display with proper fade effect
  const formatBalanceDisplay = (amount: number) => {
    if (!showBalance) {
      return (
        <div className="relative">
          <div className="text-4xl font-bold tracking-tight text-foreground/10 blur-md">
            {convertAmount(amount)}
          </div>
          <div className="absolute inset-0 bg-gradient-to-r from-background/80 via-background/90 to-background/80 animate-pulse"></div>
        </div>
      );
    }
    return (
      <div className="text-4xl font-bold tracking-tight text-foreground transition-all duration-500 ease-in-out">
        {convertAmount(amount)}
      </div>
    );
  };

  return (
    <div className="min-h-screen bg-background pb-32">
      {/* Header */}
      <div className="bg-background p-6 pb-6 sticky top-0 z-10">
        <div className="max-w-md mx-auto">
          <div className="flex justify-between items-center mb-6">
            <div className="flex-1">
              <h1 className="text-2xl font-bold flex items-center gap-2 tracking-tight text-foreground">
                Welcome {userName}! <span className="animate-[wave_0.5s_ease-in-out_infinite] inline-block origin-[70%_70%]">👋</span>
              </h1>
            </div>
            <div className="flex items-center gap-3">
              <button 
                onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
                className="relative p-2 hover:bg-muted rounded-full transition-colors"
              >
                {theme === "dark" ? (
                  <Sun className="w-6 h-6 text-foreground" />
                ) : (
                  <Moon className="w-6 h-6 text-foreground" />
                )}
              </button>
              <button className="relative p-2 hover:bg-muted rounded-full transition-colors">
                <Bell className="w-6 h-6 text-foreground" />
                <span className="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
              </button>
              <Sheet>
                <SheetTrigger asChild>
                  <button className="p-2 hover:bg-muted rounded-full transition-colors">
                    <Menu className="w-6 h-6 text-foreground" />
                  </button>
                </SheetTrigger>
                <SheetContent className="glassmorphism border-white/20">
                  <SheetHeader>
                    <SheetTitle className="flex items-center gap-3 pb-4 border-b border-white/10">
                      <div className="w-16 h-16 bg-gradient-to-br from-primary to-primary-glow rounded-full flex items-center justify-center text-2xl font-bold text-white">
                        {userName.charAt(0)}
                      </div>
                      <div>
                        <p className="font-bold text-lg">{userName}</p>
                        <p className="text-sm text-muted-foreground">{userPhone}</p>
                      </div>
                    </SheetTitle>
                  </SheetHeader>
                  <div className="mt-6 space-y-2">
                    <button className="w-full flex items-center gap-4 p-4 hover:bg-white/5 rounded-xl transition-colors text-left">
                      <User className="w-5 h-5" />
                      <span className="font-medium">Profile</span>
                    </button>
                    <button className="w-full flex items-center gap-4 p-4 hover:bg-white/5 rounded-xl transition-colors text-left">
                      <Settings className="w-5 h-5" />
                      <span className="font-medium">Settings</span>
                    </button>
                    <button className="w-full flex items-center gap-4 p-4 hover:bg-white/5 rounded-xl transition-colors text-left">
                      <Shield className="w-5 h-5" />
                      <span className="font-medium">Privacy Policy</span>
                    </button>
                    <button className="w-full flex items-center gap-4 p-4 hover:bg-white/5 rounded-xl transition-colors text-left text-red-500">
                      <LogOut className="w-5 h-5" />
                      <span className="font-medium">Log Out</span>
                    </button>
                  </div>
                  <div className="absolute bottom-6 left-6 right-6 text-center text-sm text-muted-foreground border-t border-white/10 pt-4">
                    © 2025 Guyohalake
                  </div>
                </SheetContent>
              </Sheet>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-md mx-auto px-4">

        {/* Wallet Cards Carousel with Integrated Currency Selector */}
        <Carousel className="w-full mb-8">
          <CarouselContent>
            {/* M-PESA Card */}
            <CarouselItem>
              <Card className="glassmorphism-strong border border-border shadow-card relative overflow-hidden">
                <div className="p-6">
                  <div className="flex justify-between items-start mb-6">
                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-3">
                        <div className="flex items-center gap-2">
                          <img 
                            src="https://flagcdn.com/w20/ke.png" 
                            alt="Kenya Flag" 
                            className="w-6 h-4 rounded-sm shadow-sm"
                          />
                          <button
                            onClick={() => setShowCurrencySelector(!showCurrencySelector)}
                            className="p-1 hover:bg-white/5 rounded transition-colors"
                          >
                            <ChevronUp className={`w-4 h-4 text-muted-foreground transition-transform ${showCurrencySelector ? 'rotate-180' : ''}`} />
                          </button>
                        </div>
                        <div>
                          <p className="text-muted-foreground text-xs font-medium uppercase tracking-wider">M-PESA Balance</p>
                          <p className="text-xs text-muted-foreground">Kenya Shilling</p>
                        </div>
                      </div>
                      
                      {/* Inline Flag Selector */}
                      {showCurrencySelector && (
                        <div className="mb-3 p-3 bg-white/5 rounded-lg">
                          <p className="text-xs text-muted-foreground mb-2">Select Currency:</p>
                          <div className="flex flex-wrap gap-2">
                            {currencies.map((currency) => (
                              <button
                                key={currency.code}
                                onClick={() => {
                                  setSelectedCurrency(currency.code);
                                  setShowCurrencySelector(false);
                                }}
                                className={`p-2 rounded-lg transition-all border-2 ${
                                  selectedCurrency === currency.code
                                    ? 'bg-primary/20 border-primary scale-110'
                                    : 'hover:bg-white/10 border-transparent'
                                }`}
                              >
                                <img 
                                  src={currency.flag} 
                                  alt={`${currency.name} Flag`}
                                  className="w-8 h-5 rounded-sm shadow-sm"
                                />
                              </button>
                            ))}
                          </div>
                        </div>
                      )}
                      <div className="flex items-center gap-3">
                        <div className="flex-1">
                          {formatBalanceDisplay(45230)}
                        </div>
                        <button 
                          onClick={() => setShowBalance(!showBalance)}
                          className="text-muted-foreground hover:text-foreground transition-colors p-2 hover:bg-white/5 rounded-lg"
                        >
                          {showBalance ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
                        </button>
                      </div>
                    </div>
                    <div className="w-12 h-12 bg-gradient-to-br from-primary to-primary-glow rounded-2xl flex items-center justify-center shadow-lg">
                      <Wallet className="w-6 h-6 text-white" />
                    </div>
                  </div>
                  
                  <div className="flex justify-between items-center text-sm pt-4 border-t border-border">
                    <span className="text-muted-foreground font-medium">{userPhone}</span>
                    <span className="bg-primary/10 px-3 py-1.5 rounded-full text-xs font-bold text-primary">Active</span>
                  </div>
                </div>
              </Card>
            </CarouselItem>

            {/* Bank Card */}
            <CarouselItem>
              <Card className="glassmorphism-strong border border-border shadow-card relative overflow-hidden">
                <div className="p-6">
                  <div className="flex justify-between items-start mb-6">
                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-3">
                        <div className="flex items-center gap-2">
                          <img 
                            src="https://flagcdn.com/w20/ke.png" 
                            alt="Kenya Flag" 
                            className="w-6 h-4 rounded-sm shadow-sm"
                          />
                          <button
                            onClick={() => setShowCurrencySelector(!showCurrencySelector)}
                            className="p-1 hover:bg-white/5 rounded transition-colors"
                          >
                            <ChevronUp className={`w-4 h-4 text-muted-foreground transition-transform ${showCurrencySelector ? 'rotate-180' : ''}`} />
                          </button>
                        </div>
                        <div>
                          <p className="text-muted-foreground text-xs font-medium uppercase tracking-wider">Equity Bank</p>
                          <p className="text-xs text-muted-foreground">Kenya Shilling</p>
                        </div>
                      </div>
                      
                      {/* Inline Flag Selector */}
                      {showCurrencySelector && (
                        <div className="mb-3 p-3 bg-white/5 rounded-lg">
                          <p className="text-xs text-muted-foreground mb-2">Select Currency:</p>
                          <div className="flex flex-wrap gap-2">
                            {currencies.map((currency) => (
                              <button
                                key={currency.code}
                                onClick={() => {
                                  setSelectedCurrency(currency.code);
                                  setShowCurrencySelector(false);
                                }}
                                className={`p-2 rounded-lg transition-all border-2 ${
                                  selectedCurrency === currency.code
                                    ? 'bg-primary/20 border-primary scale-110'
                                    : 'hover:bg-white/10 border-transparent'
                                }`}
                              >
                                <img 
                                  src={currency.flag} 
                                  alt={`${currency.name} Flag`}
                                  className="w-8 h-5 rounded-sm shadow-sm"
                                />
                              </button>
                            ))}
                          </div>
                        </div>
                      )}
                      <div className="flex items-center gap-3">
                        <div className="flex-1">
                          {formatBalanceDisplay(128450)}
                        </div>
                        <button 
                          onClick={() => setShowBalance(!showBalance)}
                          className="text-muted-foreground hover:text-foreground transition-colors p-2 hover:bg-white/5 rounded-lg"
                        >
                          {showBalance ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
                        </button>
                      </div>
                    </div>
                    <div className="w-12 h-12 bg-gradient-to-br from-blue-400 to-blue-600 rounded-2xl flex items-center justify-center shadow-lg">
                      <svg className="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M20 4H4c-1.11 0-1.99.89-1.99 2L2 18c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V6c0-1.11-.89-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z"/>
                      </svg>
                    </div>
                  </div>
                  
                  <div className="flex justify-between items-center text-sm pt-4 border-t border-border">
                    <span className="text-muted-foreground font-medium">••••  ••••  ••••  4829</span>
                    <span className="bg-primary/10 px-3 py-1.5 rounded-full text-xs font-bold text-primary">Verified</span>
                  </div>
                </div>
              </Card>
            </CarouselItem>
          </CarouselContent>
        </Carousel>


        {/* Enhanced Quick Actions */}
        <div className="mb-6">
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-lg font-bold text-foreground flex items-center gap-2">
              <Zap className="w-5 h-5 text-primary" />
              Quick Actions
            </h3>
            <Button variant="ghost" size="sm" className="text-primary hover:bg-white/5">
              <Settings className="w-4 h-4 mr-1" />
              Customize
            </Button>
          </div>
          <div className="grid grid-cols-3 gap-3">
            {quickActions.map((action, index) => (
              <button
                key={index}
                className="group relative flex flex-col items-center gap-3 p-4 glassmorphism rounded-2xl border border-white/10 hover:border-primary/30 transition-all duration-300 hover:scale-105 active:scale-95 overflow-hidden"
              >
                {/* Background gradient on hover */}
                <div className={`absolute inset-0 bg-gradient-to-br ${action.color} opacity-0 group-hover:opacity-5 transition-opacity duration-300`}></div>
                
                {/* Icon with enhanced styling */}
                <div className={`relative w-14 h-14 bg-gradient-to-br ${action.color} rounded-2xl flex items-center justify-center shadow-lg group-hover:shadow-xl transition-all duration-300 group-hover:scale-110`}>
                  <action.icon className="w-7 h-7 text-white drop-shadow-lg group-hover:scale-110 transition-transform duration-300" />
                </div>
                
                {/* Label with better typography */}
                <span className="relative text-xs font-semibold text-center text-foreground leading-tight group-hover:text-primary transition-colors duration-300">
                  {action.label}
                </span>
                
                {/* Subtle glow effect */}
                <div className="absolute inset-0 rounded-2xl bg-gradient-to-br from-transparent via-transparent to-primary/10 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
              </button>
            ))}
          </div>
        </div>

        {/* Analytics Toggle Button */}
        <div className="mb-6">
          <button
            onClick={() => setShowAnalytics(!showAnalytics)}
            className="w-full flex items-center justify-between p-4 glassmorphism rounded-2xl border border-white/10 hover:border-primary/30 transition-all duration-300 group"
          >
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-gradient-to-br from-cyan-400 to-cyan-600 rounded-2xl flex items-center justify-center shadow-lg">
                <BarChart3 className="w-6 h-6 text-white" />
              </div>
              <div className="text-left">
                <p className="font-semibold text-foreground">Check Your Spending</p>
                <p className="text-xs text-muted-foreground">View detailed analytics</p>
              </div>
            </div>
            <ChevronUp className={`w-5 h-5 text-muted-foreground transition-transform duration-300 ${showAnalytics ? 'rotate-180' : ''}`} />
          </button>
        </div>

        {/* Spending Analytics Section - Hidden by Default */}
        {showAnalytics && (
          <div className="mb-6 animate-in slide-in-from-top-4 duration-300">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-bold text-foreground flex items-center gap-2">
                <BarChart3 className="w-5 h-5 text-primary" />
                Spending Analytics
              </h3>
              <Button variant="ghost" size="sm" className="text-primary hover:bg-white/5">
                <Calendar className="w-4 h-4 mr-1" />
                This Month
              </Button>
            </div>
            
            {/* Monthly Overview Card */}
            <Card className="glassmorphism border border-white/10 mb-4 overflow-hidden">
              <div className="p-4">
                <div className="flex items-center justify-between mb-3">
                  <div>
                    <p className="text-sm text-muted-foreground">Total Spent</p>
                  <p className="text-2xl font-bold text-foreground">
                    KSh {spendingData.totalSpent.toLocaleString()}
                  </p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm text-muted-foreground">Budget</p>
                    <p className="text-lg font-semibold text-foreground">
                      KSh {spendingData.monthlyBudget.toLocaleString()}
                    </p>
                  </div>
                </div>
                
                {/* Progress Bar */}
                <div className="w-full bg-muted/20 rounded-full h-2 mb-2">
                  <div 
                    className="bg-gradient-to-r from-primary to-primary-glow h-2 rounded-full transition-all duration-1000 ease-out"
                    style={{ width: `${(spendingData.totalSpent / spendingData.monthlyBudget) * 100}%` }}
                  ></div>
                </div>
                
                <div className="flex items-center justify-between text-xs">
                  <span className="text-muted-foreground">
                    {Math.round((spendingData.totalSpent / spendingData.monthlyBudget) * 100)}% of budget used
                  </span>
                <span className="text-primary font-semibold">
                  KSh {(spendingData.monthlyBudget - spendingData.totalSpent).toLocaleString()} left
                </span>
                </div>
              </div>
            </Card>

            {/* Spending Categories */}
            <Card className="glassmorphism border border-white/10 overflow-hidden">
              <div className="p-4">
                <h4 className="font-semibold text-foreground mb-3 flex items-center gap-2">
                  <PieChart className="w-4 h-4 text-primary" />
                  Spending by Category
                </h4>
                <div className="space-y-3">
                  {spendingData.categories.map((category, index) => (
                    <div key={index} className="flex items-center justify-between">
                      <div className="flex items-center gap-3">
                        <div className={`w-8 h-8 rounded-lg bg-gradient-to-r ${category.color} flex items-center justify-center`}>
                          <category.icon className="w-4 h-4 text-white" />
                        </div>
                        <div>
                          <p className="text-sm font-medium text-foreground">{category.name}</p>
                          <p className="text-xs text-muted-foreground">{category.percentage}%</p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-sm font-semibold text-foreground">
                          KSh {category.amount.toLocaleString()}
                        </p>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </Card>
          </div>
        )}

        {/* Enhanced Ad Banner */}
        <div className="mb-6">
          <Card className="glassmorphism border border-white/10 overflow-hidden aspect-video bg-gradient-to-br from-primary/20 via-primary/10 to-primary-glow/20 flex items-center justify-center relative group cursor-pointer">
            <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
            <div className="text-center p-6 relative z-10">
              <div className="text-4xl mb-2 animate-bounce">🎬</div>
              <p className="text-sm font-medium text-foreground">Premium Ad Space</p>
              <p className="text-xs text-muted-foreground/80 mt-1">Tap to view featured content</p>
            </div>
            <div className="absolute top-2 right-2">
              <div className="w-2 h-2 bg-primary rounded-full animate-pulse"></div>
            </div>
          </Card>
        </div>

        {/* Enhanced Recent Transactions */}
        <div className="mb-6">
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-lg font-bold text-foreground flex items-center gap-2">
              <TrendingUp className="w-5 h-5 text-primary" />
              Recent Transactions
            </h3>
            <Button variant="ghost" size="sm" className="text-primary hover:bg-white/5 group">
              <span className="group-hover:underline">See All</span>
              <ArrowUpRight className="w-4 h-4 ml-1 group-hover:translate-x-0.5 group-hover:-translate-y-0.5 transition-transform" />
            </Button>
          </div>
          <Card className="glassmorphism border border-white/10 divide-y divide-white/10 overflow-hidden">
            {transactions.map((transaction, index) => (
              <div key={index} className="group flex items-center justify-between p-4 hover:bg-white/5 transition-all duration-300 hover:scale-[1.02]">
                <div className="flex items-center gap-3">
                  <div className={`w-11 h-11 rounded-2xl flex items-center justify-center shadow-lg group-hover:shadow-xl transition-all duration-300 ${
                    transaction.type === "receive" 
                      ? "bg-gradient-to-br from-emerald-400 to-emerald-600" 
                      : "bg-gradient-to-br from-blue-400 to-blue-600"
                  }`}>
                    {transaction.type === "receive" ? (
                      <ArrowDownRight className="w-5 h-5 text-white group-hover:scale-110 transition-transform duration-300" />
                    ) : (
                      <ArrowUpRight className="w-5 h-5 text-white group-hover:scale-110 transition-transform duration-300" />
                    )}
                  </div>
                  <div>
                    <p className="font-semibold text-sm text-foreground group-hover:text-primary transition-colors duration-300">{transaction.name}</p>
                    <p className="text-xs text-muted-foreground">{transaction.time}</p>
                  </div>
                </div>
                <div className="text-right">
                  <p className={`font-bold text-sm transition-colors duration-300 ${
                    transaction.type === "receive" ? "text-emerald-500" : "text-blue-500"
                  }`}>
                    {transaction.type === "receive" ? "+" : "-"}KSh {transaction.amount.toLocaleString()}
                  </p>
                  <span className="text-xs text-muted-foreground capitalize bg-muted/20 px-2 py-1 rounded-full">
                    {transaction.status}
                  </span>
                </div>
              </div>
            ))}
          </Card>
        </div>
      </div>

      {/* Enhanced Fixed Bottom Navigation */}
      <div className="fixed bottom-0 left-0 right-0 bg-card/95 backdrop-blur-xl border-t border-white/10 z-50 shadow-premium">
        <div className="max-w-md mx-auto px-6 py-4">
          <div className="grid grid-cols-3 gap-4">
            {/* Send Money */}
            <button className="group flex flex-col items-center gap-2 p-3 rounded-2xl hover:bg-white/5 transition-all duration-300 hover:scale-105 active:scale-95 relative overflow-hidden">
              <div className="absolute inset-0 bg-gradient-to-br from-emerald-400/10 to-emerald-600/10 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-2xl"></div>
              <div className="relative w-14 h-14 bg-gradient-to-br from-emerald-400 to-emerald-600 rounded-2xl flex items-center justify-center shadow-lg group-hover:shadow-xl transition-all duration-300 group-hover:scale-110">
                <Banknote className="w-7 h-7 text-white drop-shadow-lg group-hover:scale-110 transition-transform duration-300" />
              </div>
              <div className="text-center relative z-10">
                <p className="font-bold text-xs text-foreground group-hover:text-emerald-500 transition-colors duration-300">Send Money</p>
                <p className="text-[9px] text-muted-foreground leading-tight">Kenya & abroad</p>
              </div>
            </button>

            {/* Pay Bills */}
            <button className="group flex flex-col items-center gap-2 p-3 rounded-2xl hover:bg-white/5 transition-all duration-300 hover:scale-105 active:scale-95 relative overflow-hidden">
              <div className="absolute inset-0 bg-gradient-to-br from-blue-400/10 to-blue-600/10 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-2xl"></div>
              <div className="relative w-14 h-14 bg-gradient-to-br from-blue-400 to-blue-600 rounded-2xl flex items-center justify-center shadow-lg group-hover:shadow-xl transition-all duration-300 group-hover:scale-110">
                <FileStack className="w-7 h-7 text-white drop-shadow-lg group-hover:scale-110 transition-transform duration-300" />
              </div>
              <div className="text-center relative z-10">
                <p className="font-bold text-xs text-foreground group-hover:text-blue-500 transition-colors duration-300">Pay Bills</p>
                <p className="text-[9px] text-muted-foreground leading-tight">Locally & abroad</p>
              </div>
            </button>

            {/* Lipa na Mpesa */}
            <button className="group flex flex-col items-center gap-2 p-3 rounded-2xl hover:bg-white/5 transition-all duration-300 hover:scale-105 active:scale-95 relative overflow-hidden">
              <div className="absolute inset-0 bg-gradient-to-br from-purple-400/10 to-purple-600/10 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-2xl"></div>
              <div className="relative w-14 h-14 bg-gradient-to-br from-purple-400 to-purple-600 rounded-2xl flex items-center justify-center shadow-lg group-hover:shadow-xl transition-all duration-300 group-hover:scale-110">
                <ShoppingCart className="w-7 h-7 text-white drop-shadow-lg group-hover:scale-110 transition-transform duration-300" />
              </div>
              <div className="text-center relative z-10">
                <p className="font-bold text-xs text-foreground group-hover:text-purple-500 transition-colors duration-300">Lipa na Mpesa</p>
                <p className="text-[9px] text-muted-foreground leading-tight">Buy goods & services</p>
              </div>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
