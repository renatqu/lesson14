import 'dart:io';
import 'dart:math';

void main() {
  startGame();
}

void startGame() {
  print('Добро пожаловать в игру! Выбери режим:');
  print('1 Комп загадывает число ты угадываеш');
  print('2 Ты загадываешь число комп отгадывает');
  print('3 комп vs user.');

  String userAnswer = stdin.readLineSync()!;

  if (userAnswer == '1') {
    gameBot();
  } else if (userAnswer == '2') {
    binarySearch();
  } else if (userAnswer == '3') {
    UservsComp();
  } else {
    startGame();
  }
}

int gameBot() {
  // print('Комп загадывает число ты отгадываешь');
  int numComp = Random().nextInt(100) + 1;
  int usernamber = 0;
  int counter = 0;
  print('(подсказка) вот что загадал этот хитрец! $numComp');

  while (numComp != usernamber) {
    stdout.write('Введи число от 1 до 100: ');
    usernamber = int.parse(stdin.readLineSync()!);
    counter++;

    if (usernamber < 1 || usernamber > 100) {
      print('Пожалуйста, введи число коректно!.');
      usernamber = int.parse(stdin.readLineSync()!);
    } else {
      if (numComp == usernamber) {
        // print('Поздравляю! Ты угадал');
        print('Количество шагов: $counter');
      } else if (numComp > usernamber) {
        //  print('Продолжай! Я в тебя верю');
        print('загаданное число больше');
      } else if (numComp < usernamber) {
        // print('Продолжай! Я в тебя верю');
        print('загаданное число меньше');
      }
    }
  }
  return counter;
}

int binarySearch() {
  int min = 1;
  int max = 100;
  int mid = (min + max) ~/ 2;
  int counter = 0;

  String userAnswer = '';
  //print('Ты загадываешь число от 1 до 100, этот хитрец угадает');
  print(
      'Если число угадано, напиши "yes". Если твое число меньше, напиши "-". Если твое число больше, напиши"+".');

  while (userAnswer != 'yes') {
    print('Твое число $mid? ');
    userAnswer = stdin.readLineSync()!;
    counter++;
    print('Количество шагов: $counter');
    // print('комп магет!!!');

    if (userAnswer == '-') {
      max = mid - 1;
      mid = (min + max) ~/ 2;
    } else if (userAnswer == '+') {
      min = mid + 1;
      mid = (min + max) ~/ 2;
    }
  }

  return counter;
}

void UservsComp() {
  int rounds = 3;
  int UserWagi = 0;
  int CompWagi = 0;

  print(
      'Сколкько раундов зарубимся ? (от 3 до 10, нажми Enter для 3 раундов):');
  String roundsInput = stdin.readLineSync()!;
  if (roundsInput.isNotEmpty) {
    rounds = int.parse(roundsInput);
  }

  for (int i = 1; i <= rounds; i++) {
    print('=== Раунд $i ===');
    print('Ты загадываешь число, компьютер отгадывает:');

    int igraComp = binarySearch();
    CompWagi += igraComp;
    print('///////////////////////////////////////////////////////');

    print('Компьютер загадывает число, ты отгадываешь:');
    int igraUser = gameBot();
    UserWagi += igraUser;
  }

  if (UserWagi < CompWagi) {
    print('///////////////////// конец игры /////////////////////////');
    print(
        'you win! Ты потратил на отгадывание чисел $UserWagi шагов, а компьютер $CompWagi шагов.');
  } else if (CompWagi < UserWagi) {
    print('///////////////////// конец игры /////////////////////////');
    print(
        'The computer win! Компьютер потратил на отгадывание чисел $CompWagi шагов, Ты $UserWagi шагов.');
  } else {
    print('///////////////////// конец игры /////////////////////////');
    print('Ничья! Оба игрока потратили одинаковое количество шагов.');
  }
}
