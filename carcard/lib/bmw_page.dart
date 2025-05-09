import 'package:flutter/material.dart';

class BMWPage extends StatefulWidget {
  const BMWPage({super.key});

  @override
  State<BMWPage> createState() => _BMWPageState();
}

class _BMWPageState extends State<BMWPage> {
  List<String> imageList = [
    // 'https://production.autoforce.com/uploads/version/profile_image/10419/model_middle_webp_comprar-competition_d914780934.png.webp',
    // 'https://prod.cosy.bmw.cloud/bmwweb/cosySec?COSY-EU-100-7331c9Nv2Z7d5yKlHS91AmhrAWVxEaMqjmAZnjCrmQvi3D%25zWUM1PdqJujmBY0JuSDOPRQpSxIhkWExHS9gwyljT5lkQM37fNwDTjHBDcKkPPox9syh3b4gZqmazOSJ5jqLQ7ayV8x6nw1pCaJXgtUDlkvns7sY7OVK3dBzcBqrhpeqKCGZIyRscCw29cvnwp9QAuhFyqlABKupuV8FeWS6SBBKMPVYps5WhbNm6MIPo90yYh6bHi4TmtY9%25wc3y7ciftxdTCqw178zBQltECUke3Z7slGAM9QCrXpF7islZQ6KCZfXRaYWlRwQ5nmPXiJagOybQwGnvIT9arOO2B3in1vIjedwO4NBDMztIcgeqhk7BRKMLoACeKAhJHFlM52ou%25KXhgoHSfWQtSq%25V1Pa7RSfNEbnCBr10s9Ol89E4riIXU2scZwBQGcrxRteaEzZ857Mns7RUgChOrM5GvloqLggp2XHLVGv6jQ%25JTQ2YDafu3Rjmqn1SdiDyLOEVtKqTJIsN7CL3uBr0SPJdSeZ4GbuzVMRPs0SkNh5byyVA0og9QNNF4HvifB0Kc%252w1u4WxfjxLzcP81D8wexbUEqUtc89GsLGDeUiprJpXLGw6Zu6GqptYRSYNc67m5VmyIYCygNyT2mlTv0TCkyX3243lfTQdjcdXQ3azDxOYddnkq8IiHzOSs5m%2565ezICP4Wsduk45IoFSr86JdoFXCp5l8snYrsv6OgHqvZ2aKBf',
    'https://www.webmotors.com.br/imagens/prod/348844/BMW_M3_3.0_I6_TWINTURBO_GASOLINA_COMPETITION_TRACK_STEPTRONIC_34884414314411433.png?s=fill&w=440&h=330&q=80&t=true',
    'https://www.webmotors.com.br/imagens/prod/348844/BMW_M3_3.0_I6_TWINTURBO_GASOLINA_COMPETITION_TRACK_STEPTRONIC_34884414314735879.png?s=fill&w=440&h=330&q=80&t=true',
    'https://www.webmotors.com.br/imagens/prod/348844/BMW_M3_3.0_I6_TWINTURBO_GASOLINA_COMPETITION_TRACK_STEPTRONIC_34884414314865918.png?s=fill&w=440&h=330&q=80&t=true',
    'https://www.webmotors.com.br/imagens/prod/348844/BMW_M3_3.0_I6_TWINTURBO_GASOLINA_COMPETITION_TRACK_STEPTRONIC_34884414314545290.png?s=fill&w=440&h=330&q=80&t=true',
    'https://www.webmotors.com.br/imagens/prod/348844/BMW_M3_3.0_I6_TWINTURBO_GASOLINA_COMPETITION_TRACK_STEPTRONIC_34884414314818987.png?s=fill&w=440&h=330&q=80&t=true',
    'https://www.webmotors.com.br/imagens/prod/348844/BMW_M3_3.0_I6_TWINTURBO_GASOLINA_COMPETITION_TRACK_STEPTRONIC_34884414314693969.png?s=fill&w=440&h=330&q=80&t=true',
    'https://www.webmotors.com.br/imagens/prod/348844/BMW_M3_3.0_I6_TWINTURBO_GASOLINA_COMPETITION_TRACK_STEPTRONIC_34884414314776238.png?s=fill&w=440&h=330&q=80&t=true',
    'https://www.webmotors.com.br/imagens/prod/348844/BMW_M3_3.0_I6_TWINTURBO_GASOLINA_COMPETITION_TRACK_STEPTRONIC_34884414314596195.png?s=fill&w=440&h=330&q=80&t=true',
  ];
  int imageIndex = 0;

  void changeImage(String direction) {
    if (direction == 'forward') {
      imageIndex++;
      if (imageIndex > imageList.length - 1) {
        imageIndex = 0;
      }
    } else {
      imageIndex--;
      if (imageIndex < 0) {
        imageIndex = imageList.length - 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none, //don't cut the favorite button
          children: [
            Container(
              color: Colors.blueGrey,
              child: Image.network(
                imageList[imageIndex],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  'BMW M3',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: -30,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite, color: Colors.red, size: 50),
              ),
            ),
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        changeImage('backward');
                      });
                    },
                    child: Icon(Icons.arrow_back_ios, size: 30),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        changeImage('forward');
                      });
                    },
                    child: Icon(Icons.arrow_forward_ios, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BMW M3',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Design alemão, potente e econômico',
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text('9.7'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.phone, color: Colors.blue),
                      Text('Call', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.navigation, color: Colors.blue),
                      Text('Directions', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.share, color: Colors.blue),
                      Text('Share', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                '''Esportivo, confiável e bem-sucedido: há mais de 40 anos, o BMW Série 3 representa um prazer de direção dinâmica como nenhum outro veículo. Graças ao ex-chefe de design da BMW, Paul Bracq, as emoções e a alegria de dirigir chegaram à classe média – qualidades que o BMW Série 3 sintetiza até hoje. Com o BMW E21 na década de 1970, ele lançou as bases para uma história de sucesso sem precedentes. Hoje, o sucesso do BMW Série 3 é uma das razões pelas quais a BMW é a fabricante líder de veículos premium.''',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
