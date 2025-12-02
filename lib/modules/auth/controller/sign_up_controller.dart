import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/interface/auth_interface.dart';
import '../../../core/utils/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../../../app/init_dependency.dart';
import '../model/signup_param.dart';

class SignUpController extends ChangeNotifier {

  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier(initialStatus: EnabledStatus());
  final SnackbarNotifier snackbarNotifier;
  SignUpController(this.snackbarNotifier);
  
  String _name = '';
  String get name => _name;
  set name(String value) {
    debugPrint("Setting name to $value");   
    if (value != _name) {
      _name = value;
      processStatusNotifier.setEnabled();
      notifyListeners();
    }
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    debugPrint("Setting email to $value");
    if (value != _email) {
      _email = value;
      processStatusNotifier.setEnabled();
      notifyListeners();
    }
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    debugPrint("Setting password to $value");
    if (value != _password) {
      _password = value;
      processStatusNotifier.setEnabled();
      notifyListeners();
    }
  }

  String _confirmPassword = '';

  
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String value) {
    if (value != _confirmPassword) {
      _confirmPassword = value;
      processStatusNotifier.setEnabled();
      notifyListeners();
    }
  }


  Future<void> signup({required ProcessStatusNotifier? buttonNotifier, required SnackbarNotifier? snackbarNotifier}) async {
    buttonNotifier?.setLoading();
    Future.delayed(const Duration(seconds: 1)).then((_) async{
      await serviceLocator<AuthInterface>()
      .signup(SignupParam(name: name, email: email, password: password, confirmPassword: confirmPassword))
      .then((lr) {
          handleFold(
            either: lr,
            processStatusNotifier: buttonNotifier,
            successSnackbarNotifier: snackbarNotifier,
            errorSnackbarNotifier: snackbarNotifier
          );
      });
    }); // Simulate a delay for loading state
  }

  Future<void> googleLogin() async{
    processStatusNotifier.setLoading();
    await serviceLocator<AuthInterface>().googleLogin().then((lr) {
        handleFold(
          either: lr,
          //processStatusNotifier: processStatusNotifier,
          successSnackbarNotifier: snackbarNotifier,
          //errorSnackbarNotifier: snackbarNotifier,
        );
      });
    processStatusNotifier.setEnabled();
  }

  Future<void> facebookLogin() async{
    processStatusNotifier.setLoading();
    await serviceLocator<AuthInterface>().facebookLogin().then((lr) {
        handleFold(
          either: lr,
          //processStatusNotifier: processStatusNotifier,
          successSnackbarNotifier: snackbarNotifier,
          //errorSnackbarNotifier: snackbarNotifier,
        );
      });
    processStatusNotifier.setEnabled();
  }
}
