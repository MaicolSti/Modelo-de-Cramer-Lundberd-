% Parámetros
size = 400;          % Tamaño del vector
point_size = 0.2;    % Tamaño de los puntos en la gráfica
alpha_param = 1;     % Parámetro alpha de la distribución Beta
beta_param = 5;      % Parámetro beta de la distribución Beta
b = 0.9;
alpha = 0.1;
c = 1;
lambda = 2;          % Parámetro lambda para las funciones v_n y u_1
n_max = size;        % Número máximo de iteracion58es
q=1.3;

% Crear un vector de números consecutivos
numeros = 1:size;

% Calcular la función v_n y u_1
v_n =  1-((c.*b.^(numeros.^(alpha)))./numeros).^(0.2)-0.02;


% Inicializar variables para la simulación de máximos Fréchet
X = zeros(1, size);           % Prealocar el vector para las variables aleatorias
max_vals_frechet = zeros(1, size);  % Prealocar el vector para almacenar los máximos

% Generar las variables una por una y calcular el máximo en cada paso
for n = 1:n_max
    new_val = betarnd(alpha_param, beta_param);  % Generar una nueva variable aleatoria Beta
    X(n) = new_val;                             % Agregarla al vector
    
    % Calcular el máximo actual
    max_vals_frechet(n) = max(X(1:n));
end

% Graficar los valores en una sola figura
figure;
hold on;  % Permite superponer las gráficas

% Graficar los valores de los máximos de la secuencia Fréchet
h1 = plot(numeros, max_vals_frechet, 'o-', 'Color', 'r', 'MarkerSize', point_size, 'DisplayName', 'M_n'); 

% Graficar los valores de la función v_n
h2 = plot(numeros, v_n, 'o-', 'Color', 'k', 'MarkerSize', point_size, 'DisplayName', 'v_n', 'LineWidth', 1.1);

% Graficar los valores de la función u_1


plot(numeros, X, 'o-', 'Color', [0.3 0.7 1], 'MarkerSize', point_size.*10,'LineWidth',0.2);

% Añadir la leyenda
legend([h1, h2], {'M_n', '1- n^{-1/s}v_n' });

% Personalización de la gráficaz
xlabel('');
ylabel('');
title('');
xlim([0 size]);  % Limitar el eje x
grid on;
hold off;

% Calcular cuántas veces max_vals_frechet - v_n > 0
diferencias = max_vals_frechet - v_n;
condicion = diferencias > 0;

% Contar cuántas veces se cumple la condición
num_veces = sum(condicion);

% Mostrar el resultado
fprintf('El número de veces donde max_vals_frechet - v_n es mayor que 0 es: %d\n', num_veces);

% Encontrar las posiciones donde max_vals_frechet - v_n > 0
indices = find(diferencias >0);

% Obtener la última posición donde la condición se cumple
if ~isempty(indices)
    ultima_posicion = indices(end);
    fprintf('La última posición con max_vals_frechet > v_n es: %d\n', ultima_posicion);
else
    fprintf('No hay elementos donde max_vals_frechet > v_n en el vector.\n');
end
