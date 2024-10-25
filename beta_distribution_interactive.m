
% Parámetros
alpha_param = 1;  % Parámetro alpha de la distribución Beta
alpha = 5;
beta_param = alpha;   % Parámetro beta de la distribución Beta
size = 1000;     % Tamaño de cada vector para mostrar en el rango de 1 a 100
point_size = 0.1; % Tamaño de los puntos en la gráfica
n = size;
q = 15;
b = 0.01;
a = 0.5;
c = 1;

% Crear un vector de números consecutivos
numeros = 1:size;

% Calcular el logaritmo de cada número
u_1  = sqrt(numeros)/50;

% Función para generar el vector Beta
function vector = vector_beta(n, alpha_param, beta_param)
    vector = zeros(1, n);  % Inicializar el vector
    for i = 2:n
        % Generar las variables aleatorias con distribución Beta
        variables_aleatorias = betarnd(alpha_param, beta_param, 1, n);
        % Calcular el máximo de las variables aleatorias hasta el índice i
        vector(i) = max(variables_aleatorias(1:i));
    end
end

% Generar el vector de máximos sucesivos con distribución Beta
vector = vector_beta(size, alpha_param, beta_param);

% Escalar los valores del eje x para tener una escala personalizada (100 en x = 1 en y)
x_values = 1:size;

% Gráfico comparativo de los vectores
figure('Position', [100, 100, 1200, 800]);

% Gráfico del vector de máximos sucesivos con escala ajustada en x
plot(x_values, vector, 'o-', 'Color', 'g', 'MarkerSize', point_size * 10, 'DisplayName', 'M_n');
hold on;

% Gráfico del logaritmo con escala ajustada en x
plot(x_values, u_1, '-b', 'DisplayName', 'v_n');

% Títulos y etiquetas
title('');

% Etiquetas de los ejes
xlabel('n');
ylabel('');

% Añadir leyenda
legend();

% Añadir cuadrícula con mayor transparencia
grid on;


% Mostrar el gráfico
hold off;
