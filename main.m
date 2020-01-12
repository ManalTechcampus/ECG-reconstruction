
%% SIGNAL RECONSTRUCION.

% Description:
% The last 30s of the target signal xT will be reconstructed using
% two reference signals; x1 and x2. Size are
%
%   xT: 71250x1 vector. (missing 3750 will be reconstructed).
%   x1: 75000x1 vector.
%   x2: 75000x1 vector.
%
% Assumming that the target signal is a linear combination of x1 and x2.
%
%           N                     M
%          ===                   ===
%          \                     \
% xT[n] =  /    a_i * x1[n-i] +  /    b_i * x2[n-i]         (*)
%          ===                   ===
%          i = 0                 i = 0
%
% Algorithm used is:
% step 1: Using the frst 9.5 minutes of xT[n], x1[n], x2[n],
%         train the RLS filter and estimate the coefficients ai and bi.
%         Methods used for this steps are: RLS and ADAM optimizer.
%
% step 2: Estimate the last 0.5 minute (125*30 samples) using equation (*)
%         and the coefficients computed in step 1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% METHOD 1: RLS ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Importing filters and custom functions files.
addpath('filters', 'functions');

p = 1;          % Patient number
M = 70;         % Filter tap for x1
N = 100;        % Filter tap for x2
lambda = 0.99;  % Forgetting factor

% Loading patient data.
p = getpatient(p);

% Filter coefficients. 'zm' indicates signals with substracted mean.
ci = customRLS(p.xTzm, lambda, p.x1zm, M, p.x2zm, N);

% Reconstructing the last 30 secs (125*30 = 3750 samples)
xhat = getReconstruction(ci, p.x1zm, M, p.x2zm, N) + p.xTmean;

% Performaance analysis. xTm is the true missing part of xT.
[Q1, Q2] = getPerformance(p.xTm, xhat);

% Pltting comparision of reconstruction xhat and true missing singal xm.
plotResults(p.xTm, xhat, Q1, Q2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% METHOD 2: ADAM optimizer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Importing filters and custom functions files.
addpath('filters', 'functions');

p = 1;      % Patient number
M = 10;     % Filter tap for x1
N = 48;    % Filter tap for x2

% Loading patient data.
p = getpatient(p);

% Filter coefficients. 'zm' indicates signals with substracted mean.
ci = customADAM(p.xTzm, p.x1zm, M, p.x2zm, N);

% Reconstructing the last 30 secs (125*30 = 3750 samples)
xhat = getReconstruction(ci, p.x1zm, M, p.x2zm, N) + p.xTmean;

% Performaance analysis. xTm is the true missing part of xT.
[Q1, Q2] = getPerformance(p.xTm, xhat);

% Pltting comparision of reconstruction xhat and true missing singal xm.
plotResults(p.xTm, xhat, Q1, Q2);



%% LOOP 1: SWEEP FOR INDIVIDUAL X1 and X2
close all; clear all; clc;
addpath('filters', 'functions');

p = getpatient(1);

iters = 400;
Nvect = zeros(iters,1);
Mvect = zeros(iters,1);
Q1v = zeros(iters, 1); % N, M and Q1
Q2v = zeros(iters, 1); % N, M and Q2


i = 1;
for n = 1:200
    for m = 1:200
        ci = customADAM(p.xTzm, p.x1zm, m, p.x2zm, n);
        xhat = getReconstruction(ci, p.x1zm, m, p.x2zm, n) + p.xTmean;
        [Q1, Q2] = getPerformance(p.xTm, xhat);
        
        Nvect(i) = n;
        Mvect(i) = m;
        Q1v(i) = Q1;
        Q2v(i) = Q2;
        
        i = i + 1;
        disp(['N: ', num2str(n), ' M: ', num2str(m)]);

    end
end

%%
close all;



q = Qsweep1(:,4);
x1 = Qsweep1(:,1);
x2 = Qsweep1(:,2);

ii = find(abs(q-1) <= 0.02);

disp(q(ii))
%plot(x1(ii), q(ii));
plot(x2(ii), q(ii),'*');

n = unique(x1(ii));
m = unique(x2(ii));

%% Method 2: Kalman filter (Uncompleted)


% The target signal xT is defined as
%
% xT[n] = { xT[n-L], for 0 <= n <= L,       (*)
%         {  0       otherwise
%
% where L is the length of the missing part (125*30 = 3750 in this case).

close all; clear all; clc;
% importing filter and custom functions.
addpath('filters', 'functions');

% Loading data.
p2 = getpatient(2);

% Extendind xT as defined in (*)
xTzm_ext = vertcat(p2.xT, zeros(125*30, 1));

% Kalman filter
[xhat, F] = customKF(xTzm_ext, x2zm, 106);

plot(xhat(1,:));


% Signal modelling
close all;
p = 10000;
[ai, w] = aryule(p2.xT,p-1);

F = vertcat(ai, eye(p-1, p));
plot(F*p2.xT(1:p))
hold on; plot([0;p2.xT(1:p)], '--')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PRE PROCESSING DATA. FOR REPPORT.
close all;
% last 32s for xT, x1 and x2 for patient 2.
p = getpatient(2);
Fs = 125; % sampling freq.
t = (1:length(p.x1))/Fs;

tlim = [565 575];    
lastsecs = 35;
figure(1); pp1 = Plot(t,[p.xT; zeros(125*30,1)]); xlim(tlim)
figure(2); pp2 = Plot(t,p.x1); xlim(tlim)
figure(3); pp3 = Plot(t,p.x2); xlim(tlim)

for pp = [pp1,pp2,pp3]
    pp.BoxDim = [7.16,3];
pp.LineWidth = 2;
pp.XLabel = 'Time [s]';
pp.YLabel = 'Voltage [mV]';

end

