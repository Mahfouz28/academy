abstract class SubscriptionsState {}

class SubscriptionsInitial extends SubscriptionsState {}

class SubscriptionsLoading extends SubscriptionsState {}

class SubscriptionsSuccess extends SubscriptionsState {
  // final result;
  // Success(this.result);
}

class SubscriptionsFailure extends SubscriptionsState {
  final String error;
  SubscriptionsFailure(this.error);
}
