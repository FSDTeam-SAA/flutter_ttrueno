import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/trycatch.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/change_password_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';

 abstract base class ProfileInterface extends Repository{
  
  FutureRequest<Success> changePassword(ChangePassowrdParam params);

  FutureRequest<Success<UserProfile>> getUserProfilebyId(String id);
  
}