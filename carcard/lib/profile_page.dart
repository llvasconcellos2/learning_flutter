import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, //don't cut the favorite button
      children: [
        Container(color: Colors.blueGrey.shade800),
        Image.network(
          'https://llvasconcellos2.github.io/img/header.jpg',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 50,
            right: 50,
            bottom: 60,
            top: 200,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade300,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 122),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.blueGrey.shade600,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 75,
                child: Image.network(
                  'https://llvasconcellos2.github.io/img/profile.png',
                ),
              ),
            ),
            SizedBox(width: double.infinity, height: 30),
            Text(
              'Leonardo Lima de Vasconcellos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'ENGENHEIRO DE SOFTWARE',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SocialButton(
                        icon: FontAwesomeIcons.twitter,
                        url: 'https://x.com/llvasconcellos2',
                      ),
                      SocialButton(
                        icon: FontAwesomeIcons.linkedin,
                        url: 'https://www.linkedin.com/in/llvasconcellos/',
                      ),
                      SocialButton(
                        icon: FontAwesomeIcons.instagram,
                        url: 'https://www.instagram.com/llvasconcellos/',
                      ),
                      SocialButton(
                        icon: FontAwesomeIcons.pinterest,
                        url: 'https://br.pinterest.com/',
                      ),
                      SocialButton(
                        icon: FontAwesomeIcons.facebook,
                        url: 'https://www.facebook.com/llvasconcellos',
                      ),
                    ],
                  ),
                  SizedBox(height: 52),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '240',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 36,
                            ),
                          ),
                          Text(
                            'SEGUINDO',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '64k',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 36,
                            ),
                          ),
                          Text(
                            'SEGUIDORES',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 42),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Container(
                color: Colors.blueGrey.shade400,
                width: double.infinity,
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          Image.asset('images/foto1.png', width: 60),
                          Positioned(
                            left: 40,
                            child: Image.asset('images/foto2.png', width: 60),
                          ),
                          Positioned(
                            left: 80,
                            child: Image.asset('images/foto3.png', width: 60),
                          ),
                          Positioned(
                            left: 120,
                            child: Image.asset('images/foto4.png', width: 60),
                          ),
                          Positioned(
                            left: 160,
                            child: Image.asset('images/foto5.png', width: 60),
                          ),
                          Positioned(
                            left: 200,
                            child: Image.asset('images/foto6.png', width: 60),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '22 SEGUIDORES EM DESTAQUE',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueGrey.shade700,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('SEGUIR AGORA'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialButton({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: () async {
        if (!await launchUrl(Uri.parse(url))) {
          throw Exception('Could not launch url');
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 2, color: Colors.blueGrey.shade600),
        ),
        child: Icon(icon, color: Colors.blueGrey.shade700),
      ),
    );
  }
}
