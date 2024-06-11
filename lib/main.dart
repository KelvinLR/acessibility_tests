import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int times = 0;
  String focusWidget = "";
  String enteredOption = "";
  String enteredText = "";

  void increment() {
    setState(() {
      times++;
    });
  }

  void changeText(String text) {
    setState(() {
      enteredText = text;
    });
  }

  void showFocused(String focus) {
    setState(() {
      focusWidget = focus;
    });
  }

  void showAppBarOption(String option) {
    setState(() {
      enteredOption = option;
    });
  }

  void refresh() {
    setState(() {
      times = 0;
      enteredOption = "";
      enteredText = "";
      focusWidget = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Accessibility tests',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("My Accessible App"),
            backgroundColor: Colors.lightGreen,
            actions: [
              IconButton(
                  onPressed: () {
                    refresh();
                  },
                  icon: const Icon(Icons.refresh))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Semantics(
                    onDidGainAccessibilityFocus: () {
                      showFocused('caixa de texto');
                    },
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: "Caixa de texto acessível"),
                      onSubmitted: (enteredText) {
                        changeText(enteredText);
                      },
                    ),
                  ),
                  Semantics(
                      onDidGainAccessibilityFocus: () {
                        showFocused('texto digitado na caixa de texto');
                      },
                      child: Text('Texto digitado: $enteredText')),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Semantics(
                          onDidGainAccessibilityFocus: () {
                            showFocused('Container 1');
                          },
                          sortKey: const OrdinalSortKey(2),
                          child: Container(
                            width: deviceWidth * (100 / 360),
                            height: deviceWidth * (100 / 360),
                            color: Colors.lightGreen,
                            child: const Center(child: Text('Container 1')),
                          ),
                        ),
                        Semantics(
                          onDidGainAccessibilityFocus: () {
                            showFocused('Container 2');
                          },
                          sortKey: const OrdinalSortKey(1),
                          child: Container(
                            width: deviceWidth * (100 / 360),
                            height: deviceWidth * (100 / 360),
                            color: Colors.lightGreen,
                            child: const Center(child: Text('Container 2')),
                          ),
                        ),
                        Semantics(
                          onDidGainAccessibilityFocus: () {
                            showFocused('Container 3');
                          },
                          sortKey: const OrdinalSortKey(3),
                          child: Container(
                            width: deviceWidth * (100 / 360),
                            height: deviceWidth * (100 / 360),
                            color: Colors.lightGreen,
                            child: const Center(child: Text('Container 3')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("Widget em foco: $focusWidget"),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Semantics(
                        onDidGainAccessibilityFocus: () {
                          showFocused('Imagem 1');
                        },
                        label: "Imagem de uma coruja marrom com olhos amarelos",
                        child: Image(
                          width: deviceWidth * (100 / 360),
                          height: deviceWidth * (100 / 360),
                          image: const NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                        ),
                      ),
                      Semantics(
                        onDidGainAccessibilityFocus: () {
                          showFocused('Imagem 2');
                        },
                        label: "Imagem da Opera House em Sydney, Austrália",
                        child: Image(
                          width: deviceWidth * (100 / 360),
                          height: deviceWidth * (100 / 360),
                          image: const NetworkImage(
                              'https://i.pinimg.com/736x/23/f6/50/23f650ce7007aaf82a915c609f4269a5.jpg'),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  ElevatedButton(
                    onPressed: () {
                      increment();
                    },
                    child: const Text("Me aperte"),
                  ),
                  Semantics(
                      onDidGainAccessibilityFocus: () {
                        showFocused('Quantidade de apertos');
                      },
                      child: Text("Você apertou o botão $times vezes")),
                  Semantics(
                    onDidGainAccessibilityFocus: () {
                      showFocused('Opção da barra de navegação');
                    },
                    child: Center(
                      child: Text(
                          "Opção selecionada na barra de navegação: $enteredOption"),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      showAppBarOption('Home');
                    },
                    icon: const Icon(Icons.home)),
                IconButton(
                    onPressed: () {
                      showAppBarOption('Microfone');
                    },
                    icon: const Icon(Icons.mic)),
                IconButton(
                    onPressed: () {
                      showAppBarOption('Configurações');
                    },
                    icon: const Icon(Icons.settings)),
              ],
            ),
          ),
        ));
  }
}
