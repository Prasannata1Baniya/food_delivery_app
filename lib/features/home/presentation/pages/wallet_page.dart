import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/constants/text_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../wallet/data/repo/wallet_repo_impl.dart';
import '../../../wallet/domain/use-case/wallet_use_case.dart';
import '../../../wallet/presentation/cubit/wallet_cubit.dart';
import '../../../wallet/presentation/cubit/wallet_state.dart';

class WalletPage extends StatelessWidget {
  final String userId;

  const WalletPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFFF5722);
    const darkOnboard = Color(0xFF1E1E24);

    return BlocProvider(
      create: (context) => WalletCubit(
        addMoneyUseCase: AddMoneyUseCase(WalletRepoImpl(FirebaseFirestore.instance)),
        getWalletBalanceUseCase: GetWalletBalanceUseCase(WalletRepoImpl(FirebaseFirestore.instance)),
      )..fetchBalance(userId),
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFB),
        appBar: AppBar(
          title: Text("My Wallet", style: AppBarTitleText.poppins.copyWith(fontSize: 20, color: Colors.white)),
          centerTitle: true,
          backgroundColor: darkOnboard,
          elevation: 0,
        ),
        body: BlocConsumer<WalletCubit, WalletState>(
          listener: (context, state) {
            if (state is WalletErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error), backgroundColor: Colors.redAccent),
              );
            }
          },
          builder: (context, state) {
            if (state is WalletLoadingState) {
              return const Center(child: CircularProgressIndicator(color: primaryOrange));
            }

            // Safely parse balance regardless of whether Firestore returns int or double
            double currentBalance = 0.0;
            if (state is WalletUpdatedState) {
              currentBalance = (state.balance as num).toDouble();
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- PREMIUM WALLET CARD ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [darkOnboard, Color(0xFF2C2C35)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gourmet Pay",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                            const Icon(Icons.account_balance_wallet_rounded, color: primaryOrange, size: 28),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Total Balance",
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "\$${currentBalance.toStringAsFixed(2)}",
                          style: BoldTextStyle.poppins.copyWith(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- ADD FUNDS SECTION ---
                  Text(
                    "TOP UP WALLET",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Quick amount selector buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [10, 20, 50, 100].map((amount) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(color: primaryOrange.withValues(alpha: 0.5)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              context.read<WalletCubit>().addMoney(userId, amount);
                            },
                            child: Text(
                              "+\$$amount",
                              style: const TextStyle(
                                color: primaryOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Main Add Funds Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<WalletCubit>().addMoney(userId, 50);
                      },
                      icon: const Icon(Icons.add_rounded, color: Colors.white),
                      label: const Text("Add \$50.00 Quick Top-Up", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 2,
                        shadowColor: primaryOrange.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}