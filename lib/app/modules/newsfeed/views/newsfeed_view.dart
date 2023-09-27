import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/newsfeed_controller.dart';

class NewsfeedView extends GetView<NewsfeedController> {
  const NewsfeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const TextField(
              // controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Edad'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: "Masculino",
              onChanged: (value) {
                // gender = value.toString();
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
                    //setState(() {
                    //  isExercising = value ?? false;
                    //});
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
                final edad = 15;
                final ritmoCardiaco = 80;
                final informacion = {
                  'Edad': edad,
                  'Sexo': "Male",
                  'Ejercicio': 'Sí',
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
