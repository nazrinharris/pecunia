import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'pecunia_uuid.g.dart';

@Riverpod(keepAlive: true)
Uuid uuid(UuidRef ref) => const Uuid();
