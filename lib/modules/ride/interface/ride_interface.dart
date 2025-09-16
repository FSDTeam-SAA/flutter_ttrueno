import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/trycatch.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride/model/post_ride_model.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride/model/ride_model.dart';

abstract base class RideInterface extends Repository {

  FutureRequest<Success<RideModel>> createRide(PostRideModel params);



}