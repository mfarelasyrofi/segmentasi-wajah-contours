% Membaca gambar
image = imread('farel.jpg');

% Membuat detektor wajah
faceDetector = vision.CascadeObjectDetector();

% Mendeteksi wajah dalam gambar
bbox = step(faceDetector, image);

% Menampilkan gambar dengan kotak pembatas wajah yang terdeteksi
figure;
imshow(image);
hold on;
for i = 1:size(bbox, 1)
    rectangle('Position', bbox(i, :), 'EdgeColor', 'g', 'LineWidth', 2);
end
title('Deteksi Wajah menggunakan Viola-Jones');

% Mengambil area wajah sebagai region of interest (ROI)
if ~isempty(bbox)
    face = imcrop(image, bbox(1, :));
    
    % Konversi ROI ke grayscale
    grayFace = rgb2gray(face);
    
    % Contouring pada area wajah
    bw = edge(grayFace, 'Canny');
    [B, L] = bwboundaries(bw, 'noholes');
    
    % Menampilkan hasil segmentasi wajah dengan contours
    figure;
    imshow(grayFace);
    hold on;
    for k = 1:length(B)
        boundary = B{k};
        plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
    end
    title('Segmentasi Wajah menggunakan Contours');
    hold off;
end
