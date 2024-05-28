import 'package:finmaker/features/auth/data/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: Colors.grey,
      child: Column(
        children: [
          const Spacer(),
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
