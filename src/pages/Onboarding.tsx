import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { ArrowRight, Send, Wallet, Zap, Shield } from "lucide-react";

const Onboarding = () => {
  const navigate = useNavigate();

  const features = [
    {
      icon: Send,
      title: "Send Money Anywhere",
      description: "Transfer money to Kenya or abroad at the best rates - cheaper than WorldRemit"
    },
    {
      icon: Wallet,
      title: "Dual Wallets",
      description: "Manage both M-PESA and your bank account in one place"
    },
    {
      icon: Zap,
      title: "Instant Transactions",
      description: "Pay bills, buy airtime, and split bills with friends instantly"
    },
    {
      icon: Shield,
      title: "Bank-Grade Security",
      description: "Your money is protected with enterprise-level encryption"
    }
  ];

  return (
    <div className="min-h-screen overflow-hidden relative bg-gradient-to-br from-background via-muted/10 to-background">
      {/* Subtle background elements */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none opacity-30">
        <div 
          className="absolute top-20 right-20 w-96 h-96 bg-primary/20 rounded-full blur-3xl"
        ></div>
        <div 
          className="absolute bottom-20 left-20 w-96 h-96 bg-primary-glow/20 rounded-full blur-3xl"
        ></div>
      </div>

      <div className="relative z-10 container mx-auto px-6 py-12 flex flex-col items-center justify-center min-h-screen">
        {/* Logo */}
        <div className="mb-12 animate-fade-in">
          <div className="flex items-center gap-4">
            <div className="w-16 h-16 glassmorphism-strong rounded-2xl flex items-center justify-center shadow-card group hover:scale-105 transition-transform duration-300 bg-gradient-to-br from-primary to-primary-glow">
              <Wallet className="w-8 h-8 text-white" />
            </div>
            <h1 className="text-5xl font-black text-foreground tracking-tight">
              LooPay
            </h1>
          </div>
        </div>

        {/* Tagline */}
        <div className="text-center mb-16 max-w-3xl">
          <h2 className="text-4xl md:text-5xl font-black mb-4 leading-tight text-foreground tracking-tight">
            Your Money,
            <br />
            <span className="text-primary">
              Borderless & Simple
            </span>
          </h2>
          <p className="text-xl font-semibold text-foreground/80 mb-2">
            For Kenyans, By Kenyans
          </p>
          <p className="text-base text-muted-foreground">
            Send money, pay bills, and manage your finances across borders with ease
          </p>
        </div>

        {/* Features Grid */}
        <div className="grid md:grid-cols-2 gap-6 max-w-4xl w-full mb-16">
          {features.map((feature, index) => (
            <div
              key={index}
              className="glassmorphism p-6 rounded-3xl hover:glassmorphism-strong transition-all duration-300 hover:scale-105 hover:shadow-card group cursor-pointer border border-white/5"
            >
              <div className="w-12 h-12 bg-gradient-to-br from-primary to-primary-glow rounded-2xl flex items-center justify-center mb-4 shadow-card group-hover:shadow-glow transition-shadow">
                <feature.icon className="w-6 h-6 text-white" />
              </div>
              <h3 className="text-xl font-bold mb-2 text-foreground">
                {feature.title}
              </h3>
              <p className="text-muted-foreground text-sm leading-relaxed">
                {feature.description}
              </p>
            </div>
          ))}
        </div>

        {/* CTA Buttons */}
        <div className="flex flex-col sm:flex-row gap-4 w-full max-w-md mb-12">
          <Button
            onClick={() => navigate("/signup")}
            size="lg"
            className="flex-1 bg-gradient-to-r from-primary to-primary-glow text-white hover:from-primary/90 hover:to-primary-glow/90 shadow-card hover:shadow-glow transition-all duration-300 hover:scale-105 text-base h-14 rounded-2xl font-bold"
          >
            Get Started
            <ArrowRight className="ml-2 w-5 h-5" />
          </Button>
          <Button
            onClick={() => navigate("/login")}
            size="lg"
            variant="outline"
            className="flex-1 glassmorphism text-foreground hover:bg-white/10 text-base h-14 rounded-2xl font-bold transition-all duration-300 hover:scale-105 border-white/10"
          >
            Log In
          </Button>
        </div>

        {/* Trust indicators */}
        <div className="flex flex-wrap justify-center items-center gap-6 text-sm text-muted-foreground">
          <div className="flex items-center gap-2">
            <div className="w-2 h-2 rounded-full bg-primary"></div>
            <span className="font-medium">M-PESA Integrated</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-2 h-2 rounded-full bg-primary"></div>
            <span className="font-medium">Bank Grade Security</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-2 h-2 rounded-full bg-primary"></div>
            <span className="font-medium">Best Rates</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Onboarding;
