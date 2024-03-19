class User {
  final String id;
  final String? displayName;
  final String email;
  final String? avatarUrl;
  final bool emailVerified;
  final String? instiEmail;
  final bool instiEmailVerified;
  final String? planId;
  final bool enableInternshipAlerts;
  final bool enablePlacementAlerts;

  User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.avatarUrl,
    required this.emailVerified,
    required this.instiEmail,
    required this.instiEmailVerified,
    required this.planId,
    required this.enableInternshipAlerts,
    required this.enablePlacementAlerts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      emailVerified: json['emailVerified'] == true,
      instiEmail: json['instiEmail'],
      instiEmailVerified: json['instiEmailVerified'] == true,
      planId: json['planId'],
      enableInternshipAlerts: json['enableInternshipAlerts'] == true,
      enablePlacementAlerts: json['enablePlacementAlerts'] == true,
    );
  }
}
