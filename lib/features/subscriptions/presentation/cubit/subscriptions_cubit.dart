import 'package:flutter_bloc/flutter_bloc.dart';
import 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  SubscriptionsCubit() : super(SubscriptionsInitial());

  Future<void> doSomething() async {
    emit(SubscriptionsLoading());
    try {
      // Call usecase
      // emit(SubscriptionsSuccess(result));
    } catch (e) {
      emit(SubscriptionsFailure(e.toString()));
    }
  }
}
