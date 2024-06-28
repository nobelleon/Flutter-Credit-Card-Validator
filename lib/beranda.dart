import 'package:credit_card_validate/credit_card_validate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Beranda extends StatefulWidget {
  final String title;

  const Beranda({key, this.title});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  String creditCardNumber = '';
  IconData brandIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250,
              child: TextField(
                onChanged: (String str) {
                  setState(() {
                    creditCardNumber = str;
                  });
                  String brand = CreditCardValidator.identifyCardBrand(str);
                  IconData ccBrandIcon;
                  // Visa, Master Card, American Express, Discover
                  if (brand != null) {
                    if (brand == 'visa') {
                      ccBrandIcon = FontAwesomeIcons.ccVisa;
                    } else if (brand == 'master_card') {
                      ccBrandIcon = FontAwesomeIcons.ccMastercard;
                    } else if (brand == 'american_express') {
                      ccBrandIcon = FontAwesomeIcons.ccAmex;
                    } else if (brand == 'discover') {
                      ccBrandIcon = FontAwesomeIcons.ccDiscover;
                    }
                  }
                  setState(() {
                    brandIcon = ccBrandIcon;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Start typing to validate...',
                  suffixIcon: brandIcon != null
                      ? FaIcon(
                          brandIcon,
                          size: 32,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //--------------
            // max 13 digit
            //--------------
            creditCardNumber.length < 13
                ? const Text('Please enter atleast 13 characters')
                : CreditCardValidator.isCreditCardValid(
                        cardNumber: creditCardNumber)
                    ? const Text(
                        'The credit card number is valid.',
                        style: TextStyle(color: Colors.green),
                      )
                    : const Text(
                        'The credit card number is invalid.',
                        style: TextStyle(color: Colors.red),
                      )
          ],
        ),
      ),
    );
  }
}
