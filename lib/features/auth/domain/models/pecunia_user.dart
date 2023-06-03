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

  factory PecuniaUser.fromJson(Map<String, dynamic> json) => _$PecuniaUserFromJson(json);
}

@freezed
class PecuniaUserDTO with _$PecuniaUserDTO {
  const PecuniaUserDTO._();

  factory PecuniaUserDTO({
    required String uid,
    required String username,
    required DateTime dateCreated,
  }) = _PecuniaUserDTO;

  factory PecuniaUserDTO.fromDomain(PecuniaUser user) {
    return PecuniaUserDTO(
      uid: user.uid,
      username: user.username,
      dateCreated: user.dateCreated,
    );
  }

  PecuniaUser toDomain() {
    return PecuniaUser(
      uid: uid,
      username: username,
      dateCreated: dateCreated,
    );
  }

  factory PecuniaUserDTO.fromJson(Map<String, dynamic> json) => _$PecuniaUserDTOFromJson(json);
}
