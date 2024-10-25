% Parámetros
size = 500;  % Tamaño del vector
point_size = 0.2;  % Tamaño de los puntos en la gráfica
q = 3;
b = 0.5;
alpha = 0.8;
c = 1;

% Crear un vector de números consecutivos
numeros = 1:size;
lambda = 2;

% Calcular la función v_n
v_n =sqrt(2.*(1-alpha).*log(numeros));


% Parámetro de la distribución exponencial


% Número de iteraciones (valor máximo de n)
n_max = size;

% Inicializar variables para la simulación de máximos exponenciales
X = [];            % Vector para almacenar las variables aleatorias
max_vals = zeros(1, n_max);  % Vector para almacenar los máximos

% Generar las variables una por una y calcular el máximo en cada paso
for n = 1:n_max
    new_val = randn(1);  % Generar una nueva variable aleatoria exponencial
    X = [X, new_val]; 
    
    
    % Agregarla a la secuencia
    
    % Calcular el máximo actual
    max_vals(n) = max(X);
end




% Graficar los valores en una sola figura
figure;
hold on;  % Permite superponer las gráficas

% Graficar los valores de los máximos de la secuencia exponencial

h1=plot(numeros, max_vals, 'o-', 'Color', 'r', 'MarkerSize', point_size, 'DisplayName', 'M_n'); 
h2=plot(numeros, v_n, 'o-', 'Color', 'k', 'MarkerSize', point_size,'DisplayName', 'v_n','LineWidth',1.1);

% Graficar los valores de la secuencia de variables aleatorias exponenciales

% Graficar los valores de v_n
plot(numeros, X, 'o-', 'Color', [0.3 0.7 1], 'MarkerSize', point_size.*10,'LineWidth',0.2);

legend([h1 h2 ],{'M_n','c_n'})




% Personalización de la gráfica
xlabel('n');
ylabel('');
title('');
legend
xlim([0 size]);  % Limitar el eje x
grid on;
hold off;


% Parámetros iniciales (vector y u_1 ya generados previamente)

% Calcular cuántas veces vector - u_1 < 0
diferencias = max_vals - v_n;
condicion = diferencias < 0;

% Contar cuántas veces se cumple la condición
num_veces = sum(condicion);

% Mostrar el resultado
fprintf('El número de veces donde vector - u_1 es menor que 0 es: %d\n', num_veces);

% Definimos el vector
v= diferencias ;



% Encontramos las posiciones donde el valor es menor que cero
indices = find(v <0);

% Obtenemos la última posición
if ~isempty(indices)
    ultima_posicion = indices(end);
    fprintf('La última posición con valor menor que cero es: %d\n', ultima_posicion);
else
    fprintf('No hay elementos menores que cero en el vector.\n');
end
