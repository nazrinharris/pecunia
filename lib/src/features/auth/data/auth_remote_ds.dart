import 'package:fpdart/fpdart.dart';
import 'package:pecunia/src/features/auth/domain/pecunia_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDS {
  Future<PecuniaUser> loginWithPassword(String email, String password);

  Future<PecuniaUser> registerWithPassword(String email, String password);

  Future<PecuniaUser> getUserInformation();

  Future<Unit> logout();
}

class SupabaseAuthRemoteDS implements AuthRemoteDS {
  final SupabaseClient supabaseClient;

  SupabaseAuthRemoteDS(this.supabaseClient);

  @override
  Future<PecuniaUser> loginWithPassword(String email, String password) async {
    final response = await supabaseClient.auth.signInWithPassword(email: email, password: password);
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

  @override
  Future<PecuniaUser> registerWithPassword(String email, String password) {
    // TODO: implement registerWithPassword
    throw UnimplementedError();
  }
}
