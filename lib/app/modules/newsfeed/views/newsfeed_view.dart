import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/newsfeed_controller.dart';

class NewsfeedView extends GetView<NewsfeedController> {
  const NewsfeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ageRange = "20-35";
    String gender = "Masculino";
    bool isExercising = true;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: Text(
          'ai_tab_title'.tr,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField(
              value: "20-35",
              onChanged: (value) {
                ageRange = value.toString();
              },
              items: [
                '0-10',
                '10-20',
                '20-35',
                '35-50',
                '50-65',
                '65-80',
                '80+'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Rango de Edad'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: "Masculino",
              onChanged: (value) {
                gender = value.toString();
              },
              items: ['Masculino', 'Femenino', 'Otro']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Sexo'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                const Text('¿Hace ejercicio?'),
                Checkbox(
                  value: true,
                  onChanged: (value) {
                    isExercising = value ?? false;
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const TextField(
              //controller: heartRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ritmo Cardíaco'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes enviar la información al servidor
                final ritmoCardiaco = 80;
                var informacion = {
                  'Edad': ageRange,
                  'Sexo': gender,
                  'Ejercicio': isExercising,
                  'Ritmo Cardiaco': ritmoCardiaco,
                };

                // Enviar la información al servidor aquí

                // Mostrar un mensaje de éxito
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Información enviada con éxito'),
                  ),
                );
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
