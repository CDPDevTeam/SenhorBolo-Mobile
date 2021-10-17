import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Completer<GoogleMapController> _controller = Completer();
  bool _delivery = true;

  Set<Marker> _markers = {
    Marker(
        markerId: MarkerId('userLocation'),
        // Substituir pelo Endereço do pedido
        position: LatLng(-23.529118, -46.6352917),
    ),
    Marker(
        markerId: MarkerId('senhorBolo'),
        position: LatLng(-23.5557766, -46.6418035),
        infoWindow: InfoWindow(
          title: "Senhor Bolo",
        )
    )
  };

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _changeMap() async {
    GoogleMapController googleMapController = await _controller.future;
    LatLng mapLocation = LatLng(-23.5557766, -46.6418035);

    if (_delivery) {
      // Substituir pelo Endereço do pedido
      mapLocation = LatLng(-23.529118, -46.6352917);
    }

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: mapLocation,
        zoom: 16,
        tilt: 50
    )));
  }

  String _selectedAddress = 'Rua humaíta, 582';
  String _selectedAddressInfo = 'Tome cuidado com os mendigos';

  Text _ccNumberText = Text(
    'Método de pagamento',
    style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: textSecondaryColor
    ),
  );

  Widget _ccIcon =  Icon(
    Icons.credit_card,
    color: Colors.black,
    size: 40,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25))
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: SizedBox(
          width: 210,
          child: Row(
            children: [
              const Icon(
                Icons.point_of_sale,
                size: 35,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              const Text(
                'Checkout',
                style: TextStyle(
                    color: textMainColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: Color(0xffF2F2F2)
        ),
        child: Center(
          child: simpleButton(350, 48, 'Confirmar pedido', (){}, 10, 20, mainColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const Text(
              'Método de entrega',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    width: 335,
                    height: 200,
                    child: ClipRRect(
                      /// Custa muito em GPU, ver se tem outra forma depois
                      borderRadius: BorderRadius.circular(25),
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        markers: _markers,
                        mapType: MapType.normal,
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(-23.529118, -46.6352917),
                            zoom: 16,
                            tilt: 50
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Container(
                      width: 172,
                      height: 41,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ChoiceChip(
                            selected: _delivery,
                            onSelected: (bool selected) {
                              _changeMap();
                              setState(() {
                                _delivery = !_delivery;
                              });
                            },
                            selectedColor: mainColor,
                            backgroundColor: Colors.white,
                            label: Text(
                              'Delivery',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: _delivery == true
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          ChoiceChip(
                            selected: _delivery == false,
                            onSelected: (bool selected) {
                              _changeMap();
                              setState(() {
                                _delivery = !_delivery;
                              });
                            },
                            selectedColor: mainColor,
                            backgroundColor: Colors.white,
                            label: Text(
                              'Retirar',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: _delivery == true
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Estimativa de entrega',
                  style: TextStyle(color: textSecondaryColor, fontSize: 15),
                ),
                Wrap(
                  spacing: 6,
                  children: [
                    const Text(
                      '39mins',
                      style: TextStyle(color: textSecondaryColor, fontSize: 15),
                    ),
                    const Icon(
                      Icons.schedule,
                      size: 16,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20))),
                  context: context,
                  builder: (context) => SelectAddress()
              ).then((addressInfo){
                setState(() {
                  _selectedAddress = addressInfo[0];
                  _selectedAddressInfo = addressInfo[1];
                });
              }),
              child: Container(
                width: double.infinity,
                height: 57,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              _selectedAddress,
                              style: TextStyle(
                                  color: textSecondaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _selectedAddressInfo,
                              style:
                              TextStyle(color: textSecondaryColor, fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Método de pagamento',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20))),
                  context: context,
                  builder: (context) => SelectCard()
              ).then((ccInfo){
                  setState(() {
                    _ccNumberText =  Text(
                      ccInfo[0],
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                          color: Colors.black
                      ),
                    );
                  });
                  _ccIcon = FaIcon(
                    ccInfo[1] == 'Visa' ? FontAwesomeIcons.ccVisa : FontAwesomeIcons.ccMastercard,
                    size: 35,
                    color:  ccInfo[1] == 'Visa' ? Colors.blueAccent : Colors.deepOrange,
                  );
              }),
              child: Container(
                width: double.infinity,
                height: 57,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        const SizedBox(width: 8),
                        _ccIcon,
                        const SizedBox(width: 8),
                        _ccNumberText
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 57,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.local_offer,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Cupom',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textSecondaryColor
                        ),
                      )
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      const Text(
                        '10% OFF',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textSecondaryColor
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '-R\$ 10,00',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Seus bolos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
          ],
        ),
      )
    );
  }
}

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key? key}) : super(key: key);

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  @override
  Widget build(BuildContext context) {

    List<String> _enderecos = [
      'Rua valê do Cariri, 276',
      'Rua humaíta, 582'
    ];

    List<String> _infoAdicionais = [
      'Tomar cuidado com os nóias',
      'Tomar cuidado com os mendigos'
    ];

    List<String> addressInfo = [];

    return Container(
        height: 379,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                const Text(
                  'Selecione o endereço de entrega',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _enderecos.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return SizedBox(
                        height: 69,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          onPressed: () => Navigator.pop(
                              context,
                              addressInfo = [_enderecos[index], _infoAdicionais[index]]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: Colors.black,
                                    size: 29,
                                  ),
                                  SizedBox(width: 10),
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      Text(
                                        _enderecos[index],
                                        style: TextStyle(
                                            color: textSecondaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _infoAdicionais[index],
                                        style: TextStyle(
                                            color: textSecondaryColor,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  print(_enderecos[index] +
                                      ' foi selecionado para edição!');
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 22,
                                ),
                              )
                            ],
                          ),
                        )
                    );
                  }
            ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  onPressed: () {
                    print('Adicionar endereço');
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(
                      'Adicionar endereço',
                    style: TextStyle(
                    ),
                  ),
                )
            ]
          )
        )
    );
  }
}

class SelectCard extends StatefulWidget {
  const SelectCard({Key? key}) : super(key: key);

  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {

  List<int> _creditCards = [
    1049,
    2103,
    4642
  ];

  List<String> _ccCarrier = [
    'Visa',
    'Mastercard',
    'Visa'
  ];

  List<String> teste = [

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 379,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            const Text(
              'Selecione seu método de pagamento',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _creditCards.length,
                itemBuilder: (context, index){
                  return SizedBox(
                      height: 46,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        onPressed: () => Navigator.pop(
                            context,
                            teste = [_creditCards[index].toString(), _ccCarrier[index]]
                        ),
                        icon: FaIcon(
                          _ccCarrier[index] == 'Visa' ? FontAwesomeIcons.ccVisa : FontAwesomeIcons.ccMastercard,
                          size: 35,
                          color: _ccCarrier[index] == 'Visa' ? Colors.blueAccent : Colors.deepOrange,
                        ),
                        label: Text(
                          _creditCards[index].toString(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17,
                            color: Colors.black
                          ),
                      )
                  ));
                },
              separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
              },
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'addCreditCard');
              },
              icon: const Icon(
                Icons.add,
              ),
              label: const Text(
                'Adicionar cartão',
                style: TextStyle(
                ),
              ),
            )
          ],
        )
      )
    );
  }
}


