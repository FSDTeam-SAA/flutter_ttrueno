import 'package:ttrueno_fo827e642a0c4/core/service_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/service_handler/error_catcher.dart';
import 'package:ttrueno_fo827e642a0c4/core/utils/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/booking.dart';

abstract base class BookingInterface extends ErrorCatcher{
  FutureRequest<Success<List<Booking>>> getMyBookings();

  FutureRequest<Success<List<Booking>>> getAllBookingsForARide(String rideId);
}

