import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/data/auth_local_ds.dart';
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
              const Text('Stored logged in users:'),
              const StoredLoggedInUserDetails(),
              const LoginForm(),
              const LoginDetails(),
              const RegisterForm(),
              const RegisterDetails(),
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

class StoredLoggedInUserDetails extends ConsumerWidget {
  const StoredLoggedInUserDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(authLocalDSProvider).getAllLoggedInUsers().run(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.fold(
            (l) => Text(l.toString()),
            (r) {
              final userList = List.of(r.values.toList());
              return ListView.builder(
                shrinkWrap: true,
                itemCount: r.length,
                itemBuilder: (context, index) {
                  return Text(userList[index].toString());
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
