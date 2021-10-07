import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:flutter/material.dart';

class AddressPicker extends StatefulWidget {
  const AddressPicker({Key? key}) : super(key: key);

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }

  static List _enderecos = [
    "R. Tiro ao Pombo",
    "R. Borboletas Psicodélicas",
    "Rua zap"
  ];

  static List _cep = ["02317-060", "02317-060", "02317-060"];

  /*
  _getMarkers(){

    Set<Marker> deliveryLocation = {};

    Marker userLocation = Marker(
      markerId: MarkerId('userLocation'),
      position: LatLng(latitude, longitude),
    );

    deliveryLocation.add(userLocation);

    setState(() {
      _markers = deliveryLocation;
    });
  }
   */

  /*
  _getUserLocation() async{
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    print('A localização atual é: ' + position.toString());
  }

   */

  @override
  void initState() {
    super.initState();
   // _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: AppBar(
          elevation: 0,
          toolbarHeight: 88,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 50,
            ),
          ),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'userProfile');
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Luiz Ricardo',
                          style: TextStyle(fontSize: 16, color: textMainColor),
                        ),
                        SizedBox(width: 10),
                        CachedNetworkImage(
                            imageUrl:
                                'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg',
                            imageBuilder: (context, imageProvider) => Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth)),
                                ))
                      ],
                    )))
          ],
          bottom: PreferredSize(
              //Exigido por causa do null safety, mas aqui não faz diferença
              preferredSize: Size.fromHeight(0),
              child: Container(
                  width: size.width * 0.9,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.edit_location, color: textMainColor),
                          Text(
                            "Entregar em",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textMainColor),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        textInputAction: TextInputAction.go,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Digite o seu endereço',
                          filled: true,
                          fillColor: Color(0xffE6E6E6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB5B5B5)),
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            // Localização inicial do mapa
            target: LatLng(-23.555774, -46.641849),
            zoom: 25
          ),
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
      ),
     bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        ),
        width: MediaQuery.of(context).size.width,
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Seus endereços",
                style: TextStyle(color: textMainColor, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _enderecos.length,
                itemBuilder: (context, index) {
                  return enderecoBlock(_enderecos[index], _cep[index]);
                },
              ),
            )
          ],
        ),
      ), 
    );
  }
}

Widget enderecoBlock(String endereco, String cep) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: textMainColorFade,
    child: InkWell(
      splashColor: textMainColorFade.withAlpha(30),
      onTap: () {},
      child: SizedBox(
        width: 148,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.home,
                size: 40,
                color: Colors.black54,
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$endereco",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$cep",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ))
          ],
        ),
      ),
    ),
  );
}
