import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senhor_bolo/classes/order.dart';
import 'package:senhor_bolo/classes/shoppingCart.dart';
import 'package:senhor_bolo/components/updateAddress.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/model/address.dart';
import 'package:senhor_bolo/model/cake.dart';
import 'package:senhor_bolo/model/creditcard.dart';
import 'package:senhor_bolo/services/addressService.dart';
import 'package:senhor_bolo/services/creditcardService.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  late Order order;
  late ShoppingCart carrinho;
  late List<Cake> bolos;
  late Future<LatLng> latLngAddress;
  Completer<GoogleMapController> _controller = Completer();

  Future<LatLng> _getAddressCoordinates(String rua, String numero) async {
    List<Location> locations = await locationFromAddress('$rua, $numero');
    LatLng addressLocation = LatLng(locations[0].latitude, locations[0].longitude);
    return addressLocation;
  }

  _changeAddress(String rua, String numero) async {
    GoogleMapController googleMapController = await _controller.future;
    LatLng mapLocation = await _getAddressCoordinates(rua, numero);

    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: mapLocation,
          zoom: 16,
    )));
  }

  void _processarPagamento(){
    if(order.creditCard != null){
      order.submitOrder(carrinho.cartItens);
      showDialog(
          context: context,
          builder: (context)
          {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultButtonRadius),
              ),
              child: Container(
                width: 175,
                height: 133,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Processando \n pagamento',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    CircularProgressIndicator(color: mainColor)
                  ],
                ),
              ),
            );
          }
      );
      Future.delayed(Duration(seconds: 2), (){
        order.orderCoupon = null;
        order.creditCard = null;
        carrinho.cartItens.clear();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'orderConfirmed');
      });
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Erro no pedido',
          text: 'Selecione um cartão de crédito',
          confirmBtnColor: mainColor,
          onConfirmBtnTap: (){
            Navigator.of(context).pop();
          }
      );
    }

  }

  @override
  void initState() {
    super.initState();
    order = context.read<Order>();
    carrinho = context.read<ShoppingCart>();
    latLngAddress = _getAddressCoordinates(order.orderAddress!.rua, order.orderAddress!.num);
    bolos = carrinho.cartItens;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 88,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.keyboard_arrow_left,
              size: 50,
            ),
          ),
          title: Wrap(
            children: [
              Icon(
                Icons.point_of_sale,
                color: Colors.white,
                size: 35,
              ),
              SizedBox(width: 10),
              Text(
                'Checkout',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: mainTextColor
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 90,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Center(
            child: simpleButton(350, 48, 'Confirmar pedido', _processarPagamento, 10, 20, mainColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              const Text(
                'Endereço de entrega',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Consumer<Order>(
                builder: (context, order, child) {

                  _changeAddress(order.orderAddress!.rua, order.orderAddress!.bairro);
                  return FutureBuilder<LatLng>(
                    future: latLngAddress,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return Stack(
                          children: [
                          Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 335,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: GoogleMap(
                                onMapCreated: (GoogleMapController googleMapController) {
                                  _controller.complete(googleMapController);
                                  googleMapController.showMarkerInfoWindow(MarkerId('userLocation'));
                                },
                                mapType: MapType.normal,
                                myLocationEnabled: false,
                                mapToolbarEnabled: false,
                                rotateGesturesEnabled: false,
                                scrollGesturesEnabled: false,
                                tiltGesturesEnabled: false,
                                zoomGesturesEnabled: false,
                                zoomControlsEnabled: false,
                                myLocationButtonEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  target: snapshot.data!,
                                  zoom: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                            left: 144.5,
                            top: 60,
                            child: Icon(
                                Icons.place,
                                color: Colors.red,
                                size: 36.0,

                             )
                        )
                          ],
                        );


                      } else {
                        return Container(
                          width: 335,
                          height: 200,
                        );
                      }
                    },
                  );
                },
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
                        '4 dias',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: textSecondaryColor,
                          fontSize: 12
                        ),
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
                ),
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
                          Consumer<Order> (
                            builder: (context, order, child){
                              return Wrap(
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    order.orderAddress!.rua,
                                    style: TextStyle(
                                        color: textSecondaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    order.orderAddress!.complemento ?? 'Sem complemento',
                                    style:
                                    TextStyle(color: textSecondaryColor, fontSize: 10),
                                  )
                                ],
                              );
                            },
                          )
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
                ),
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
                      Consumer<Order> (
                        builder: (context, order, child){

                          late Widget ccText;
                          late String ccNum;
                          late Widget ccIcon;

                          if(order.creditCard == null){
                            ccText =  Text(
                              'Método de pagamento',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: textSecondaryColor
                              ),
                            );
                            ccIcon = Icon(
                              Icons.credit_card,
                              color: Colors.black,
                              size: 40,
                            );
                          } else {
                            ccNum = order.creditCard!.num.toString();
                            ccNum = ccNum.substring(12, 16);
                            ccText = Text(
                              ccNum,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 17,
                                  color: Colors.black
                              ),
                            );
                            ccIcon = FaIcon(
                              order.creditCard!.carrier == 'Visa' ? FontAwesomeIcons.ccVisa : FontAwesomeIcons.ccMastercard,
                              size: 35,
                              color:  order.creditCard!.carrier == 'Visa' ? Colors.blueAccent : Colors.deepOrange,
                            );
                          }

                          return Flex(
                            direction: Axis.horizontal,
                            children: [
                              const SizedBox(width: 8),
                              ccIcon,
                              const SizedBox(width: 8),
                              ccText
                            ],
                          );
                        },
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
                    Consumer<Order>(
                    builder: (context, order, child){
                      if(order.orderCoupon == null){
                        return Flex(
                          direction: Axis.horizontal,
                          children: [
                            const Text(
                              "Sem cupom selecionado",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        );
                      } else {
                        return Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              '${order.orderCoupon!.discountPercentage}%OFF ',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: textSecondaryColor
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '-R\$ ${order.getCouponDiscount().toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        );
                      }
                    }
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Seus bolos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffE9E9E9),
                    borderRadius: BorderRadius.circular(defaultButtonRadius)
                ),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bolos.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(bolos[index].name),
                        subtitle: Text('Qtde ' + bolos[index].qtde.toString()),
                        trailing: Text(
                          'R\$ '+ bolos[index].price.toStringAsPrecision(4),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(height: 1)
                ),
              ),
              const SizedBox(height: 20),
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

  final _addressStreamController = StreamController<List<Address>>();
  late Order orderA;

  _loadAdresses() async {
    List<Address> adresses = await AddressService().getAll();
    _addressStreamController.add(adresses);
  }

  _editAddress(Address address){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => UpdateAddress(endereco: address)));
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (_) => _loadAdresses());
    orderA = context.read<Order>();
  }

  @override
  Widget build(BuildContext context) {
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
                  StreamBuilder<List<Address>>(
                      stream: _addressStreamController.stream,
                      builder: (context, snapshot){
                        if (snapshot.hasData){
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(height: 10);
                              },
                              itemBuilder: (context, index) {

                                Address endereco = snapshot.data![index];

                                return SizedBox(
                                    height: 69,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          )
                                      ),
                                      onPressed: (){
                                        orderA.orderAddress = snapshot.data![index];
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Wrap(
                                            children: [
                                              const Icon(
                                                Icons.home,
                                                color: Colors.black,
                                                size: 29,
                                              ),
                                              SizedBox(width: 10),
                                              Wrap(
                                                direction: Axis.vertical,
                                                children: [
                                                  Text(
                                                    '${endereco.rua}, ${endereco.num}',
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        color: textSecondaryColor,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    endereco.complemento != null
                                                        ? '${endereco.complemento}'
                                                        : 'Sem complemento',
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        color: textSecondaryColor,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                );
                              }
                          );
                        }else if (snapshot.hasError){
                          print('${snapshot.error}');
                          Text('${snapshot.error}');
                          return Text('${snapshot.error}');
                        }
                        return Expanded(
                          child: Center(child: CircularProgressIndicator()),
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

  final _ccStreamController = StreamController<List<CreditCard>>();
  late Order order;

  _loadCreditCards() async {
    List<CreditCard> creditcards = await CreditcardService.instance.selectAll();
    _ccStreamController.add(creditcards);
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (_) => _loadCreditCards());
    order = context.read<Order>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 379,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Selecione seu método de pagamento',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                StreamBuilder<List<CreditCard>>(
                  stream: _ccStreamController.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){

                          CreditCard cc = snapshot.data![index];
                          String cardNumber = cc.num.toString();

                          return SizedBox(
                              height: 46,
                              child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                                  onPressed: () {
                                    order.creditCard = cc;
                                    Navigator.of(context).pop();
                                  },
                                  icon: FaIcon(
                                    cc.carrier == 'Visa' ? FontAwesomeIcons.ccVisa : FontAwesomeIcons.ccMastercard,
                                    size: 35,
                                    color: cc.carrier == 'Visa' ? Colors.blueAccent : Colors.deepOrange,
                                  ),
                                  label: Text(
                                    cardNumber.substring(12, 16),
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
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
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
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Adicionar cartão',
                  ),
                )
              ],
            )
        )
    );
  }
}