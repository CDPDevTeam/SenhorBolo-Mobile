import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import '../constants.dart';

class AddressPicker extends StatefulWidget {
  const AddressPicker({Key? key}) : super(key: key);

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {

  late int addressIndex = 0;

  _addAddress(){
    Navigator.pushNamed(context, 'addAddress');
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
              color: mainTextColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            width: double.infinity,
            height: 55,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(defaultButtonRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Usar a localização atual',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Icon(
                    Icons.location_searching
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          ListView.separated(
              shrinkWrap: true,
              itemCount: 2,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () => setState(() {
                    addressIndex = index;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: 80,
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(defaultButtonRadius),
                        border: addressIndex == index ? Border.all(color: mainColor, width: 2) : null
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text (
                              'Rua Valê do Cariri, 276',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Vila Nova Mazzei',
                              style: const TextStyle(
                                fontSize: 15
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Tomar cuidado com os mendigos',
                              style: const TextStyle(
                                fontSize: 12,
                                color: textSecondaryColor
                              ),
                            )
                          ],
                        ),
                        AnimatedContainer(
                          width: 33,
                          height: 33,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: addressIndex == index ? mainColor : textSecondaryColor,
                            borderRadius: BorderRadius.circular(defaultButtonRadius),
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
              separatorBuilder: (context, index) => const SizedBox(height: 10)
          ),
          const SizedBox(height: 15),
          simpleButton(242, 50, 'Adicionar endereço', _addAddress, defaultButtonRadius, 18, Color(0xff00A59F))
        ],
      ),
    );
  }
}
