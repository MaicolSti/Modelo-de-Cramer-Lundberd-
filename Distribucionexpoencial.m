% Parámetros
size = 400;  % Tamaño del vector
point_size = 0.2;  % Tamaño de los puntos en la gráfica
q = 2;
b = 0.9;
alpha = 0.1;
c = 1;

% Crear un vector de números consecutivos
numeros = 1:size;
lambda = 2;

% Calcular la función v_n
v_n =  (1./lambda).*log(numeros)+(1./lambda).*log((numeros.^q)./c);
u_1 = (1./lambda).*log(numeros);

% Parámetro de la distribución exponencial


% Número de iteraciones (valor máximo de n)
n_max = size;

% Inicializar variables para la simulación de máximos exponenciales
X = [];            % Vector para almacenar las variables aleatorias
max_vals = zeros(1, n_max);  % Vector para almacenar los máximos

% Generar las variables una por una y calcular el máximo en cada paso
for n = 1:n_max
    new_val = exprnd(1./lambda);  % Generar una nueva variable aleatoria exponencial
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
h3=plot(numeros, u_1, 'o-', 'Color', 'b', 'MarkerSize', point_size,'DisplayName', 'v_n');

% Graficar los valores de la secuencia de variables aleatorias exponenciales

% Graficar los valores de v_n
plot(numeros, X, 'o-', 'Color', [0.3 0.7 1], 'MarkerSize', point_size.*10,'LineWidth',0.2);

legend([h1 h2 h3],{'M_n','log(n)/s+v_n','log(n)/s'})




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
condicion = diferencias > 0;

% Contar cuántas veces se cumple la condición
num_veces = sum(condicion);

% Mostrar el resultado
fprintf('El número de veces donde vector - u_1 es menor que 0 es: %d\n', num_veces);

% Definimos el vector
v= diferencias ;



% Encontramos las posiciones donde el valor es menor que cero
indices = find(v >0);

% Obtenemos la última posición
if ~isempty(indices)
    ultima_posicion = indices(end);
    fprintf('La última posición con valor menor que cero es: %d\n', ultima_posicion);
else
    fprintf('No hay elementos menores que cero en el vector.\n');
end
