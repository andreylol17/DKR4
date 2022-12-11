uses graphABC;

var
  vvod: byte;
  m1, m2: real;

var
  n: integer;

function vibor(var v: byte): byte;    
begin
  writeln('Да - 1');
  writeln('Нет - 2');
  Write('Выберите вариант: ');
  readln(v);
  vibor := v;
  writeln;
end;


function fun(var x: real): real;
begin
  var fo: real;
  fo := 2 * power(x, 3) + power(x, 2) + (-4) * x + 15;
  fun := fo;
end;


function fun1(var x: real): real;
begin
  var fo: real;
  fo := 1 / 2 * power(x, 4) + 1 / 3 * power(x, 3) - 2 * power(x, 2) + 15 * x;
  fun1 := fo;
  
end;


function graph(var s1, s2: real): integer;
var
  x, mx, my: real;
  a, b, x0, y0, i: integer;

begin
  MaximizeWindow;
  clearwindow;
  setpencolor(clblack);
  a := -5;  
  b := 100;  
  x0 := windowwidth div 2;  
  y0 := windowheight div 2;
  mx := m1;
  my := m2;
  line(0, y0, windowwidth, y0);
  line(x0, 0, x0, windowheight);
  for i := 1 to b do
  begin
    line(x0 + round(i * mx), y0 - 3, x0 + round(i * mx), y0 + 3); 
    line(x0 - round(i * mx), y0 - 3, x0 - round(i * mx), y0 + 3); 
    line(x0 - 3, y0 + round(i * my), x0 + 3, y0 + round(i * my)); 
    line(x0 - 3, y0 - round(i * my), x0 + 3, y0 - round(i * my));
    textout(x0 + round(i * mx), y0 + 10, inttostr(i));
    textout(x0 - round(i * mx), y0 + 5, inttostr(-i));
    textout(x0 - 25, y0 - round(i * my), inttostr(i));
    textout(x0 - 20, y0 + round(i * my), inttostr(-i));
  end;
  textout(x0 + 5, y0 + 10, '0');
  textout(windowwidth - 10, y0 - 15, 'X');
  textout(x0 + 5, 10, 'Y');
  x := a;
  setpencolor(clgreen);
  line(x0 + round(s1 * mx), 0, x0 + round(s1 * mx), windowheight);
  setpencolor(clgreen);
  line(x0 + round(s2 * mx), 0, x0 + round(s2 * mx), windowheight);
  var l, w, k, e: real;
  l := round((x0 + round(s2 * mx) - x0 - round(s1 * mx)) / n);
  k := l;
  w := 0;
  x := a;
  while x <= b do
  begin
    if (x0 + round(s1 * mx)) = (x0 + round(x * mx)) then
    begin
      if y0 - round(fun(x) * my) < y0 then
      begin
        setpencolor(clblue);
        Rectangle(x0 + round(s1 * mx), y0 - round(fun(x) * my), x0 + round(s1 * mx + l), y0);
      end;
    end;
    if (x0 + round(s1 * mx + l)) = (x0 + round(x * mx)) then
    begin
      if y0 - round(fun(x) * my) < y0 then
      begin
        setpencolor(clblue);
        for var v :=  x0 + round(s1 * mx - l) to x0 + round(s2 * mx) do
          Rectangle(x0 + round(s1 * mx + l), y0 - round(fun(x) * my), x0 + round(s1 * mx + (k + l)), y0);
      end;
      l := l + k;
      w := w + 1;
      if (w + 1) = n then
        break;
    end;
    x := x + 0.001;
  end;
  x := a;
  while x <= b do
  begin
    setpixel(x0 + round(x * mx), y0 - round(fun(x) * my), clred);
    x := x + 0.001;
  end;
end;


function graphDOP(var s1, s2: real): integer;
var
  con: integer;
  s: string;
begin
  con := 0;
  
end;


function predel: integer;
begin
  var a, b, h, f, x, S, pog: real;
  var ss: string;
  clearwindow;
  textout(10, 10, 'Вычисление площади фигуры, ограниченной кривой 2*x^3+x^2+(-4)*x+15 и осью Ох (в положительной части по оси Оу)');
  textout(10, 30, 'Введите пределы интегрирования:');
  readln(a, b);
  ss := a + ' ' + b;
  textout(230, 30, ss);
  textout(10, 50, 'Количество интервалов разбиения:');
  readln(n);
  textout(235, 50, n);
  h := (b - a) / n;
  x := a;
  m1 := 20;
  m2 := 20;
  for var i := 0 to n do
  begin
    f := fun(x);
    S := S + f;
    x := x + h;
  end;
  m1 := 20;
  m2 := 20;
  S := S * h;
  S := Round(S * 1000) / 1000;
  ss := 'Ответ ' + S;
  textout(10, 70, ss);
  textout(10, 90, 'Вывести погрешность?');
  textout(10, 110, '1 - Да');
  textout(10, 130, '2 - Нет');
  read(vvod);
  case vvod of
    1:
      begin
        pog := abs((fun1(b) - fun1(a)) - S);
        pog := Round(pog * 1000) / 1000;
        ss := 'Погрешность = ' + pog;
        textout(10, 150, ss);
        textout(10, 170, 'Нажмите enter чтоб продолжить');
        readln();
        readln;
      end;
    0:
      begin
        textout(10, 150, 'Нажмите enter чтоб продолжить');
        readln();
        readln;
      end;
  end;
  graph(a, b);
  graphDOP(a, b);
  textout(10, 10, 'Начать заново?');
  textout(10, 30, '1 - Да');
  textout(10, 50, '2 - Нет');
  read(vvod);
  case vvod of
    1: predel;
    0: exit();
  end;
  predel := 0;
end;


begin 
  MaximizeWindow;
  Writeln('Вычисление площади фигуры, ограниченной кривой 2*x^3+x^2+(-4)*x+15 и осью Ох (в положительной части по оси Оу)');
  Writeln('Ввести пределы интегрирования в ручную?');
  vvod := vibor(vvod);
  case vvod of
    1: predel;
  end;
end.