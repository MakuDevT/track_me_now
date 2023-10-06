// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  final String? uid;
  final String? email;
  final String? trialDue;
  final String token;
  final bool? isActive;
  final bool? isSubscribed;
  final bool? isAdmin;

  const AppUser({
    this.uid,
    this.email,
    this.trialDue,
    required this.token,
    this.isActive,
    this.isSubscribed,
    this.isAdmin,
  });
}
