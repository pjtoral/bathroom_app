import 'package:supabase_flutter/supabase_flutter.dart';

/// Service class for handling Supabase authentication
class SupabaseAuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Sign up a new user with email and password
  ///
  /// Checks if user already exists before attempting signup
  /// Returns the user session on success, throws an exception on failure
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    try {
      // First, attempt to sign in to check if user exists
      try {
        await _supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
        // If sign in succeeds, user already exists
        throw Exception('User already registered');
      } on AuthException catch (e) {
        // If error is "Invalid login credentials", user might exist but password is wrong
        // or user doesn't exist yet
        if (e.message.toLowerCase().contains('invalid login credentials')) {
          // This could mean user doesn't exist OR wrong password
          // We'll attempt signup and let Supabase handle it
        } else {
          // Some other auth error occurred
          rethrow;
        }
      }

      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } on AuthException {
      rethrow;
    }
  }

  /// Sign in an existing user with email and password
  ///
  /// Returns the user session on success, throws an exception on failure
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  /// Sign out the current user
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Get the current user session
  Session? get currentSession => _supabase.auth.currentSession;

  /// Get the current user
  User? get currentUser => _supabase.auth.currentUser;

  /// Check if user is signed in
  bool get isSignedIn => currentSession != null;

  /// Send password reset email
  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  /// Stream of auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Refresh the current session to get updated user data
  Future<void> refreshSession() async {
    try {
      await _supabase.auth.refreshSession();
    } catch (e) {
      throw Exception('Session refresh failed: $e');
    }
  }

  /// Resend verification email
  Future<void> resendVerificationEmail({required String email}) async {
    try {
      await _supabase.auth.resend(type: OtpType.signup, email: email);
    } catch (e) {
      throw Exception('Failed to resend verification email: $e');
    }
  }
}
