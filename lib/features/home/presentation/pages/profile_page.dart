import 'package:e_commerce_app/features/constants/text_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/presentation/profile-cubit/profile_cubit.dart';
import '../../../profile/presentation/profile-cubit/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFFF5722);
    const darkOnboard = Color(0xFF1E1E24);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: AppBarTitleText.poppins.copyWith(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: darkOnboard,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: primaryOrange),
            );
          }
          if (state.errorMessage != null) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage}',
                style: const TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            );
          }
          if (state.profile == null) {
            return const Center(
              child: Text(
                "User not found",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final profile = state.profile!;
          final bool hasValidImage = profile.profileImage.isNotEmpty;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              children: [

                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryOrange, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha:0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 54,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: hasValidImage ? NetworkImage(profile.profileImage) : null,
                          child: !hasValidImage
                              ? const Icon(Icons.person_rounded, size: 60, color: darkOnboard)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.name,
                  style: BoldTextStyle.poppins.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  profile.email,
                  style: LightTextStyle.poppins.copyWith(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 32),

                // --- INFO TILES ---
                buildProfileTile(
                  context: context,
                  icon: Icons.person_outline_rounded,
                  label: "FULL NAME",
                  value: profile.name,
                ),
                const SizedBox(height: 16),

                buildProfileTile(
                  context: context,
                  icon: Icons.email_outlined,
                  label: "EMAIL ADDRESS",
                  value: profile.email,
                ),
                const SizedBox(height: 16),

                // --- LOGOUT ACTION BUTTON ---
                Material(
                  color: Colors.redAccent.withValues(alpha:0.08),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () {
                      // Trigger Logout on your AuthCubit here
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withValues(alpha:0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 22),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Refactored Helper Tile with correct dynamic parameters
  Widget buildProfileTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    const primaryOrange = Color(0xFFFF5722);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryOrange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryOrange, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E1E24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}