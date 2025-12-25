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
    return BlocProvider(
      create: (context) => WalletCubit(
        addMoneyUseCase: AddMoneyUseCase(WalletRepoImpl(FirebaseFirestore.instance)),
        getWalletBalanceUseCase: GetWalletBalanceUseCase(WalletRepoImpl(FirebaseFirestore.instance)),
      )..fetchBalance(userId),
      child: Scaffold(
        appBar: AppBar(
          title:Text("Wallet",style: AppBarTitleText.poppins,),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: BlocConsumer<WalletCubit, WalletState>(
          listener: (context, state) {
            if (state is WalletErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is WalletLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WalletUpdatedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Balance: \$${state.balance}"),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WalletCubit>().addMoney(userId, 500); // Add $500
                    },
                    child: const Text("Add \$500"),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("Failed to load wallet."));
            }
          },
        ),
      ),
    );
  }
}
