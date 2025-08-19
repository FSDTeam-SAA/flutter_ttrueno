import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/failure.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/handle_fold.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/snackbar_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/domains/entity/login_entity.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/domains/usecases/login.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';


import '../../../../core/notifiers/button_status_notifier.dart';

class LoginController extends ChangeNotifier {
  String _email = '';
  String get email => _email;
  set email(String value) {
    if (value != _email) {
      _email = value;
      notifyListeners();
    }
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    if (value != _password) {
      _password = value;
      notifyListeners();
    }
  }

  Future<void> login({
    required ButtonStatusNotifier? buttonNotifier,
    required SnackbarNotifier? snackbarNotifier,
    required VoidCallback needVerification,
  }) async {
    buttonNotifier?.setLoading();
    Future.delayed(const Duration(seconds: 1)).then((_) async {
      await serviceLocator<Login>()
          .call(LoginRequestParams(email: email, password: password))
          .then((lr) {
            handleFold(
              either: lr,
              buttonStatusNotifier: buttonNotifier,
              snackbarNotifier: snackbarNotifier,
              onError: (error) {
                if (error.failure == Failure.forbidden) needVerification();
              },
            );
          });
    }); // Simulate a delay for loading state
  }
}
