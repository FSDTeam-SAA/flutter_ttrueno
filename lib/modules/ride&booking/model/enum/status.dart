enum Status {
  pending,
  active,
  completed;

  factory Status.fromString(String value) {
    switch (value) {
      case 'pending':
        return Status.pending;
      case 'active':
        return Status.active;
      case 'completed':
        return Status.completed;
      default:
        throw ArgumentError('Invalid status string: $value');
    }
  }
}