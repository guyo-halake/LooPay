// Custom authentication utilities
// TODO: Implement proper JWT handling
// FIXME: Add refresh token logic

export interface User {
  id: string;
  name: string;
  email: string;
  phone: string;
  isVerified: boolean;
}

export interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  isLoading: boolean;
}

// Mock user data - will be replaced with real API
const MOCK_USER: User = {
  id: "user_123",
  name: "Razak",
  email: "razak@example.com",
  phone: "+254 712 345 678",
  isVerified: true
};

export const authService = {
  // TODO: Replace with real API calls
  async login(email: string, password: string): Promise<User> {
    console.log("Auth service: Attempting login for", email);
    
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    // HACK: Mock validation - replace with real validation
    if (email === "test@example.com" && password === "password") {
      return MOCK_USER;
    }
    
    throw new Error("Invalid credentials");
  },

  async signup(userData: {
    fullName: string;
    email: string;
    phone: string;
    password: string;
  }): Promise<User> {
    console.log("Auth service: Creating account for", userData.email);
    
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 1500));
    
    // TODO: Validate user data properly
    // FIXME: Add phone number validation
    return {
      ...MOCK_USER,
      name: userData.fullName,
      email: userData.email,
      phone: userData.phone
    };
  },

  async logout(): Promise<void> {
    console.log("Auth service: Logging out user");
    // TODO: Clear tokens from storage
    // FIXME: Add proper session cleanup
  }
};

