import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences_constants.dart';
import 'package:pecunia/core/util/logger.dart';
import 'package:pecunia/core/util/pecunia_crypto.dart';
import 'package:pecunia/features/auth/data/auth_local_ds.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:pecunia/features/auth/usecases/login_with_password.dart';
import 'package:pecunia/features/auth/usecases/register_with_password.dart';
import 'package:pecunia/presentation/debug/debug_auth/debug_auth_providers.dart';
import 'package:pecunia/presentation/screens/auth/login_screen.dart';
import 'package:pecunia/presentation/screens/auth/register_screen.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';

class DebugLoginAndRegisterScreen extends HookConsumerWidget {
  const DebugLoginAndRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen<AsyncValue<bool>>(navigateToDebugLocalDBProvider, (prev, next) {
        if (next.runtimeType == AsyncData<bool>) {
          next.value!
              ? context.pushNamed('debug-local-db')
              : debugPrint(
                  'Not navigating to debug local db',
                );
        }

        if (next.runtimeType == AsyncError<bool>) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: 'You cannot navigate to DebugLocalDB',
                failure: next.error as AuthFailure?,
              );
        }
      })
      ..listen(loginWithEmailAndPasswordProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't log you in.",
                failure: next.error as AuthFailure?,
              );
        }
      })
      ..listen(registerWithEmailAndPasswordProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't register an account for you.",
                failure: next.error as AuthFailure?,
              );
        }
      });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text('Debug Login & Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              const Text('Users saved in "$kPrefsSavedUsers" in shared_preferences:'),
              const StoredSavedUserDetails(),
              const SizedBox(height: 24),
              const Text('Sessions saved in flutter_secure_storage:'),
              const LocalSessions(),
              const SizedBox(height: 14),
              Container(
                height: 36,
                alignment: Alignment.centerLeft,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(debugGetAllSessionsProvider);
                      },
                      child: const Text('Refresh Sessions'),
                    ),
                    const SizedBox(width: 14),
                    ElevatedButton(
                      onPressed: () async {
                        final storage = ref.read(pecuniaFlutterSecureStorageProvider).requireValue;

                        final allRead = await storage.readAll();
                        final sessions = allRead.keys.where((key) => key.contains('pecunia_user_token_'));
                        debugPrint('Sessions: $sessions : ${allRead[sessions.first]}');
                      },
                      child: const Text('Print All Sessions'),
                    ),
                    const SizedBox(width: 14),
                    ElevatedButton(
                      onPressed: () async {
                        final crypto = ref.read(pecuniaCryptoProvider);
                        final key = crypto.generateSalt();
                        debugPrint(key);
                      },
                      child: const Text('Print Random Key'),
                    ),
                    const SizedBox(width: 14),
                    ElevatedButton(
                      onPressed: () async {
                        final storage = ref.read(pecuniaFlutterSecureStorageProvider).requireValue;

                        final allRead = await storage.readAll();
                        debugPrint('All Read: $allRead');

                        final uids = allRead.keys.where((key) => key.contains('pecunia_user_uid_'));
                        for (final element in uids) {
                          debugPrint('UID: $element : ${allRead[element]}');
                        }
                      },
                      child: const Text('Print All Local Users'),
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 36,
                alignment: Alignment.centerLeft,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                              title: 'Clear All Sessions',
                              message: 'This will delete all sessions.',
                              onConfirm: () async {
                                final storage = ref.read(pecuniaFlutterSecureStorageProvider).requireValue;

                                final allRead = await storage.readAll();
                                final sessions =
                                    allRead.keys.where((key) => key.contains('pecunia_user_token_'));

                                for (final session in sessions) {
                                  await storage
                                      .delete(key: session)
                                      .then((_) => debugPrint('Deleted $session'));
                                }
                              },
                              context: context,
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red[100]!.withOpacity(0.1),
                      ),
                      child: const Text('CLEAR ALL SESSIONS'),
                    ),
                    const SizedBox(width: 14),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                              title: 'Clear Flutter Secure Storage',
                              message:
                                  'Are you sure you want to clear all data in Flutter Secure Storage?, This will delete all local user credentials and all sessions. May have unintended consequences. User-specific database data will not be deleted.',
                              onConfirm: () async {
                                await ref.read(pecuniaFlutterSecureStorageProvider).requireValue.deleteAll();
                                ref.invalidate(debugGetAllSessionsProvider);
                              },
                              context: context,
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red[100]!.withOpacity(0.1),
                      ),
                      child: const Text('CLEAR FLUTTER SECURE STORAGE'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const LocalUsers(),
              const SizedBox(height: 14),
              Container(
                height: 36,
                alignment: Alignment.centerLeft,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(debugGetLocalUsersProvider);
                      },
                      child: const Text('Refresh Local Users'),
                    ),
                    const SizedBox(width: 14),
                    ElevatedButton(
                      onPressed: () async {
                        final secure = ref.read(pecuniaFlutterSecureStorageProvider).requireValue;
                        final allRead = await secure.readAll();
                        debugPrint('All Read');
                        prettyPrintJson(allRead);
                      },
                      child: const Text('Print All Read'),
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 36,
                alignment: Alignment.centerLeft,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                              title: 'Delete All Local Users',
                              message:
                                  'This will delete all local users. This will not delete any sessions or the user-specific database data.',
                              onConfirm: () async {
                                final storage = ref.read(pecuniaFlutterSecureStorageProvider).requireValue;

                                final allRead = await storage.readAll();
                                final uids = allRead.keys.where((key) => key.contains('pecunia_user_uid_'));

                                for (final uidKey in uids) {
                                  debugPrint(allRead[uidKey]);
                                  final securedStorageManager = AuthSecuredStorageManager(storage);
                                  (await securedStorageManager
                                          .deleteUserDataAndCredentials(allRead[uidKey]!)
                                          .run())
                                      .fold(
                                    (l) => debugPrint(l.toString()),
                                    (r) => debugPrint('Deleted $r'),
                                  );
                                }

                                ref.invalidate(debugGetLocalUsersProvider);
                              },
                              context: context,
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red[100]!.withOpacity(0.1),
                      ),
                      child: const Text('DELETE ALL LOCAL USERS'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const ActiveSession(),
              const LocalAuthentication(),
              const RemoteAuthentication(),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed('debug-local-db');
                },
                child: const Text('Navigate to DebugLocalDB'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveSession extends ConsumerWidget {
  const ActiveSession({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSession = ref.watch(debugGetActiveSessionProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Active Session'),
        const SizedBox(height: 14),
        switch (activeSession) {
          AsyncLoading() => const Center(
              child: CupertinoActivityIndicator(),
            ),
          AsyncError(:final Failure error) => Text(error.toString()),
          AsyncData(:final Option<Session> value) when value.isNone() =>
            const Text('No active session found'),
          AsyncData(:final Option<Session> value) => Text(value.toString()),
          _ => const Text('Unknown state'),
        },
        const SizedBox(height: 14),
        Container(
          height: 36,
          alignment: Alignment.centerLeft,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ElevatedButton(
                onPressed: () async {
                  ref.invalidate(debugGetActiveSessionProvider);
                },
                child: const Text('Refresh Active Session'),
              ),
              const SizedBox(width: 14),
              ElevatedButton(
                onPressed: () {
                  ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                        title: 'Remove Active Session',
                        message:
                            'This will remove the active session. It will NOT delete the actual session.',
                        onConfirm: () async {
                          final sessionManager = AuthLocalSessionManager(
                              ref.read(pecuniaFlutterSecureStorageProvider).requireValue);

                          await sessionManager.removeActiveSession().run();
                        },
                        context: context,
                      );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red[100]!.withOpacity(0.1),
                ),
                child: const Text('REMOVE ACTIVE SESSION'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StoredSavedUserDetails extends ConsumerWidget {
  const StoredSavedUserDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Allow to clear all saved users
    // TODO: Add a debug method to clear saved users that do not have database and/or local user data
    return FutureBuilder(
      future: ref.watch(authLocalDSProvider).getAllSavedUsers().run(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.fold(
            (l) => Text(l.toString()),
            (r) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: r.length,
                itemBuilder: (context, index) {
                  return Text(r[index].toString());
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}

class LocalSessions extends ConsumerWidget {
  const LocalSessions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(debugGetAllSessionsProvider);

    return switch (sessions) {
      AsyncLoading() => const Center(
          child: CupertinoActivityIndicator(),
        ),
      AsyncError(:final Failure error) => Text(error.toString()),
      AsyncData(:final List<Session> value) when value.isEmpty => const Text('No sessions found'),
      AsyncData(:final List<Session> value) => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.length,
          itemBuilder: (context, index) {
            return Text(value[index].toString());
          },
        ),
      _ => const Text('Unknown state'),
    };
  }
}

class LocalUsers extends ConsumerWidget {
  const LocalUsers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(debugGetLocalUsersProvider);

    return switch (users) {
      AsyncLoading() => const Center(
          child: CupertinoActivityIndicator(),
        ),
      AsyncError(:final Failure error) => Text(error.toString()),
      AsyncData(:final List<PecuniaUser> value) when value.isEmpty => const Text('No local users found'),
      AsyncData(:final List<PecuniaUser> value) => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value[index].uid,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontStyle: FontStyle.italic,
                            )),
                    RichText(
                      text: TextSpan(
                        text: 'username: ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                            ),
                        children: [
                          TextSpan(
                            text: value[index].username,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'email: ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                            ),
                        children: [
                          TextSpan(
                            text: value[index].email ?? 'null',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    FutureBuilder<({String? hashedPassword, String? salt})>(future: () async {
                      final hashedPassword = await ref
                          .read(pecuniaFlutterSecureStorageProvider)
                          .requireValue
                          .read(key: 'pecunia_user_hashed_password_${value[index].uid}');
                      final salt = await ref
                          .read(pecuniaFlutterSecureStorageProvider)
                          .requireValue
                          .read(key: 'pecunia_user_salt_${value[index].uid}');
                      return (hashedPassword: hashedPassword, salt: salt);
                    }(), builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'hashed_password: ',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                    ),
                                children: [
                                  TextSpan(
                                    text: snapshot.data!.hashedPassword,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'salt: ',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                    ),
                                children: [
                                  TextSpan(
                                    text: snapshot.data!.salt ?? 'null',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            if (snapshot.data!.salt != null)
                              Container(
                                width: 160,
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.yellow.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.warning, color: Colors.yellow, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Deprecated Local User',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.yellow),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                    })
                  ],
                ),
              ),
            );
          },
        ),
      _ => const Text('Unknown state'),
    };
  }
}

class LocalAuthentication extends HookConsumerWidget {
  const LocalAuthentication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(debugLocalLoginWithEmailAndPasswordProvider, (previous, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't log you in.",
                failure: next.error as AuthFailure?,
              );
        }
        if (next is AsyncData<Option<PecuniaUser>> && next.value.isSome()) {
          ref.read(pecuniaDialogsProvider).showSuccessToast(
                context: context,
                title: 'Local Login Success!',
              );
          ref
            ..invalidate(debugGetAllSessionsProvider)
            ..invalidate(debugGetActiveSessionProvider);
        }
      })
      ..listen(debugLocalRegisterWithEmailAndPasswordProvider, (previous, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't register an account for you.",
                failure: next.error as AuthFailure?,
              );
        }
        if (next is AsyncData<Option<PecuniaUser>> && next.value.isSome()) {
          ref.read(pecuniaDialogsProvider).showSuccessToast(
                context: context,
                title: 'Local Register Success!, ${next.value}',
              );
        }
      });

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 24, bottom: 14),
              child: Text(
                'Local Authentication',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(debugLocalLoginWithEmailAndPasswordProvider.notifier)
                              .debugLoginWithEmailAndPassword(
                                emailController.text,
                                passwordController.text,
                              );
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(width: 24),
                      ElevatedButton(
                        onPressed: () async {
                          await ref.read(authRepoProvider).logout().run();

                          ref
                            ..invalidate(debugGetAllSessionsProvider)
                            ..invalidate(debugGetActiveSessionProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.red[100]!.withOpacity(0.1),
                        ),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const LocalRegisterForm(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocalRegisterForm extends HookConsumerWidget {
  const LocalRegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    return Form(
      key: formKey.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: RegisterFields.validateEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: RegisterFields.validateUsername,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            validator: RegisterFields.validatePassword,
          ),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
            ),
            validator: (val) => RegisterFields.validateConfirmPassword(val, passwordController.text),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.value.currentState!.validate()) {
                debugPrint(
                    'Valid form: ${emailController.text}, ${usernameController.text}, ${passwordController.text}, ${confirmPasswordController.text}');
                ref
                    .read(debugLocalRegisterWithEmailAndPasswordProvider.notifier)
                    .debugRegisterWithEmailAndPassword(
                      usernameController.text,
                      emailController.text,
                      confirmPasswordController.text,
                    );
              }
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

class RemoteAuthentication extends ConsumerWidget {
  const RemoteAuthentication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 24),
              child: Text(
                'Remote Authentication',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const LoginForm(),
            const LoginDetails(),
            const RegisterForm(),
            const RegisterDetails(),
          ],
        ),
      ),
    );
  }
}

class LoginDetails extends HookConsumerWidget {
  const LoginDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginWithEmailAndPasswordProvider);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: state.when(
          data: (data) {
            return Column(
              children: [
                Text(data.toString()),
              ],
            );
          },
          error: (e, stack) {
            final error = e as Failure;
            return Column(
              children: [
                Text(error.message),
              ],
            );
          },
          loading: () {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ));
  }
}

class RegisterDetails extends HookConsumerWidget {
  const RegisterDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerWithEmailAndPasswordProvider);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: state.when(
          data: (data) {
            return Column(
              children: [
                Text(data.toString()),
              ],
            );
          },
          error: (e, stack) {
            final error = e as Failure;
            return Column(
              children: [
                Text(error.message),
              ],
            );
          },
          loading: () {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ));
  }
}
