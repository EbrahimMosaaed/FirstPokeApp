import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //decode json data
import 'package:pokemon/pokemon.dart';
import 'package:pokemon/pokemondetail.dart';

void main() => runApp(MaterialApp(
      title: 'poke App',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

// StatelessWidget if no change in data but we need to change the data it with data come from server api after fetchinng
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  // this will execute befor ui created
  @override
  void initState() {
    super.initState();

    // data come from server
    fetchData();
    print('2nd work');
  }

  // asynchronus means user dont hve to wait data get fast bc may take time and you
  // dont want to block user using the rest app // wait data to fech and showing circular indecetor
  fetchData() async {
    // await means wait untill get response and during this (featchin data from server) do 2nd work in app
    var res = await http.get(url);
    //print(res.body);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    //print(pokeHub.toJson());

    // setstate() rebuild ur app and reflect data after being null or display ui
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poke App'),
        backgroundColor: Colors.cyan,
      ),
      // if data fechaning and pokehub still null do circular relod but after do it still reloda and don't show ui and data coming from the server so we need method calle setstate()
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2, //2 number of columns in gridview
              children: pokeHub.pokemon
                  .map((poke) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      // make tap with splash effect

                      child: InkWell(
                        // we need new screen for detils

                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PokeDetail(
                                        pokemon: poke,
                                      ))); // push particulr pokemn to the other class
                          //context the location of widget in widget tree
                          // page route like a way or street and take addrees of home(PokeDetail)
                        },
                        child: Hero(
                            // hero do animation
                            tag: poke.img,
                            child: Card(
                              elevation: 3.0, // ertfa3 elimg
                              // child take one widget
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                //childern take list of widget
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(poke.img))),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ], // take list of widgets
                              ),
                            )),
                      )))
                  .toList(), //pokemon list class // map means select particulr poke frm pokemn list class //for every poke create card// then cret card list
            ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
