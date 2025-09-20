enum Status {
  pending,
  accepted,
  rejected,
  cancelled,
  completed;

  factory Status.fromString(String value) {
    switch (value) {
      case 'pending':
        return Status.pending;
      case 'accepted':
        return Status.accepted;
      case 'rejected':
        return Status.rejected;
      case 'cancelled':
        return Status.cancelled;
      case 'completed':
        return Status.completed;
      default:
        throw ArgumentError('Invalid status string: $value');
    }
  }
}