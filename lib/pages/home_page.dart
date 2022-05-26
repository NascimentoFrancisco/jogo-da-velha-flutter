import 'package:flutter/material.dart';

class HomeGamePage extends StatefulWidget {
  const HomeGamePage({ Key? key }) : super(key: key);

  @override
  State<HomeGamePage> createState() => _HomeGamePageState();
}

class _HomeGamePageState extends State<HomeGamePage> {
  
  bool Virada = true;

  int Score_o = 0;
  int Score_x = 0;
  int toosblocos = 0;

  List<String> ElementosTela = ['','','','','','','','',''];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 92, 34, 92),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Jogador X', 
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(Score_x.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Jogador O',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(Score_o.toString(),
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3), 
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: (){
                      _mover(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)
                      ),
                      child: Center(
                        child: Text(ElementosTela[index],
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      )
                    ),
                  );
                }
              )
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                      onPressed: () {
                        _limparTabuleiro();
                      }, 
                      child: Text('Limpar tudo')
                    )
                  ],
                ),
              ) 
            ),
          ]
        ),
    );
  }

  void _mover(int index){
    setState(() {
      if (Virada && ElementosTela[index] == ''){
        ElementosTela[index] = 'O';
        toosblocos ++;
      }else if (!Virada && ElementosTela[index] == ''){
        ElementosTela[index] = 'X';
        toosblocos ++;
      }

      Virada = !Virada;
      _verificaVencedor();
    });
  }
  
  void _verificaVencedor(){
    //Verificando as linhas
    if(ElementosTela[0] == ElementosTela[1] && ElementosTela[0] == ElementosTela[2] && ElementosTela[0] != ''){
      _mostraDialogo(ElementosTela[0]);
    }
    if(ElementosTela[3] == ElementosTela[4] && ElementosTela[3] == ElementosTela[5] && ElementosTela[3] != ''){
      _mostraDialogo(ElementosTela[3]);
    }
    if(ElementosTela[6] == ElementosTela[7] && ElementosTela[6] == ElementosTela[8] && ElementosTela[6] != ''){
      _mostraDialogo(ElementosTela[6]);
    }
    //Verificando as colunas
    if(ElementosTela[0] == ElementosTela[3] && ElementosTela[0] == ElementosTela[6] && ElementosTela[0] != ''){
      _mostraDialogo(ElementosTela[0]);
    }
    if(ElementosTela[1] == ElementosTela[4] && ElementosTela[1] == ElementosTela[7] && ElementosTela[1] != ''){
      _mostraDialogo(ElementosTela[1]);
    }
    if(ElementosTela[2] == ElementosTela[5] && ElementosTela[2] == ElementosTela[8] && ElementosTela[2] != ''){
      _mostraDialogo(ElementosTela[2]);
    }
    //Verificando Diagonais
    if(ElementosTela[0] == ElementosTela[4] && ElementosTela[0] == ElementosTela[8] && ElementosTela[0] != ''){
      _mostraDialogo(ElementosTela[0]);
    }
    if(ElementosTela[2] == ElementosTela[4] && ElementosTela[2] == ElementosTela[6] && ElementosTela[2] != ''){
      _mostraDialogo(ElementosTela[2]);
    } else if(toosblocos == 9){
      _mostraPerdaDialogo();
    } 
  }

  void _mostraDialogo(String vencedor){
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("\" "+ vencedor+"\" é o vencedor!"),
          actions: [
            ElevatedButton(onPressed: (){
              _limparTabuleiro();
              Navigator.of(context).pop();
            }, 
              child: Text('Jogar novamnete'))
          ],
        );
      });
    if (vencedor == 'O') {
      Score_o++;
    } else if (vencedor == 'X') {
      Score_x++;
    }
  }

  void _mostraPerdaDialogo(){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Deu velha!'),
          actions: [
            ElevatedButton(onPressed: (){
              _limparTabuleiro();
              Navigator.of(context).pop();
            }, 
            child: Text('Jogar novamnete'))
          ],
        );
      });
  }

  void _limparTabuleiro(){
    setState(() {
      for(int i = 0; i < 9;i++){
        ElementosTela[i] = '';
      }
    });
    toosblocos = 0;
  }

}