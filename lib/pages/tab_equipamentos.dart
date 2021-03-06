import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sono/pages/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sono/pages/screen_equipamentos.dart';

bool inicializa = false;


class Equipamento extends StatefulWidget {
  const Equipamento({Key? key}) : super(key: key);

  @override
  _EquipamentoState createState() => _EquipamentoState();
}

class _EquipamentoState extends State<Equipamento> {
  @override
  void initState() {
    super.initState();
    inicializa = true;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      inicializa
          ? {model.Equipamento = 'Equipamento', inicializa = false}
          : null;
      return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Equipamento')
                .where('Hospital',isEqualTo: model.hospital)
                .where('Equipamento',isEqualTo: model.Equipamento)
                .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return GridView(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.reversed
                    .map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return fazGrid(
                      data['Foto'] ?? model.semimagem,
                      data['Nome'] ?? 'sem nome',
                      document.id
                  );
                }).toList(),
              );
          }
        },
      );
    });
  }

  Widget fazGrid(String imagem, String texto, String id) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model){
    return InkWell(
      onLongPress: (){
        escolherOpcao(context, id);
      },
      onTap: (){
        model.Equipamento == 'Equipamento'
            ?setState(() {
              model.Equipamento = texto;
            })
            :Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScreenEquipamento(id))
        );
      },
      child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.network(
          imagem,
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.25,
          fit: BoxFit.cover,
        ),
        Text(
          texto,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03,),
        )
      ],
    ),
    );
    });
  }
}

void escolherOpcao(context, String editarID) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Escolha uma op????o:'),
      content: SizedBox(
          width: 100,
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScreenEquipamento(editarID))
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    Text('Editar'),
                  ],
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  FirebaseFirestore.instance.collection('Equipamento').doc(editarID).delete();
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.highlight_remove,
                      color: Colors.black,
                    ),
                    Text('Remover'),
                  ],
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.max,
                  children: const [
                    Icon(
                      Icons.cancel,
                      color: Colors.black,
                    ),
                    Text('Cancelar'),
                  ],
                ),
              ),
            ],
          )
      ),
    ),
  );
}