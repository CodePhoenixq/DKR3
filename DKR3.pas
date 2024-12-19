uses
  Math;

const
  Epsilon = 1e-6;  // Погрешность, при которой будет завершен расчет

// Функция, которая задает кривую: f(x) = x^3 + 2x^2 + 4x + 15
function f(x: Real): Real;
begin
  f := x * x * x + 2 * x * x + 4 * x + 15;
end;

// Метод Симпсона для численного интегрирования
function Simpson(a, b: Real; n: Integer): Real;
var
  h, sum, x: Real;
  i: Integer;
begin
  h := (b - a) / n;
  sum := f(a) + f(b);
  
  for i := 1 to n div 2 - 1 do
  begin
    x := a + 2 * i * h;
    sum := sum + 4 * f(x);
  end;

  for i := 2 to n div 2 do
  begin
    x := a + (2 * i - 1) * h;
    sum := sum + 2 * f(x);
  end;

  sum := sum * h / 3;
  Simpson := sum;
end;

// Оценка погрешности методом Симпсона
function EstimateError(a, b: Real; n: Integer): Real;
var
  h, secondDerivative1, secondDerivative2, maxDer: Real;
begin
  h := (b - a) / n;

  // Для вычисления максимальной второй производной
  secondDerivative1 := 6 * b + 4;
  secondDerivative2 := 6 * a + 4;

  maxDer := Max(secondDerivative1, secondDerivative2);

  EstimateError := (b - a) * h * h * h * maxDer / 180;
end;

// Основная процедура
procedure CalculateArea;
var
  a, b: Real;
  n: Integer;
  result, error: Real;
begin
  WriteLn('Введите пределы интегрирования:');
  Write('a = ');
  ReadLn(a);
  Write('b = ');
  ReadLn(b);
  
  Write('Введите количество разбиений (n): ');
  ReadLn(n);

  // Вызов метода Симпсона для вычисления площади
  result := Simpson(a, b, n);

  // Оценка погрешности
  error := EstimateError(a, b, n);

  WriteLn('Площадь, вычисленная методом Симпсона: ', result:0:6);
  WriteLn('Оценка погрешности: ', error:0:6);
end;

// Главное меню
procedure MainMenu;
var
  choice: Integer;
begin
  repeat
    WriteLn('1. Вычислить площадь');
    WriteLn('2. Выход');
    Write('Выберите действие (1-2): ');
    ReadLn(choice);

    case choice of
      1: CalculateArea;
      2: WriteLn('Выход из программы.');
    else
      WriteLn('Неверный выбор. Пожалуйста, попробуйте снова.');
    end;

  until choice = 2;
end;

begin
  MainMenu;
end.