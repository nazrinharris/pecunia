import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase, SupabaseClient;

part 'pecunia_supabase.g.dart';

@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}
