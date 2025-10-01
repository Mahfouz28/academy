import 'package:academy/core/data/repo/supanase_repo.dart';
import 'package:academy/features/subscriptions/presentation/cubit/subscriptions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final supabaseRepo = SupanaseRepo();

  SubscriptionsCubit() : super(SubscriptionsInitial());

  /// Renew subscription
  Future<void> renewSubscription(String studentId) async {
    emit(RenewSubscriptionsLoading(studentId));
    try {
      await supabaseRepo.renewSubscription(studentId);

      final students = await supabaseRepo.getStudents();
      final expiredStudents = await supabaseRepo.getExpiredSubscriptions();

      emit(SubscriptionsSummaryLoaded(students, expiredStudents));
    } catch (e) {
      // Log for debugging
      print("Renew error: $e");

      emit(
        RenewSubscriptionsError(
          "Failed to renew subscription. Please try again later.",
        ),
      );
    }
  }

  /// Get all students + expired ones
  Future<void> getAllStudents() async {
    emit(GetAllStudentsLoading());
    try {
      final students = await supabaseRepo.getStudents();
      final expiredStudents = await supabaseRepo.getExpiredSubscriptions();

      emit(SubscriptionsSummaryLoaded(students, expiredStudents));
    } catch (e) {
      print("GetAllStudents error: $e");
      emit(
        GetAllStudentsError(
          "Unable to load students data. Please refresh or try again.",
        ),
      );
    }
  }
}
