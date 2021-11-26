import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/classes/order.dart';
import 'package:senhor_bolo/model/address.dart';
import 'package:senhor_bolo/services/addressService.dart';
import 'package:provider/provider.dart';
class AddressPicker extends StatefulWidget {
  const AddressPicker({Key? key}) : super(key: key);

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {

  final _addressStreamController = StreamController<List<Address>>();
  late Order orderAddress;
  late int addressIndex;

  _loadAdresses() async {
    List<Address> adresses = await AddressService().getAll();
    _addressStreamController.add(adresses);
  }

  _addAddress() {
    Navigator.pushNamed(context, 'addAddress');
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 900), (_) => _loadAdresses());
    orderAddress = context.read<Order>();
    addressIndex = orderAddress.orderAddress == null
    ? -1
    : orderAddress.orderAddress!.id;
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
        title: const Text(
          'Selecionar endereço',
          style: TextStyle(
              color: mainTextColor, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            width: double.infinity,
            height: 55,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(defaultButtonRadius),
            ),
            child: InkWell(
              onTap: (){
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.warning,
                  title: 'Não é possível usar sua localização, ainda!',
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Usar a localização atual',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.location_searching)
                ],
              ),
            )
          ),
          const SizedBox(height: 15),
          StreamBuilder<List<Address>>(
              stream: _addressStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data!.length > 0){
                    return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {

                          Address endereco = snapshot.data![index];
                          int addressID = endereco.id;

                          return GestureDetector(
                            onTap: () => setState(() {
                              addressIndex = endereco.id;
                              orderAddress.orderAddress = endereco;
                            }),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: double.infinity,
                              height: 80,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 14),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(defaultButtonRadius),
                                  border: addressIndex == addressID
                                      ? Border.all(color: mainColor, width: 2)
                                      : null),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${endereco.rua}, ${endereco.num}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        endereco.bairro,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        endereco.complemento != null
                                            ? '${endereco.complemento}'
                                            : 'Sem complemento',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: textSecondaryColor),
                                      )
                                    ],
                                  ),
                                  AnimatedContainer(
                                    width: 33,
                                    height: 33,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: addressIndex == addressID
                                          ? mainColor
                                          : textSecondaryColor,
                                      borderRadius: BorderRadius.circular(
                                          defaultButtonRadius),
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 10));
                  } else {
                    return Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sem endereços adicionados',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const Text(
                            'Adicione um endereço no botão ao lado',
                            style: TextStyle(
                                fontSize: 14,
                                color: textSecondaryColor
                            ),
                          )
                        ],
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  print('${snapshot.error}');
                  Text('${snapshot.error}');
                  return Text('${snapshot.error}');
                } else if (snapshot.data == null){
                }
                return Center(child: CircularProgressIndicator());
              }),
          const SizedBox(height: 15),
          simpleButton(242, 50, 'Adicionar endereço', _addAddress,
              defaultButtonRadius, 18, Color(0xff00A59F))
        ],
      ),
    );
  }
}
