import 'package:flutter/material.dart';
import 'package:sono/pages/widgets_drawer.dart';
import 'package:sono/pages/tab_home.dart';
//import 'package:sono/pages/tab_01.dart';
import 'package:sono/pages/tab_paciente.dart';
//import 'package:sono/pages/tab_02.dart';
import 'package:sono/pages/tab_equipamentos.dart';
//import 'package:sono/pages/tab_03.dart';
import 'package:sono/pages/tab_fale.dart';
import 'package:sono/pages/tab_04.dart';
import 'package:sono/pages/widgets_botao_menu.dart';


class HomeScreen extends StatelessWidget {

  final _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: const HomeTab(),
          drawer: CustomDrawer(_pageController),
          drawerEnableOpenDragGesture: true,
          /*floatingActionButton: FloatingActionButton(
              onPressed: (){
                _pageController.jumpToPage(2);
              })*/
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Pacientes"),
            centerTitle: true,
            backgroundColor: Colors.red,
          ),
          drawer: CustomDrawer(_pageController),
          drawerEnableOpenDragGesture: true,
          body: const Paciente(),
          floatingActionButton: const BotaoMenu(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Equipamentos"),
            centerTitle: true,
          ),
          body: const Equipamento(),
          drawer: CustomDrawer(_pageController),
          drawerEnableOpenDragGesture: true,
          floatingActionButton: const BotaoMenu(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Fale conosco"),
            centerTitle: true,
          ),
          body: const Fale(),
          drawer: CustomDrawer(_pageController),
          drawerEnableOpenDragGesture: true,
          floatingActionButton: const BotaoMenu(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Comunicação"),
            centerTitle: true,
          ),
          body: const Tab04(),
          drawer: CustomDrawer(_pageController),
          drawerEnableOpenDragGesture: true,
        )
      ],
    );
  }
}
