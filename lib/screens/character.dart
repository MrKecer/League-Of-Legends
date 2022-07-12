import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:leagueoflegends/models/api/connectApi.dart';
import 'package:leagueoflegends/screens/characterDetail.dart';
import '../models/character.dart';

// ignore: camel_case_types
class character extends StatefulWidget {
  const character({Key? key}) : super(key: key);

  @override
  State<character> createState() => _characterState();
}

// ignore: camel_case_types
class _characterState extends State<character> {
  List<Character> _character = [];
  List<Character> _characterSearch = [];
  bool situation = false;
  @override
  void initState() {
    getCharactersFromAPi();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("images/lol.jpg"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(Icons.menu_outlined),
          title: situation == false
              ? title()
              : TextField(
                  onChanged: searchCharacter,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 10),
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                      hintText: "Search"),
                ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    situation == false ? situation = true : situation = false;
                    _character = _characterSearch;
                  });
                },
                icon: const Icon(Icons.search_outlined))
          ],
          centerTitle: false,
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            lolWidget(),
          ]),
        ),
      ),
    );
  }

  void getCharactersFromAPi() {
    LolApi.getLol().then((value) {
      setState(() {
        Iterable list = jsonDecode(value.body);
        this._character = list.map((e) => Character.formJson(e)).toList();
        _characterSearch = _character;
        lolWidget();
      });
    });
  }

  Widget lolWidget() {
    return SizedBox(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: _character.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
          mainAxisExtent: 155,
        ),
        itemBuilder: (context, index) => Card(
          color: Colors.transparent,
          elevation: 0,
          //shadowColor: Colors.red,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Image.network(
                  _character[index].image!,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    _character[index].name!,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
                InkWell(
                  onTap: (() {
                    print(_character[index].stats!.hp);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => characterDetail(
                          id: _character[index].id,
                          name: _character[index].name,
                          title: _character[index].title,
                          image: _character[index].image,
                          description: _character[index].description,
                          tags: _character[index].tags,
                          hp: _character[index].stats!.hp,
                          mp: _character[index].stats!.mp,
                          movespeed: _character[index].stats!.movespeed,
                          armor: _character[index].stats!.armor,
                          attackspeed: _character[index].stats!.attackspeed,
                          attackdamage: _character[index].stats!.attackdamage,
                          attackrange: _character[index].stats!.attackrange,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchCharacter(String value) {
    final sug = _character.where((element) {
      final characterName = element.name!.toLowerCase();
      final input = value.toLowerCase();
      return characterName.contains(input);
    }).toList();
    setState(() {
      _character = sug;
    });
  }
}

List<Color> TextColor() {
  return [Colors.orange, const Color.fromARGB(255, 44, 206, 11), Colors.yellow];
}

Widget title() {
  return AnimatedTextKit(
    repeatForever: true,
    animatedTexts: [
      ColorizeAnimatedText(
        'League',
        colors: TextColor(),
        textStyle: const TextStyle(fontSize: 25),
        speed: const Duration(milliseconds: 450),
      ),
      ColorizeAnimatedText(
        'Of',
        colors: TextColor(),
        textStyle: const TextStyle(fontSize: 25),
        speed: const Duration(milliseconds: 700),
      ),
      ColorizeAnimatedText(
        'Legends',
        colors: TextColor(),
        textAlign: TextAlign.left,
        textStyle: const TextStyle(fontSize: 25),
        speed: const Duration(milliseconds: 450),
      ),
      ColorizeAnimatedText(
        'League of Legends',
        colors: TextColor(),
        textAlign: TextAlign.left,
        textStyle: const TextStyle(fontSize: 25),
        speed: const Duration(milliseconds: 300),
      ),
    ],
  );
}
