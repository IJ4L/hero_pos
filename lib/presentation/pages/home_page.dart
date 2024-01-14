// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';
import 'package:svg_flutter/svg_flutter.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int seleceted = navigationShell.currentIndex;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        elevation: 12,
        height: 62.h,
        selectedIndex: navigationShell.currentIndex,
        backgroundColor: AppColor.white,
        indicatorColor: AppColor.transparent,
        surfaceTintColor: AppColor.transparent,
        shadowColor: AppColor.grey,
        destinations: [
          const SizedBox(),
          NavigationDestinantionCostume(
            seleceted: seleceted,
            onPressed: () => _goBranch(0),
            icon: "ic_home",
            index: 0,
          ),
          const SizedBox(),
          NavigationDestinantionCostume(
            seleceted: seleceted,
            onPressed: () => {
              context.read<TroliCubit>().reset(),
              _goBranch(1),
            },
            icon: "ic_reciept",
            index: 1,
          ),
          const SizedBox(),
          NavigationDestinantionCostume(
            seleceted: seleceted,
            onPressed: () => _goBranch(2),
            icon: "ic_card",
            index: 2,
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}

class NavigationDestinantionCostume extends StatelessWidget {
  const NavigationDestinantionCostume({
    super.key,
    required this.seleceted,
    required this.onPressed,
    required this.icon,
    required this.index,
  });

  final int seleceted, index;
  final String icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(25.r),
      child: SizedBox(
        height: 50.h,
        width: 50.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BottomIconBar(
              icon: "assets/icons/$icon.svg",
              color: index == seleceted ? AppColor.green : AppColor.grey,
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}

class BottomIconBar extends StatelessWidget {
  const BottomIconBar({
    super.key,
    required this.icon,
    required this.color,
  });

  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      color: color,
      height: 24.r,
      width: 24.r,
    );
  }
}
