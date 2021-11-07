import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';

class Tracking extends StatelessWidget {

  final int currentStep;
  const Tracking({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Pedido #0000',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: mainTextColor
            ),
          ),
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 50,
            ),
          ),
          toolbarHeight: 88,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ) ,
        body: Theme(
          data: ThemeData(
              colorScheme: ColorScheme.light(
                  primary: mainColor
              )
          ),
          child: Stepper(
            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              return SizedBox();
            },
            type: StepperType.vertical,
            currentStep: currentStep,
            steps: [
              Step(
                  state: currentStep >= 0 ? StepState.complete : StepState.disabled,
                  isActive: currentStep >= 0,
                  title: const Text("Pedido Recebido",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Raleway')),
                  content: const DeliveryStep(
                      stepText: 'O pedido foi recebido pela nossa central e em breve seu bolo estará sendo feito com todo o carinho',
                      image: 'banner_teste.png')
              ),
              Step(
                  state: currentStep >= 1 ? StepState.complete : StepState.disabled,
                  isActive: currentStep >= 1,
                  title: const Text("Pedido em preparação", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Raleway')),
                  content: const DeliveryStep(
                      stepText: 'Seu bolo delicioso está agora saindo do forno e logo mais será enviado para sua casa!',
                      image: 'banner_teste.png')
              ),
              Step(
                  state: currentStep >= 2 ? StepState.complete : StepState.disabled,
                  isActive: currentStep >= 2,
                  title: const Text("Pedido a caminho",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Raleway')),
                  content: const DeliveryStep(
                      stepText: 'Seu pedido já está com o nosso cuidadoso motoboy, que com certeza não irá fazer grau com a moto a caminho de sua residência!',
                      image: 'banner_teste.png')
              ),
              Step(
                  state: currentStep >= 2 ? StepState.complete : StepState.disabled,
                  isActive: currentStep >= 3,
                  title: const Text("Pedido entregue",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Raleway')),
                  content: const DeliveryStep(
                      stepText: 'Nosso pedido já foi entregue, esperamos que você tenha gostado desse bolo que fizemos com tanto carinho <3',
                      image: 'banner_teste.png')
              ),
            ],
          ),
        )
    );
  }
}

class DeliveryStep extends StatelessWidget {

  final String image, stepText;
  const DeliveryStep({Key? key, required this.image, required this.stepText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 300, height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage('images/' + image), fit: BoxFit.fill)
            ),
          ),
          SizedBox(height: 10,),
          Text(stepText, style: TextStyle(fontSize: 15),)
        ],
      ),
    );
  }
}

