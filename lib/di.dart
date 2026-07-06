import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emvigo/features/create_profile/data/data_sources/i_user_profile_remote_ds.dart';
import 'package:emvigo/features/create_profile/data/domain_impl/user_profile_remote_ds_impl.dart';
import 'package:emvigo/features/create_profile/data/domain_impl/user_profile_repo_impl.dart';
import 'package:emvigo/features/create_profile/domain/repositories/i_user_profile_repo.dart';
import 'package:emvigo/features/create_profile/domain/use_cases/create_profile_use_case.dart';
import 'package:emvigo/features/create_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:emvigo/features/sign_in/data/data_sources/i_sign_in_remote_ds.dart';
import 'package:emvigo/features/sign_in/data/domain_impl/sign_in_remote_ds_impl.dart';
import 'package:emvigo/features/sign_in/data/domain_impl/sign_in_repo_impl.dart';
import 'package:emvigo/features/sign_in/domain/repositories/I_sign_in_repo.dart';
import 'package:emvigo/features/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:emvigo/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:emvigo/features/sign_up/data/data_sources/i_sign_up_remote_ds.dart';
import 'package:emvigo/features/sign_up/data/domain_impl/sign_up_remote_ds_impl.dart';
import 'package:emvigo/features/sign_up/data/domain_impl/sign_up_repo_impl.dart';
import 'package:emvigo/features/sign_up/domain/repositories/i_sign_up_repo.dart';
import 'package:emvigo/features/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:emvigo/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:emvigo/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  final FirebaseApp firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Firebase Services
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

  /// Repositories
  serviceLocator.registerLazySingleton<ISignInRemoteDs>(
    () => SignInRemoteDsImpl(firebaseAuth: serviceLocator<FirebaseAuth>()),
  );
  serviceLocator.registerLazySingleton<ISignInRepo>(
    () => SignInRepoImpl(signInRemoteDs: serviceLocator<ISignInRemoteDs>()),
  );
  serviceLocator.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(signInRepo: serviceLocator<ISignInRepo>()),
  );
  serviceLocator.registerLazySingleton<SignInBloc>(
    () => SignInBloc(signInUseCase: serviceLocator<SignInUseCase>()),
  );
  serviceLocator.registerLazySingleton<ISignUpRemoteDs>(
    () => SignUpRemoteDsImpl(firebaseAuth: serviceLocator<FirebaseAuth>()),
  );
  serviceLocator.registerLazySingleton<ISignUpRepo>(
    () => SignUpRepoImpl(signUpRemoteDs: serviceLocator<ISignUpRemoteDs>()),
  );
  serviceLocator.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(signUpRepo: serviceLocator<ISignUpRepo>()),
  );
  serviceLocator.registerLazySingleton<SignUpBloc>(
    () => SignUpBloc(signUpUseCase: serviceLocator<SignUpUseCase>()),
  );
  serviceLocator.registerLazySingleton<IUserProfileRemoteDs>(
    () => UserProfileRemoteDsImpl(
      firestore: serviceLocator<FirebaseFirestore>(),
      firebaseAuth: serviceLocator<FirebaseAuth>(),
    ),
  );
  serviceLocator.registerLazySingleton<IUserProfileRepo>(
    () => UserProfileRepoImpl(serviceLocator<IUserProfileRemoteDs>()),
  );
  serviceLocator.registerLazySingleton<CreateProfileUseCase>(
    () => CreateProfileUseCase(
      userProfileRepo: serviceLocator<IUserProfileRepo>(),
    ),
  );
  serviceLocator.registerLazySingleton<UserProfileBloc>(
    () => UserProfileBloc(
      createUserProfileUseCase: serviceLocator<CreateProfileUseCase>(),
    ),
  );
}
