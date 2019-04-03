import 'package:flutter/material.dart';
import 'package:pokemon/pokemon.dart';

// bc no changes in data we use statless we just pass data from class to class
class PokeDetail extends StatelessWidget {
  final Pokemon pokemon; // get pokemn from pokemn.dart

  PokeDetail({this.pokemon}); // constarctor to get final pokemn
 // stack pop pokemon icon above the card  
  bodyWight( BuildContext context) => Stack(
        children: <Widget>[
          Positioned (// to postion the card top down left right
          height: MediaQuery.of(context).size.height/1.5,// take the height of the phone
          width: MediaQuery.of(context).size.width-20.0, // take the width of the phone
          left: 10.0,
          top: MediaQuery.of(context).size.height* 0.1,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: Column( // create virtcall arry of children
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
                children: <Widget>[
                SizedBox(height: 70.0,),// to show text bc pic of pokemn above pokemon name and hidde the text

                  Text(pokemon.name,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                  Text("Height: ${pokemon.height}"),
                  Text("Weight: ${pokemon.weight}"),
                  Text("Types"), // bc type is list
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.type
                          .map((t) => FilterChip(
                            backgroundColor: Colors.brown,
                                label: Text(t),
                                onSelected: (b) {},
                              ))
                          .toList()),
                  Text("Weaknesses"),
                  Row( // create horzintal arry of children
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.weaknesses
                          .map((t) => FilterChip(
                            backgroundColor: Colors.indigo,
                                label: Text(t,style: TextStyle(color: Colors.red),),
                                onSelected: (b) {},
                              ))
                          .toList()),
                  Text("Next Evolution"),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.nextEvolution
                          .map((n) => FilterChip(
                            backgroundColor: Colors.amber,
                                label: Text(n.name),
                                onSelected: (b) {},
                              ))
                          .toList()),
                ],
              ),
            ),
          ),
        //make pic of pokemon top of card
        Align( alignment: Alignment.topCenter,
        child: Hero(tag: pokemon.img,
        child: Container(
          height: 150.0,
          width: 150.0,
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover,image: NetworkImage(pokemon.img))
          ),
        ),),

        )
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0, //ertfa3 el bar
        backgroundColor: Colors.cyan,
        title: Text(pokemon.name),
      ),
      body: bodyWight(context),
    );
  }
}
