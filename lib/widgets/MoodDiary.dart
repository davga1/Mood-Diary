import 'package:flutter/material.dart';
import 'package:mood_diary/constants.dart';

int _index = 7;
String note = '';
String emote = '';
double stress = 0;
double selfRating = 0;
TextEditingController controller = TextEditingController();

class MoodDiary extends StatefulWidget {
  const MoodDiary({super.key});

  @override
  State<MoodDiary> createState() => _MoodDiaryState();
}

class _MoodDiaryState extends State<MoodDiary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Что чувствуешь?',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  6,
                  (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35)),
                            child: Container(
                              height: 120,
                              width: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: index == _index
                                          ? Colors.orange
                                          : Colors.white),
                                  borderRadius: BorderRadius.circular(35)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    images[index],
                                    style: const TextStyle(fontSize: 40),
                                  ),
                                  Text(
                                    emotions[index],
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            )),
                        onTap: () => setState(() {
                          _index = index;
                          emote = emotions[index];
                        }),
                      )),
                ),
              ],
            ),
          ),
          const Text(
            'Уровень стресса',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          sliderWithText('Низкий', 'Высокий', stress, (value) {
            setState(() {
              stress = value;
            });
          }),
          const Text(
            'Самооценка',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          sliderWithText('Неуверенность', 'Уверенность', selfRating, (value) {
            setState(() {
              selfRating = value;
            });
          }),
          const Text(
            'Заметки',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              onChanged: (value) => setState(() {
                note = value;
              }),
              decoration: const InputDecoration(
                hintText: 'Введите заметку',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              maxLines: 7,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: note.isNotEmpty && emote.isNotEmpty
                    ? Colors.orange
                    : Colors.grey,
                borderRadius: BorderRadius.circular(25)),
            child: TextButton(
                onPressed: () {
                  note.isNotEmpty && emote.isNotEmpty
                      ? {
                          showDialog(
                            context: context,
                            builder: (context) => Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                      '$note!\n Я чувствую $emote\nМой уровень стресса: $stress\nМой уровень самооценки:$selfRating')),
                            ),
                          ).then(
                            (value) => setState(() {
                              note = '';
                              emote = '';
                              _index = 7;
                              controller.clear();
                            }),
                          ),
                        }
                      : null;
                },
                child: Text(
                  'Сохранить',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: note.isNotEmpty && emote.isNotEmpty
                          ? Colors.white
                          : Colors.blueGrey),
                )),
          )
        ],
      ),
    );
  }

  Container sliderWithText(
      String min, String max, double sliderValue, Function(double) onChanged) {
    return Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    6,
                    (index) => const Text(
                      '  |',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SliderTheme(
              data: SliderThemeData.fromPrimaryColors(
                  primaryColor: Colors.orange,
                  primaryColorDark: Colors.greenAccent,
                  primaryColorLight: Colors.white,
                  valueIndicatorTextStyle:
                      const TextStyle(color: Colors.orange)),
              child: Slider(
                value: sliderValue,
                onChanged: onChanged,
                min: 0,
                max: 10,
                divisions: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(min), Text(max)],
              ),
            ),
          ],
        ));
  }
}
