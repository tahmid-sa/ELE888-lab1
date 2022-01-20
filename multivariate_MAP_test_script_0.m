%%given a random sample data set, 
%%determinine the posterior probability matrix 
x = [1 2;102 1; 0.125 0.1]; 
fprintf("The x matrix:\n"); 
disp(x); 
[r,c] = size(x); 
fprintf("r:\n"); 
disp(r); 
fprintf("c\n"); 
disp(c); 
fprintf("mean:\n"); 
mu = mean(x,'all'); 
disp(mu); 
sigma = mean((x-mu)'*(x-mu),'all'); %covariance of x matrix 
fprintf("sigma:\n"); 
disp(sigma); 
sigma_det = det(sigma); 
fprintf("|sigma|:\n"); 
disp(sigma_det); 
sigma_sqrt = sqrt(sigma_det); 
fprintf("sqrt(sigma):\n"); 
disp(sigma_sqrt); 
fprintf("sigma^(-1):\n"); 
sigma_inv = inv(sigma); 
disp(sigma_inv); 
d = c; %check if this is suppose to be row or column (r or c parameter) 
fprintf("d:\n"); 
disp(d); 
d_half = d/2;
fprintf("1/2*d:\n"); 
disp(d_half); 
x_mu = x-mu; 
x_mu_t = x_mu'; 
posterior_x = ((2*pi).^d_half.*sigma_sqrt).^(-1).*exp(-0.5.*x_mu_t*sigma_inv*x_mu); 
fprintf("p(x):\n"); 
disp(posterior_x); 




