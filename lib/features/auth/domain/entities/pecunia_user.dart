import 'package:freezed_annotation/freezed_annotation.dart';

part 'pecunia_user.freezed.dart';
part 'pecunia_user.g.dart';

@freezed
class PecuniaUser with _$PecuniaUser {
  factory PecuniaUser({
    required String uid,
    required String username,
    required DateTime dateCreated,
    String? email,
  }) = _PecuniaUser;

  const PecuniaUser._();

  factory PecuniaUser.empty() => PecuniaUser(
        uid: '',
        username: '',
        dateCreated: DateTime.now(),
        email: '',
      );

  factory PecuniaUser.fromJson(Map<String, dynamic> json) => _$PecuniaUserFromJson(json);

  factory PecuniaUser.fromDTO(PecuniaUserDTO dto) {
    return PecuniaUser(
      uid: dto.uid,
      username: dto.username,
      dateCreated: dto.dateCreated,
      email: dto.email,
    );
  }
}

@freezed
class PecuniaUserDTO with _$PecuniaUserDTO {
  factory PecuniaUserDTO({
    required String uid,
    required String username,
    required DateTime dateCreated,
    String? email,
  }) = _PecuniaUserDTO;

  const PecuniaUserDTO._();

  factory PecuniaUserDTO.fromJson(Map<String, dynamic> json) => _$PecuniaUserDTOFromJson(json);

  factory PecuniaUserDTO.fromDomain(PecuniaUser user) {
    return PecuniaUserDTO(
      uid: user.uid,
      username: user.username,
      dateCreated: user.dateCreated,
      email: user.email,
    );
  }

  PecuniaUser toDomain() {
    return PecuniaUser(
      uid: uid,
      username: username,
      dateCreated: dateCreated,
      email: email,
    );
  }
}
