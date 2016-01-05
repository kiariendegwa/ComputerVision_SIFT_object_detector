img  = imread('image031.jpg');
img2  = imread('image061.jpg');
img1  = imread('image064.jpg');

figure
image1 = rgb2gray(img1);
image2 = 1-1*im2bw(image1, 0.5);
image = image1-im2uint8(image2);
subplot(2, 1, 1), imshow(image), title('fixed')
subplot(2, 1,2), imshow(image1), title('original')