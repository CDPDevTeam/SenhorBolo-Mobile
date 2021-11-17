import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:senhor_bolo/model/opcaoBoloPersonalizado.dart';
import 'package:senhor_bolo/services/boloPersonalizadoService.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCakeInfo{
  String? massa;
  String? recheio;
  String? cobertura;
  String? confeito;
  String? nome;
  String? imagem;

  CustomCakeInfo({this.massa, this.recheio, this.cobertura, this.confeito,
      required this.nome, this.imagem});

  bool campoPreenchido(int indexPagina){
    switch (indexPagina){
      case 0 :
        return massa != null;
      case 1 :
        return recheio != null;
      case 2 :
        return cobertura != null;
      case 3 :
        return confeito != null;
    }
    return false;
  }

  void limparCampo(int indexPagina){
    switch (indexPagina){
      case 0 :
        massa = null;
        break;
      case 1 :
        recheio = null;
        break;
      case 2 :
        cobertura = null;
        break;
      case 3 :
        confeito = null;
        break;
    }
  }

  void limparDados(){
    massa = null;
    recheio = null;
    cobertura = null;
    confeito = null;
  }
}

CustomCakeInfo customCakeObject = CustomCakeInfo(nome: 'Bolo Personalizado');

class CustomCake extends StatefulWidget {
  const CustomCake({Key? key}) : super(key: key);

  @override
  _CustomCakeState createState() => _CustomCakeState();
}

class _CustomCakeState extends State<CustomCake> {

  List<String> boloPersonalizado = [];

 int indexPagina = 0;
 List<Widget> paginas = [
    CustomCakeOptionStep(
        tituloOpcao: 'Selecione a massa do bolo',
        pastaOpcao: 'massas',
        etapaOpcao: 0
    ),
   CustomCakeOptionStepS(
       tituloOpcao: 'Escolha um recheio',
       pastaOpcao: 'recheios',
       etapaOpcao: 1
   ),
   CustomCakeOptionStep(
       tituloOpcao: 'Escolha uma cobertura',
       pastaOpcao: 'coberturas',
       etapaOpcao: 2
   ),
   CustomCakeOptionStepS(
       tituloOpcao: 'Escolha um confeito',
       pastaOpcao: 'confeitos',
       etapaOpcao: 3
   ),
   CustomCakeFinal()
  ];

  bool isFirstPage = true;
  String txtBtnVermelho = 'Cancelar';

  _mensagemErro(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Color(0xff88002A),
            duration: Duration(milliseconds: 1500),
            behavior: SnackBarBehavior.floating,
            content: Row(
              children: [
                Icon(Icons.warning, color: Colors.white),
                SizedBox(width: 15),
                Expanded(child: Text('Selecione uma opção!'))
              ],
            )
        ));
  }

  void prosseguir() {
    if(indexPagina < 3){
      if(customCakeObject.campoPreenchido(indexPagina)){
        setState(() {
          indexPagina++;
        });
      } else {
        _mensagemErro();
      }
    } else {
      setState(() {
        indexPagina++;
      });
    }
  }

  void voltar() {
    customCakeObject.limparCampo(indexPagina);
    if (indexPagina > 0) {
      if (indexPagina == 1) {
        txtBtnVermelho = 'Cancelar';
      }
      setState(() {
        indexPagina--;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    customCakeObject.limparDados();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: IconAppBar(
          appBarIcon: Icons.cake,
          appBarText: 'Bolo personalizado',
        ),
        body: Column(
          children: [
            Expanded(
              child: PageTransitionSwitcher(
                duration: Duration(milliseconds: 800),
                transitionBuilder: (child, animation, secondaryAnimation) =>
                    SharedAxisTransition(
                        child: child,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal),
                child: paginas[indexPagina],
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.13,
          decoration: const BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              simpleButton(
                  175, 55, 'Prosseguir', prosseguir, 25, 20, mainColor),
              simpleButton(
                  175, 55, txtBtnVermelho, voltar, 25, 20, redButtonColor),
            ],
          ),
        )
    );
  }
  Widget cakeAdditionals(){
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          width: double.infinity,
          height: 520,
          child: Column(
            children: [
              const Text(
                'Informações adicionais',
                style: TextStyle(
                    fontSize: 22,
                    color: textSecondaryColor
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  labelText: 'Nome do bolo',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: textSecondaryColor
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  simpleButton(199, 39, 'Adicionar imagem', (){}, defaultButtonRadius, 18, mainColor),
                  Text(
                    '- Não é obrigatória'
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}

class CustomCakeOptionStep extends StatefulWidget {

  final String tituloOpcao;
  final String pastaOpcao;
  final int etapaOpcao;

  const CustomCakeOptionStep({Key? key,
    required this.tituloOpcao,
    required this.pastaOpcao,
    required this.etapaOpcao}) : super(key: key);

  @override
  _CustomCakeOptionStepState createState() => _CustomCakeOptionStepState();
}

class _CustomCakeOptionStepState extends State<CustomCakeOptionStep> {

  BoloPersonalizadoService customCakeStep = BoloPersonalizadoService();
  late Future<List<OpcaoBoloPersonalizado>> stepList;

  int selectedOption = -1;

  void selectOption(index, String option){
    switch(widget.etapaOpcao){
      case 0 :
        customCakeObject.massa = option;
        break;
      case 1 :
        customCakeObject.recheio = option;
        break;
      case 2 :
        customCakeObject.cobertura = option;
        break;
      case 3 :
        customCakeObject.confeito = option;
        break;
    }

    setState(() {
      selectedOption = index;
    });
  }

  @override
  void initState() {
    super.initState();

    switch(widget.etapaOpcao){
      case 0 :
        stepList = customCakeStep.getMassa();
        break;
      case 1 :
        stepList = customCakeStep.getRecheio();
        break;
      case 2 :
        stepList = customCakeStep.getCobertura();
        break;
      case 3 :
        stepList = customCakeStep.getConfeitos();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      children: [
        Text(
          widget.tituloOpcao,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, color: textSecondaryColor),
        ),
        const SizedBox(height: 15),
        FutureBuilder<List<OpcaoBoloPersonalizado>>(
          future: stepList,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return SizedBox(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: () => selectOption(
                          index,
                          snapshot.data![index].nome
                        ),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: 332,
                          height: 89,
                          padding: selectedOption == index
                              ? const EdgeInsets.all(0)
                              : const EdgeInsets.only(left: 15, bottom: 10),
                          alignment: selectedOption == index
                              ? Alignment.center
                              : Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                urlImagem + '${widget.pastaOpcao}/' + snapshot.data![index].img,
                              ),
                            ),
                          ),
                          child: selectedOption == index
                              ? Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: ColoredBox(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Selecionado',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.task_alt,
                                    color: mainColor,
                                  )
                                ],
                              ),
                            ],
                          )
                          : Text(
                            snapshot.data![index].nome,
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: mainTextColor
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, int index) {
                      return const SizedBox(height: 10);
                    },
                  )
              );
            } else if (snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class CustomCakeOptionStepS extends StatefulWidget {

  final String tituloOpcao;
  final String pastaOpcao;
  final int etapaOpcao;

  const CustomCakeOptionStepS({Key? key,
    required this.tituloOpcao, required this.pastaOpcao, required this.etapaOpcao}) : super(key: key);

  @override
  _CustomCakeOptionStepSState createState() => _CustomCakeOptionStepSState();
}

class _CustomCakeOptionStepSState extends State<CustomCakeOptionStepS> {
  BoloPersonalizadoService customCakeStep = BoloPersonalizadoService();
  late Future<List<OpcaoBoloPersonalizado>> stepList;

  int selectedOption = -1;

  void selectOption(index, String option){
    switch(widget.etapaOpcao){
      case 0 :
        customCakeObject.massa = option;
        break;
      case 1 :
        customCakeObject.recheio = option;
        break;
      case 2 :
        customCakeObject.cobertura = option;
        break;
      case 3 :
        customCakeObject.confeito = option;
        break;
    }

    setState(() {
      selectedOption = index;
    });
  }

  @override
  void initState() {
    super.initState();

    switch(widget.etapaOpcao){
      case 0 :
        stepList = customCakeStep.getMassa();
        break;
      case 1 :
        stepList = customCakeStep.getRecheio();
        break;
      case 2 :
        stepList = customCakeStep.getCobertura();
        break;
      case 3 :
        stepList = customCakeStep.getConfeitos();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      children: [
        Text(
          widget.tituloOpcao,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, color: textSecondaryColor),
        ),
        const SizedBox(height: 15),
        FutureBuilder<List<OpcaoBoloPersonalizado>>(
          future: stepList,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return SizedBox(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: () => selectOption(
                            index,
                           snapshot.data![index].nome,
                        ),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: 332,
                          height: 89,
                          padding: selectedOption == index
                              ? const EdgeInsets.all(0)
                              : const EdgeInsets.only(left: 15, bottom: 10),
                          alignment: selectedOption == index
                              ? Alignment.center
                              : Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                urlImagem + '${widget.pastaOpcao}/' + snapshot.data![index].img,
                              ),
                            ),
                          ),
                          child: selectedOption == index
                              ? Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: ColoredBox(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Selecionado',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.task_alt,
                                    color: mainColor,
                                  )
                                ],
                              ),
                            ],
                          )
                          : Text(
                            snapshot.data![index].nome,
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: mainTextColor
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, int index) {
                      return const SizedBox(height: 10);
                    },
                  )
              );
            } else if (snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class CustomCakeFinal extends StatelessWidget {

  const CustomCakeFinal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    customCakeObject.nome = 'Bolo personalizado';

    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 10),
        const Text(
          'Seu bolo personalizado',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 22,
              color: textSecondaryColor
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xff64CBC7),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: customCakeObject.imagem == null
                    ? urlImagem + '/bolos/personalizado.png'
                    : urlImagem + '/bolos/${customCakeObject.imagem}',
                    errorWidget: (context, url, error) => const Center(
                      child: Text(
                        'Erro ao carregar a imagem :(',
                        style: TextStyle(
                            color: mainTextColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 10),
                      child: SizedBox(
                        width: 237,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              '${customCakeObject.nome}',
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  height: 0.95
                              ),
                            ),
                            Text(
                              'Bolo Personalizado',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textSecondaryColor
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                      width: 108,
                      height: 81,
                      decoration: const BoxDecoration(
                          color: Color(0xff00A59F),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25))),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'R\$',
                                    style: TextStyle(fontSize: 25)),
                                TextSpan(
                                    text: '45',
                                    style: TextStyle(fontSize: 35)),
                              ]),
                        ),
                      )
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Características',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Peso',
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' 1kg (Padrão)',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal
                                  )
                              )
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Massa',
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' ${customCakeObject.massa}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal
                                  )
                              )
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Recheio',
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' ${customCakeObject.recheio}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal
                                  )
                              )
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Cobertura',
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' ${customCakeObject.cobertura}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal
                                  )
                              )
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Confeito',
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' ${customCakeObject.confeito}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal
                                  )
                              )
                            ]
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ],
    );
  }
}