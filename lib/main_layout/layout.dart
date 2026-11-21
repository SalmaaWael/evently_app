import 'package:evently_app/core/colors_manager.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../core/routes_manager/routes_manager.dart';
import 'favorite/favorite.dart';
import 'home/home.dart';
import 'maps/maps.dart';
import 'profile/profile.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List<Widget> _tabs=[
    HomeTab(),
    Maps(),
    Favorite(),
    Profile(),
  ];
  int selectedIndex=0;
  @override
  Widget build(BuildContext context)  {
    AppLocalizations appLocalizations=AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          Navigator.pushNamed(context, RoutesManager.createEvent);
        },
        child: const Icon(Icons.add),
      ),
      body: _tabs[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _buildButtomAppBar(),

    );
  }

  Widget _buildButtomAppBar() {
    return BottomAppBar(
      ///shape: const CircularNotchedRectangle(),
      notchMargin: 4,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              size:40,
              selectedIndex == 0 ? Icons.home_filled : Icons.home_outlined,
              color: ColorsManager.white,
            ),

            onPressed: () => _onTap(0),
          ),
          IconButton(
            icon: Icon(
              size:40,
              selectedIndex == 1 ? Icons.location_on : Icons.location_on_outlined,
              color: ColorsManager.white,
            ),
            onPressed: () => _onTap(1),
          ),
          const SizedBox(width: 40),
          IconButton(
            icon: Icon(
              size:40,
              selectedIndex == 2 ? Icons.favorite : Icons.favorite_border,
              color: ColorsManager.white,
            ),
            onPressed: () => _onTap(2),
          ),
          IconButton(
            icon: Icon(
              size:40,
              selectedIndex == 3 ? Icons.person_2_rounded : Icons.person_2_outlined,
              color: ColorsManager.white,
            ),
            onPressed: () => _onTap(3),
          ),
        ],
      ),
    );
  }


  void _onTap(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }
}