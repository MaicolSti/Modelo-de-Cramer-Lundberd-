u = 20;  % Capital inicial
c = 1.5;  % Tasa de primas recibidas
lambda1 = 1; 
lambda2 = 1;  % Tasa que transcurre entre reclamaciones sucesivas (Exponencial)
N = 1000;  % Numero de reclamos 
point_size = 0.3;  % Tamaño de los puntos en la gráfica
q = 2;
b = 0.75;
alpha = 0.4;
a = 0.6;
Beta = 1;

% Simulación del proceso de reclamaciones (Exponencial)
Y = exprnd(1./lambda1, [1, N]);
X = exprnd(1./lambda2, [1, N]);


T = zeros(1, N);
T(1) = 0;
for i = 2:N
    T(i) = sum(Y(1:i-1));  % Sumar desde el primer elemento hasta el i-1
end

M1 = zeros(1, N);
M1(1) = 0;
for i = 2:N
    M1(i) = sum(X(1:i-1));  % Sumar desde el primer elemento hasta el i-1
end

M2 = zeros(1, N);
M2(1) = 0;
for i = 2:N
    M2(i) = sum(X(1:i));  % Sumar desde el primer elemento hasta el i
end

R = c * T;  % Capital generado por las primas
u1 = M1 - R;
u2 = M2 - R;

vector1 = u1;
vector2 = u2;

% Inicializar variables para almacenar el capital y su máximo
capital = [];
capital_max = [];

% Iterar sobre los índices de los vectores
for i = 1:length(vector1)
    % Agregar valores de ambos vectores
    capital = [capital, vector1(i), vector2(i)];
    % Almacenar el máximo acumulado
    capital_max(i) = max(capital(1:i));
end

% Definir u_1, u_2, u_3 como funciones de T
u_1 = -((c.*lambda1)./(c-lambda1.*lambda2)).*log(Beta.*b.^(T.^(alpha)) )-30;
u_2 = -((c.*lambda1) ./ (c - lambda2.*lambda1)) .* log(Beta.*b.^(T.^(alpha+0.1)) )-30;
u_3 = -((c.*lambda1) ./ (c - lambda2.*lambda1)) .* log(Beta.*b.^(T.^(alpha+0.2)))-30;
A = max(T);

% Graficar el capital en el tiempo, los máximos y u_1
figure;
hold on; % Para superponer las gráficas


% Graficar u_1, u_2 y u_3
h1=plot(T, u_1, '-r', 'DisplayName', 'u_1');
h2=plot(T, u_2, '-g', 'DisplayName', 'u_2');
h3=plot(T, u_3, '-k', 'DisplayName', 'u_3');

% Graficar el capital
plot(T, capital(1:length(T)), '-b', 'LineWidth', 1);  % Tomar cada dos valores para el capital
legend off;
h4=plot(T, capital_max, '-m', 'LineWidth', 1, 'DisplayName', 'M_n' );


legend([h1 h2 h3 h4],{'u_1','u_2','u_3','M_n' })
xlim([0 A]);
xlabel('Tiempo');
ylabel('');
title('');
grid on;
hold off;

% Contar cuántas veces el capital es menor que el capital inicial u
condicion_capital1 = u_1 - u1 < 0;
condicion_capital2 = u_1 - u2 < 0;
condicion_capital3 = u_2 - u1 < 0;
condicion_capital4 = u_2 - u2 < 0;
condicion_capital5 = u_3 - u1 < 0;
condicion_capital6 = u_3 - u2 < 0;

% Sumar cuántas veces el capital está por debajo de los umbrales
num_veces_debajo_u1 = sum(condicion_capital1) + sum(condicion_capital2);
num_veces_debajo_u2 = sum(condicion_capital3) + sum(condicion_capital4);
num_veces_debajo_u3 = sum(condicion_capital5) + sum(condicion_capital6);

disp(num_veces_debajo_u1);
disp(num_veces_debajo_u2);
disp(num_veces_debajo_u3);

% Encontrar las posiciones donde el valor es menor que cero
v1 = find(u_1 - u1 < 0);
v2 = find(u_1 - u2 < 0);
v3 = find(u_2 - u1 < 0);
v4 = find(u_2 - u2 < 0);
v5 = find(u_3 - u1 < 0);
v6 = find(u_3 - u2 < 0);

% Obtener la última posición donde ocurre
if ~isempty(v1)
    ultima_posicion = max([v1(end), v2(end)]);
    fprintf('La última posición con valor menor que cero (u_1): %d\n', ultima_posicion);
else
    fprintf('No hay elementos menores que cero en u_1.\n');
end

if ~isempty(v3)
    ultima_posicion = max([v3(end), v4(end)]);
    fprintf('La última posición con valor menor que cero (u_2): %d\n', ultima_posicion);
else
    fprintf('No hay elementos menores que cero en u_2.\n');
end

if ~isempty(v5)
    ultima_posicion = max([v5(end), v6(end)]);
    fprintf('La última posición con valor menor que cero (u_3): %d\n', ultima_posicion);
else
    fprintf('No hay elementos menores que cero en u_3.\n');
end
