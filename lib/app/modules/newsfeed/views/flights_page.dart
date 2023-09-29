import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../utils/constants.dart';

class FlightsPage extends StatefulWidget {
  const FlightsPage({Key? key}) : super(key: key);

  @override
  State<FlightsPage> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<FlightsPage> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _adultosHasError = false;
  bool _origenHasError = false;

  var origenOptions = [
    '10-20',
    '20-30',
    '30-40',
    '40-50',
    '50-60',
    '60-70',
    '70+'
  ];
  var destionationOptions = ['Masculino', 'Femenino', 'Otros'];

  var ejercicios = ['Yes', 'No'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: Text(
          "CardioTunes",
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                  debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,
                initialValue: const {
                  'edad': '20-30',
                  'sexo': 'Otros',
                  'ejercicio': 'Yes',
                  'ritmo_cardiaco': '80',
                },
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    FormBuilderDropdown<String>(
                      // autovalidate: true,
                      name: 'edad',
                      decoration: InputDecoration(
                        labelText: 'Rango de Edad',
                        suffix: _origenHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                        hintText: 'Select Gender',
                      ),
                      initialValue: '20-30',
                      // allowClear: true,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: origenOptions
                          .map((edad) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: edad,
                                child: Text(edad),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _origenHasError = !(_formKey
                                  .currentState?.fields['edad']
                                  ?.validate() ??
                              false);
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    FormBuilderDropdown<String>(
                      // autovalidate: true,
                      name: 'sexo',
                      decoration: InputDecoration(
                        labelText: 'Sexo',
                        suffix: _origenHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                        hintText: 'Seleccione Destino',
                      ),
                      initialValue: 'Otros',
                      // allowClear: true,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: destionationOptions
                          .map((sexo) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: sexo,
                                child: Text(sexo),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _origenHasError = !(_formKey
                                  .currentState?.fields['sexo']
                                  ?.validate() ??
                              false);
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    FormBuilderDropdown<String>(
                      // autovalidate: true,
                      name: 'ejercicio',
                      decoration: InputDecoration(
                        labelText: 'Practica Ejercicios',
                        suffix: _origenHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                        hintText: 'Seleccione Destino',
                      ),
                      initialValue: 'Yes',
                      // allowClear: true,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: ejercicios
                          .map((ejercicio) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: ejercicio,
                                child: Text(ejercicio),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _origenHasError = !(_formKey
                                  .currentState?.fields['ejercicios']
                                  ?.validate() ??
                              false);
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    FormBuilderTextField(
                      //autovalidateMode: AutovalidateMode.always,
                      name: 'ritmo_cardiaco',
                      decoration: InputDecoration(
                        labelText: 'Ritmo Cardiaco',
                        suffixIcon: _adultosHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _adultosHasError = !(_formKey
                                  .currentState?.fields['ritmo_cardiaco']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(200),
                      ]),
                      initialValue: '80',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          debugPrint(_formKey.currentState?.value.toString());
                          launchYoutube();
                        } else {
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('validation failed');
                        }
                      },
                      child: const Text(
                        'Enviar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      // color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Limpiar Forma',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchYoutube() async {
    var url = 'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
    var ritmo = int.parse(_formKey.currentState?.value['ritmo_cardiaco']);

    if (ritmo < 80) {
      url = "https://youtu.be/wZZ8V2AFUq0?si=BqriWKzC_PyZFOEI";
    } else if (ritmo >= 80 && ritmo < 90) {
      url = "https://youtu.be/TXGbhniTBrU?si=wBTRP7WgixwcfpfS";
    } else if (ritmo >= 90 && ritmo < 100) {
      url = "https://youtu.be/jro_e9b5PWo?si=O8qeCedP_sMruamg";
    } else if (ritmo >= 100 && ritmo < 110) {
      url = "https://youtu.be/khOFw2f4bQY?si=HJUo0UBV8yEefSvb";
    } else if (ritmo >= 110 && ritmo < 120) {
      url = "https://youtu.be/c3rmfCuJgmw?si=vRwYKjfOc86ugn80";
    } else if (ritmo >= 120 && ritmo < 130) {
      url = "https://youtu.be/uTuuz__8gUM?si=bokAsQmjEBMhHkDt";
    } else if (ritmo >= 130 && ritmo < 140) {
      url = "https://youtu.be/mIYzp5rcTvU?si=yCCnybmTzvmKp6jG";
    } else if (ritmo >= 140 && ritmo < 150) {
      url = "https://youtu.be/tlp8iY4g--4?si=93A4HGfdX3m7oN48";
    } else if (ritmo >= 150 && ritmo < 160) {
      url = "https://youtu.be/1WEIYit3IGc?si=6WrQhlTRvaZZmXIb";
    } else if (ritmo >= 160) {
      url = "https://youtu.be/lEiSE7ibUsI?si=Ye_i43Pa4DIj5YZy";
    }

    try {
      if (await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication)) {
      } else {
        debugPrint('#1: Could not launch $url');
      }
    } catch (e) {
      debugPrint('#2: Could not launch $url');
    }
  }
}
