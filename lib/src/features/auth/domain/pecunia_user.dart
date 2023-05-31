import 'package:freezed_annotation/freezed_annotation.dart';

part 'pecunia_user.freezed.dart';
part 'pecunia_user.g.dart';

@freezed
class PecuniaUser with _$PecuniaUser {
  const PecuniaUser._();

  factory PecuniaUser({
    required String uid,
    required String username,
    required DateTime dateCreated,
  }) = _PecuniaUser;

  factory PecuniaUser.fromJson(Map<String, dynamic> json) =>
      _$PecuniaUserFromJson(json);
}
