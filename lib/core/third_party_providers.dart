import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

final supabaseProvider = Provider<s.SupabaseClient>((ref) => s.Supabase.instance.client);
