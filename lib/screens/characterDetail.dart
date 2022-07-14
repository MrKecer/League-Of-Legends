import 'package:flutter/material.dart';

import 'package:leagueoflegends/models/character.dart';
import 'package:leagueoflegends/screens/character.dart';

class characterDetail extends StatefulWidget {
  Character? characters;
  characterDetail({
    Key? key,
    this.characters,
  }) : super(key: key);

  @override
  State<characterDetail> createState() => _characterDetailState();
}

class _characterDetailState extends State<characterDetail> {
  bool detail = false;
  @override
  Widget build(BuildContext context) {
    List<Map> _character = <Map>[
      {
        "Name:": widget.characters!.name.toString(),
      },
      {
        "Nick:": widget.characters!.title.toString(),
      },
      {"Description:": widget.characters!.description.toString()},
    ];
    List<Map> _stats = [
      {"Hp: ": widget.characters!.stats!.hp},
      {"Mp: ": widget.characters!.stats!.mp},
      {"Movespeed: ": widget.characters!.stats!.movespeed},
      {"Armor: ": widget.characters!.stats!.armor},
      {"Attackspeed: ": widget.characters!.stats!.attackspeed},
      {"Attackdamage: ": widget.characters!.stats!.attackdamage},
      {
        "Attackrange: ": widget.characters!.stats!.attackrange,
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.characters!.name.toString()),
        titleSpacing: 0,
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.book),
          ),
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage(widget.characters!.image.toString())),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.shade600,
                        offset: const Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _character.length,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  child: ListTile(
                    leading: Text(
                      _character[index].keys.join().toString(),
                      style: const TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    title: Text(
                      _character[index].values.join().toString(),
                      style: const TextStyle(
                          fontSize: 18, fontStyle: FontStyle.normal),
                    ),
                  ),
                );
              },
            ),
            Card(
              child: ListTile(
                leading: const Text(
                  "Rollers",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                title: Text(
                  widget.characters!.tags!.join(", ").toString(),
                  style: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.normal),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  detail = !detail;
                });
              },
              child: const Text("Karakter Detayları"),
            ),
            detail == true ? characterStats(_stats) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget characterStats(_stats) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _stats.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 0, 8),
                child: Text(_stats[index].keys.join().toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    )),
              ),
              Text(_stats[index].values.join().toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  )),
            ],
          );
        });
  }
}
