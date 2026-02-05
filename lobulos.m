clc 
clear all
close all

% Parámetros
asimut = linspace(-90, 90, 200);
elevacion = linspace(-90, 90, 200);
[Asimut, Elevacion] = meshgrid(asimut, elevacion);

% Función sinc 2D
sinc_2d = @(asimut, elevacion, asimut0, elevacion0) sinc((asimut - asimut0)/20) .* sinc((elevacion - elevacion0)/20);

% Lóbulos
lobulo_A = sinc_2d(Asimut, Elevacion,  20,  20);
lobulo_B = sinc_2d(Asimut, Elevacion, -20,  20);
lobulo_C = sinc_2d(Asimut, Elevacion,  20, -20);
lobulo_D = sinc_2d(Asimut, Elevacion, -20, -20); 

% Crear mapa de colores multicolor (azul -> cyan -> amarillo -> naranja -> rojo)
n = 256;
cmap_multicolor = [
    linspace(0, 0, n/4)'      linspace(0, 1, n/4)'      linspace(1, 1, n/4)';      % Azul a Cyan
    linspace(0, 1, n/4)'      linspace(1, 1, n/4)'      linspace(1, 0, n/4)';      % Cyan a Amarillo
    linspace(1, 1, n/4)'      linspace(1, 0.5, n/4)'    linspace(0, 0, n/4)';      % Amarillo a Naranja
    linspace(1, 1, n/4)'      linspace(0.5, 0, n/4)'    linspace(0, 0, n/4)'       % Naranja a Rojo
];

% ========== FIGURA 1: Lóbulos individuales (2x2) ==========
figure('Name', 'Lobulos Individuales', 'Position', [50 50 1200 900], 'Color', 'w');

subplot(2,2,1); 
surf(Asimut, Elevacion, lobulo_A, 'EdgeColor', 'none', 'FaceAlpha', 0.95);
title('Lobulo A', 'FontSize', 12, 'FontWeight', 'bold'); 
xlabel('Asimut'); ylabel('Elevacion'); zlabel('Amplitud');
colormap(gca, cmap_multicolor); 
view(45, 30); 
grid on; 
axis tight;
lighting gouraud; 
camlight('headlight');
colorbar;

subplot(2,2,2); 
surf(Asimut, Elevacion, lobulo_B, 'EdgeColor', 'none', 'FaceAlpha', 0.95);
title('Lobulo B', 'FontSize', 12, 'FontWeight', 'bold'); 
xlabel('Asimut'); ylabel('Elevacion'); zlabel('Amplitud');
colormap(gca, cmap_multicolor); 
view(45, 30); 
grid on; 
axis tight;
lighting gouraud; 
camlight('headlight');
colorbar;

subplot(2,2,3); 
surf(Asimut, Elevacion, lobulo_C, 'EdgeColor', 'none', 'FaceAlpha', 0.95);
title('Lobulo C', 'FontSize', 12, 'FontWeight', 'bold'); 
xlabel('Asimut'); ylabel('Elevacion'); zlabel('Amplitud');
colormap(gca, cmap_multicolor); 
view(45, 30); 
grid on; 
axis tight;
lighting gouraud; 
camlight('headlight');
colorbar;

subplot(2,2,4); 
surf(Asimut, Elevacion, lobulo_D, 'EdgeColor', 'none', 'FaceAlpha', 0.95);
title('Lobulo D', 'FontSize', 12, 'FontWeight', 'bold'); 
xlabel('Asimut'); ylabel('Elevacion'); zlabel('Amplitud');
colormap(gca, cmap_multicolor); 
view(45, 30); 
grid on; 
axis tight;
lighting gouraud; 
camlight('headlight');
colorbar;

% ========== FIGURA 2: Visualización 3D combinada de lóbulos ==========
figure('Name', 'Visualizacion 3D de Lobulos', 'Position', [100 100 900 700], 'Color', 'w');

surf(Asimut, Elevacion, lobulo_A, 'FaceAlpha', 0.7, 'EdgeColor','none'); 
hold on
surf(Asimut, Elevacion, lobulo_B, 'FaceAlpha', 0.7, 'EdgeColor','none');
surf(Asimut, Elevacion, lobulo_C, 'FaceAlpha', 0.7, 'EdgeColor','none');
surf(Asimut, Elevacion, lobulo_D, 'FaceAlpha', 0.7, 'EdgeColor','none');

xlabel('Asimut', 'FontSize', 11); 
ylabel('Elevacion', 'FontSize', 11); 
zlabel('Amplitud', 'FontSize', 11);
title('Visualizacion 3D de Lobulos', 'FontSize', 13, 'FontWeight', 'bold');
colormap(gca, cmap_multicolor);
view(45, 30);
grid on;
lighting gouraud; 
camlight('headlight');
colorbar;
hold off

% Visualización de canales en coordenadas esféricas
asimut_esfe = linspace(-pi/2, pi/2, 200);
elevacion_esfe = linspace(-pi/2, pi/2, 200);
[asimut_esfe, elevacion_esfe] = meshgrid(asimut_esfe, elevacion_esfe);

escala = 7;
dasimut_esfe = 0.1; 
delevacion_esfe = 0.1;

A = sinc(escala*(asimut_esfe-dasimut_esfe)/pi).*sinc(escala*(elevacion_esfe-delevacion_esfe)/pi);
B = sinc(escala*(asimut_esfe+dasimut_esfe)/pi).*sinc(escala*(elevacion_esfe-delevacion_esfe)/pi);
C = sinc(escala*(asimut_esfe-dasimut_esfe)/pi).*sinc(escala*(elevacion_esfe+delevacion_esfe)/pi);
D = sinc(escala*(asimut_esfe+dasimut_esfe)/pi).*sinc(escala*(elevacion_esfe+delevacion_esfe)/pi);

A = A/max(abs(A(:))); 
B = B/max(abs(B(:)));
C = C/max(abs(C(:)));
D = D/max(abs(D(:)));

sigma = abs(A+B+C+D);
asimut_delta = abs(A+B-C-D);
elevacion_delta = abs(A-B+C-D);
cruzado = abs(A-B-C+D);

sigma = sigma/max(abs(sigma(:)));
asimut_delta = asimut_delta/max(abs(asimut_delta(:)));
elevacion_delta = elevacion_delta/max(abs(elevacion_delta(:)));
cruzado = cruzado/max(abs(cruzado(:)));

X = cos(elevacion_esfe).*cos(asimut_esfe);
Y = cos(elevacion_esfe).*sin(asimut_esfe);
Z = sin(elevacion_esfe);

% ========== FIGURA 3: Canales Monopulso 3D ==========
figure('Name', 'Canales Monopulso 3D', 'Position', [50 50 1400 1000], 'Color', 'w');

subplot(2,2,1); 
surf(X .* sigma, Y .* sigma, Z .* sigma, sigma, 'EdgeColor', 'none', 'FaceAlpha', 0.95);
title('Sigma', 'FontSize', 11); 
xlabel('x'); ylabel('y'); zlabel('z');
colormap(gca, cmap_multicolor); 
view(45, 30); 
grid on; 
axis equal;
set(gca, 'Color', [0.92 0.94 0.96]); 
lighting gouraud; 
camlight('headlight');

subplot(2,2,2); 
surf(X .* asimut_delta, Y .* asimut_delta, Z .* asimut_delta, asimut_delta, 'EdgeColor', 'none', 'FaceAlpha', 0.95);
title('Azimut', 'FontSize', 11); 
xlabel('x'); ylabel('y'); zlabel('z');
colormap(gca, cmap_multicolor); 
view(45, 30); 
grid on; 
axis equal;
set(gca, 'Color', [0.92 0.94 0.96]); 
lighting gouraud; 
camlight('headlight');

subplot(2,2,3); 
surf(X .* elevacion_delta, Y .* elevacion_delta, Z .* elevacion_delta, elevacion_delta, 'EdgeColor', 'none', 'FaceAlpha', 0.95);
title('Elevacion', 'FontSize', 11); 
xlabel('x'); ylabel('y'); zlabel('z');
colormap(gca, cmap_multicolor); 
view(45, 30); 
grid on; 
axis equal;
set(gca, 'Color', [0.92 0.94 0.96]); 
lighting gouraud; 
camlight('headlight');

subplot(2,2,4); 
surf(X .* cruzado, Y .* cruzado, Z .* cruzado, cruzado, 'EdgeColor', 'none', 'FaceAlpha', 0.95);
title('Cruzado', 'FontSize', 11); 
xlabel('x'); ylabel('y'); zlabel('z');
colormap(gca, cmap_multicolor); 
view(45, 30); 
grid on; 
axis equal;
set(gca, 'Color', [0.92 0.94 0.96]); 
lighting gouraud; 
camlight('headlight');