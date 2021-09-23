import 'package:flutter/cupertino.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/main.dart';

class AddressPicker extends StatefulWidget {
  const AddressPicker({Key? key}) : super(key: key);

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {

  static List _enderecos = [
    "R. Tiro ao Pombo",
    "R. Borboletas Psicodélicas",
    "Rua zap"
  ];
  static List _cep = [
    "03080000",
    "04050000",
    "00000000"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(224),
        child:
            Container(
              height: 224,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25)
                  )
              ),
              padding: EdgeInsets.only(left: 20 ,right: 20),
              child: SafeArea(
                top: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            iconSize: 40,

                            color: Colors.white,
                            icon: Icon(Icons.menu)),

                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 43,
                            height: 43,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('images/ricardinho_betoneira.jpeg'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        )
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.edit_location, color: textMainColor),
                              Text("Entregar em",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textMainColor),)
                            ],
                          ),
                          TextField(
                            style: TextStyle(color: textMainColor),
                            decoration: const InputDecoration(
                                hintText: "Rua Humaítá, 638",
                              hintStyle: TextStyle(color: textMainColorFade),
                              labelStyle: TextStyle(color: textMainColor),

                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            )


        ),

        bottomNavigationBar: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25)
          ),),
          width: MediaQuery.of(context).size.width,
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Seus endereços", style: TextStyle(color: textMainColor, fontSize: 20 ),),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _enderecos.length,
                  itemBuilder:(context, index) {
                    return enderecoBlock(_enderecos[index], _cep[index]);
                  },
                ),
              )

            ],
          ) ,
        ),
    );
  }
}
Widget enderecoBlock (String endereco, String cep){
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    color: textMainColorFade,
    child: InkWell(
      splashColor: textMainColorFade.withAlpha(30),
      onTap: (){},
      child: SizedBox(
        width: 148,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.home, size: 40, color: Colors.black54,),
            ),
            
            Expanded(
                child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$endereco", overflow: TextOverflow.clip, style: TextStyle(color: Colors.black54),),
                Text("$cep", style: TextStyle(color: Colors.black54),),
              ],
            )
            )

          ],
        ),
      ),
    ),
  );

    /*Card(
    margin: EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        )
      ],
      color: Color(0xFFE6E6E6)
    ),
    height: 64,
    width: 148,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.home),
        Expanded(
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("$endereco", overflow: TextOverflow.ellipsis,),
                Text("$cep")
              ],
            )
        )

      ],
    ),
  );*/
}