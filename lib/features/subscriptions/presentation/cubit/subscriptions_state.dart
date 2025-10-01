abstract class SubscriptionsState {}

class SubscriptionsInitial extends SubscriptionsState {}

// Loading states
class GetAllStudentsLoading extends SubscriptionsState {}

class RenewSubscriptionsLoading extends SubscriptionsState {
  final String studentId;
  RenewSubscriptionsLoading(this.studentId);
}

// Error states
class GetAllStudentsError extends SubscriptionsState {
  final String message;
  GetAllStudentsError(this.message);
}

class RenewSubscriptionsError extends SubscriptionsState {
  final String message;
  RenewSubscriptionsError(this.message);
}

// Success states
class SubscriptionsSummaryLoaded extends SubscriptionsState {
  final List<dynamic> allStudents;
  final List<dynamic> expiredStudents;
  SubscriptionsSummaryLoaded(this.allStudents, this.expiredStudents);
}

class RenewSubscriptionsSuccess extends SubscriptionsState {
  final String message;
  final List<dynamic> allStudents;
  final List<dynamic> expiredStudents;
  RenewSubscriptionsSuccess(
    this.message,
    this.allStudents,
    this.expiredStudents,
  );
}

class ExpireAllSubscriptionsLoading extends SubscriptionsState {}

class ExpireAllSubscriptionsError extends SubscriptionsState {
  final String message;
  ExpireAllSubscriptionsError(this.message);
}

class ExpireAllSubscriptionsSuccess extends SubscriptionsState {
  final String message;
  ExpireAllSubscriptionsSuccess(this.message);
}
