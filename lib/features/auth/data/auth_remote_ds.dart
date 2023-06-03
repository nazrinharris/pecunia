import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models/pecunia_user.dart';

abstract interface class AuthRemoteDS {
  Future<PecuniaUser> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  });
  Future<PecuniaUser> registerWithPassword({required String email, required String password});

  Future<PecuniaUser> getUserInformation();

  Future<Unit> logout();
}

class SupabaseAuthRemoteDS implements AuthRemoteDS {
  final SupabaseClient supabaseClient;

  SupabaseAuthRemoteDS(this.supabaseClient);

  @override
  Future<PecuniaUser> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  }) async {
    final AuthResponse response =
        await supabaseClient.auth.signInWithPassword(email: email, password: password);

    final User? user = response.user;

    if (user == null) {
      throw const AuthException("Your password or email may be incorrect, please try again.");
    }

    throw UnimplementedError();
  }

  @override
  Future<PecuniaUser> registerWithPassword({required String email, required String password}) {
    // TODO: implement registerWithPassword
    throw UnimplementedError();
  }

  @override
  Future<PecuniaUser> getUserInformation() {
    // TODO: implement getUserInformation
    throw UnimplementedError();
  }

  @override
  Future<Unit> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
