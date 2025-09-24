import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/core/services/app_pigeon/app_pigeon.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/interface/booking_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/booking.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/utils/helpers/format_response_data.dart';

base class BookingService extends BookingInterface{
  final AppPigeon appPigeon;

  BookingService(this.appPigeon);
  
  @override
  FutureRequest<Success<List<Booking>>> getAllBookingsForARide(String rideId) async{
    return asyncTryCatch(tryFunc: ()async{
      final response = await appPigeon.get(ApiEndpoints.getAllBookingsForARide(rideId));
      final data = extractBodyData(response) as List<dynamic>;
      return Success(message: extractSuccessMessage(response), data: data.map((e) => Booking.fromJson(e)).toList());
    });
  }

  @override
  FutureRequest<Success<List<Booking>>> getMyBookings() async{
    return asyncTryCatch(tryFunc: ()async{
      final response = await appPigeon.get(ApiEndpoints.getMyBookings);
      final data = extractBodyData(response) as List<dynamic>;
      return Success(message: extractSuccessMessage(response), data: data.map((e) => Booking.fromJson(e)).toList());
    });
  }

}