import 'package:academy/core/helpers/snack_bar_helper.dart';
import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/core/widgets/show_info_card.dart';
import 'package:academy/features/subscriptions/presentation/cubit/subscriptions_cubit.dart';
import 'package:academy/features/subscriptions/presentation/cubit/subscriptions_state.dart';
import 'package:academy/features/subscriptions/presentation/widgets/show_subs_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Subscriptions Page'),
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.foreground,
        elevation: 0,
      ),
      drawer: AcademyDrawer(),
      body: SafeArea(
        child: BlocConsumer<SubscriptionsCubit, SubscriptionsState>(
          listener: (context, state) {
            if (state is RenewSubscriptionsError) {
              SnackBarHelper.show(
                context,
                'Error: ${state.message}',
                type: SnackBarType.error,
              );
            } else if (state is RenewSubscriptionsSuccess) {
              SnackBarHelper.show(
                context,
                state.message,
                type: SnackBarType.success,
              );
            }
          },
          builder: (context, state) {
            if (state is GetAllStudentsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetAllStudentsError) {
              return Center(
                child: Text(
                  'Failed to load students: ${state.message}',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state is SubscriptionsSummaryLoaded ||
                state is RenewSubscriptionsLoading ||
                state is RenewSubscriptionsSuccess ||
                state is ExpireAllSubscriptionsLoading ||
                state is ExpireAllSubscriptionsError ||
                state is ExpireAllSubscriptionsSuccess) {
              final students = (state is SubscriptionsSummaryLoaded)
                  ? state.allStudents
                  : (state is RenewSubscriptionsSuccess)
                  ? state.allStudents
                  : (state is ExpireAllSubscriptionsSuccess)
                  ? []
                  : [];

              final expiredSubscriptions = (state is SubscriptionsSummaryLoaded)
                  ? state.expiredStudents
                  : (state is RenewSubscriptionsSuccess)
                  ? state.expiredStudents
                  : (state is ExpireAllSubscriptionsSuccess)
                  ? []
                  : [];

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 22.r, vertical: 16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subscriptions',
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      'Manage student subscriptions and payments',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.sp,
                        color: AppColors.mutedForeground,
                      ),
                    ),

                    16.verticalSpace,

                    /// First row (Total Students + Active Subscriptions)
                    Row(
                      children: [
                        Expanded(
                          child: ShowInfoCard(
                            title: 'Total\nStudents',
                            count: '${students.length}',
                            countColor: AppColors.accent,
                            icon: Icons.people_alt_rounded,
                            iconColor: AppColors.accent,
                            iconBackgroundColor: AppColors.accent.withOpacity(
                              0.1,
                            ),
                            iconBorderColor: AppColors.accent,
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: ShowInfoCard(
                            title: 'Active\nSubscriptions',
                            count:
                                '${students.where((s) => s.subscriptionStatus == 'active').length}',
                            countColor: Colors.green,
                            icon: Icons.check_circle,
                            iconColor: Colors.green,
                            iconBackgroundColor: Colors.green.withOpacity(0.1),
                            iconBorderColor: Colors.green,
                          ),
                        ),
                      ],
                    ),

                    12.verticalSpace,

                    /// Second row (Expired + Monthly Revenue)
                    Row(
                      children: [
                        Expanded(
                          child: ShowInfoCard(
                            title: 'Expired',
                            count: '${expiredSubscriptions.length}',
                            countColor: Colors.red,
                            icon: Icons.cancel_rounded,
                            iconColor: Colors.red,
                            iconBackgroundColor: Colors.red.withOpacity(0.1),
                            iconBorderColor: Colors.red,
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: ShowInfoCard(
                            title: 'Monthly\nRevenue',
                            count:
                                '\$ ${students.where((s) => s.subscriptionStatus == 'active').length * 140}',
                            countColor: Colors.orangeAccent,
                            icon: Icons.monetization_on,
                            iconColor: Colors.orangeAccent,
                            iconBackgroundColor: Colors.orangeAccent
                                .withOpacity(0.1),
                            iconBorderColor: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),

                    20.verticalSpace,

                    // ====== All Subscriptions Section ======
                    AppCard(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on_outlined,
                                  color: AppColors.accent,
                                ),
                                8.horizontalSpace,
                                Text(
                                  'All Subscriptions',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.foreground,
                                  ),
                                ),
                                const Spacer(),
                                if (state is ExpireAllSubscriptionsLoading)
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                else
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.refresh,
                                          color: AppColors.accent,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<SubscriptionsCubit>()
                                              .getAllStudents();
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.clear_all,
                                          color: AppColors.accent,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (dialogContext) => AlertDialog(
                                              title: const Text(
                                                'Confirm Expiration',
                                                style: TextStyle(
                                                  color: AppColors.foreground,
                                                ),
                                              ),
                                              content: const Text(
                                                'Are you sure you want to expire all subscriptions? This action cannot be undone.',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.mutedForeground,
                                                ),
                                              ),
                                              backgroundColor: AppColors.card,
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                        dialogContext,
                                                      ),
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      color: AppColors.accent,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                          SubscriptionsCubit
                                                        >()
                                                        .expireAllSubscriptions();
                                                    Navigator.pop(
                                                      dialogContext,
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Expire All',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                              ],
                            ),

                            16.verticalSpace,

                            // ====== Students list ======
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                final student = students[index];
                                final isLoading =
                                    state is RenewSubscriptionsLoading &&
                                    (state).studentId == student.id;

                                return ShowSubsCard(
                                  studentName: student.name,
                                  status: student.subscriptionStatus,
                                  price: 140,
                                  startDate: DateTime.now(),
                                  endDate: DateTime.now().add(
                                    const Duration(days: 30),
                                  ),
                                  studentId: student.id,
                                  onRenew: () {
                                    context
                                        .read<SubscriptionsCubit>()
                                        .renewSubscription(student.id);
                                  },
                                  isLoading: isLoading,
                                );
                              },
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 16.h),
                              itemCount: students.length,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Default
            return const Center(
              child: Text(
                'Welcome! Please load subscriptions.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}
