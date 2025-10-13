class UserModel {
  final int? id;
  final String name;
  final String? email;
  final String phone;
  final String pin;
  final double balance;
  final bool isKycVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    this.id,
    required this.name,
    this.email,
    required this.phone,
    required this.pin,
    this.balance = 0.0,
    this.isKycVerified = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      pin: map['pin'],
      balance: map['balance']?.toDouble() ?? 0.0,
      isKycVerified: map['is_kyc_verified'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'pin': pin,
      'balance': balance,
      'is_kyc_verified': isKycVerified ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? pin,
    double? balance,
    bool? isKycVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      balance: balance ?? this.balance,
      isKycVerified: isKycVerified ?? this.isKycVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
