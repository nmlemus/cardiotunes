import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../utils/constants.dart';

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

  var origenOptions = ['Habana', 'Santa Clara', 'Holguin', 'Panama-Tocumen'];
  var destionationOptions = ['Habana', 'Santa Clara', 'Holguin', 'Panama-Tocumen'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: Text(
          "Pasajes",
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
                  'adultos': '1',
                  'ninos': '0',
                  'origen': 'Habana',
                  'destination': 'Panama-Tocumen',
                },
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    FormBuilderDropdown<String>(
                      // autovalidate: true,
                      name: 'origen',
                      decoration: InputDecoration(
                        labelText: 'Desde',
                        suffix: _origenHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      // initialValue: 'Male',
                      allowClear: true,
                      hint: const Text('Seleccione Origen'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: origenOptions
                          .map((origen) => DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: origen,
                        child: Text(origen),
                      ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _origenHasError = !(_formKey
                              .currentState?.fields['origen']
                              ?.validate() ??
                              false);
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    FormBuilderDropdown<String>(
                      // autovalidate: true,
                      name: 'destination',
                      decoration: InputDecoration(
                        labelText: 'Hasta',
                        suffix: _origenHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      // initialValue: 'Male',
                      allowClear: true,
                      hint: const Text('Seleccione Destino'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: destionationOptions
                          .map((destination) => DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: destination,
                        child: Text(destination),
                      ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _origenHasError = !(_formKey
                              .currentState?.fields['destination']
                              ?.validate() ??
                              false);
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    FormBuilderDateRangePicker(
                      name: 'date_range',
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2030),
                      format: DateFormat('yyyy-MM-dd'),
                      onChanged: _onChanged,
                      decoration: InputDecoration(
                        labelText: 'Fechas',
                        //helperText: 'Helper text',
                        hintText: 'Hint text',
                        /*suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['date_range']
                                ?.didChange(null);
                          },
                        ),*/
                        suffix: _origenHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                    ),
                    FormBuilderTextField(
                      //autovalidateMode: AutovalidateMode.always,
                      name: 'adultos',
                      decoration: InputDecoration(
                        labelText: 'Adultos +12',
                        suffixIcon: _adultosHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _adultosHasError = !(_formKey.currentState?.fields['adultos']
                              ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(70),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      //autovalidateMode: AutovalidateMode.always,
                      name: 'ninos',
                      decoration: InputDecoration(
                        labelText: 'Niños entre 2 y 12 años',
                        suffixIcon: _adultosHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _adultosHasError = !(_formKey.currentState?.fields['ninos']
                              ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(70),
                      ]),
                      // initialValue: '12',
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
                          launchWhatsApp();
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

  launchWhatsApp() async {
    WhatsAppUnilink link = WhatsAppUnilink(
      phoneNumber: Constants.phone,
      text: "Hola  *Pa'Cuba* \n"
          "\n"
          "Estoy necesitando un pasaje:\n"
          "\n"
          "🛫 *Origen*:  ${_formKey.currentState?.value['origen']} \n "
          "🛬 *Destino*:  ${_formKey.currentState?.value['destination']} \n "
          "📆 *Fecha Ida*:  ${_formKey.currentState?.value['date_range'].toString().split(' - ')[0].toString().split(' ')[0]} \n "
          "📆 *Fecha Retorno*:  ${_formKey.currentState?.value['date_range'].toString().split(' - ')[1].toString().split(' ')[0]} \n "
          "🧑 *Adultos*:  ${_formKey.currentState?.value['adultos']} \n "
          "🧒 *Niños*:  ${_formKey.currentState?.value['ninos']} \n "
          "\n"
          "Le agradeceria que me cotizara los precios. \n "
          "\n"
          "Desde ya les agradezco.",
    );
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }
}
