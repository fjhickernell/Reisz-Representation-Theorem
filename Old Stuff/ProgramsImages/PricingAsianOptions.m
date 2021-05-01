%% Pricing Asian Style Options
% As introduced in |IntroGAILOptionPricing|, GAIL has classes that define
% various types of option payoffs for different models of asset price
% paths. In this MATLAB script we show how to use these classes for Monte
% Carlo option pricing of options with Asian style payoffs and European
% exercise.
% 
% * The payoff depends on the whole asset price path, not only on the
% terminal asset price.
% * The option is only exercised at expiry, unlike American options,
% which can be exercised at any time before expiry.

%% Initialization
% First we set up the basic common praramters for our examples.

function PricingAsianOptions %make it a function to avoid variable conflicts
gail.InitializeDisplay %initialize the workspace and the display parameters
inp.timeDim.timeVector = 1/64:1/64:1; %weekly monitoring for three months
inp.assetParam.initPrice = 30; %initial stock price
inp.assetParam.interest = 0.05; %risk-free interest rate
inp.assetParam.volatility = 0.5; %volatility
inp.payoffParam.strike = 30; %strike price
inp.priceParam.absTol = 0.01; %absolute tolerance of a nickel
inp.priceParam.relTol = 0; %zero relative tolerance
EuroCall = optPrice(inp) %construct an optPrice object 

%%
% Note that the default is a European call option.  Its exact price is
% coded in

disp(['The price of this European call option is $' num2str(EuroCall.exactPrice)])

%% Arithmetic Mean Options
% The payoff of the arithmetic mean option depends on the average of the
% stock price, not the final stock price.  Here are the discounted payoffs:
%

%%
% To construct price this option, we construct an |optPrice| object with
% the correct properties.  First we make a copy of our original |optPrice|
% object.  Then we change the properties that we need to change.

ArithMeanCall = optPrice(EuroCall); %make a copy
ArithMeanCall.payoffParam.optType = {'amean'} %change from European to Asian arithmetic mean

%%
% Next we generate the price using the |genOptPrice| method of the |optPrice|
% object. 

[ArithMeanCallPrice,out] = genOptPrice(ArithMeanCall); %uses meanMC_g to compute the price
disp(['The price of this Asian arithmetic mean call option is $' num2str(ArithMeanCallPrice) ...
   ' +/- $' num2str(max(ArithMeanCall.priceParam.absTol, ...
   ArithMeanCall.priceParam.relTol*ArithMeanCallPrice)) ])
disp(['   and it took ' num2str(out.time) ' seconds and ' ...
   num2str(out.nPaths) ' paths to compute']) %display results nicely

%% Next we try Sobol' sampling and see a big speed up:

AMeanCallSobol = optPrice(ArithMeanCall); %make a copy of the IID optPrice object
AMeanCallSobol.priceParam.cubMethod = 'Sobol' %change to Sobol sampling
[AMeanCallSobolPrice,AoutSobol] = genOptPrice(AMeanCallSobol);
fprintf(['The price of the Asian geometric mean call option using Sobol'' ' ...
   'sampling is\n   $%3.3f +/- $%2.3f and this took %10.0f paths and %3.6f seconds,\n' ...
   'which is only %1.5f the time required by IID sampling\n'], ...
   AMeanCallSobolPrice,AMeanCallSobol.priceParam.absTol,AoutSobol.nPaths, ...
   AoutSobol.time,AoutSobol.time/out.time)

%%
% For a greater speed up, we may use
% the PCA construction, which reduces the effective dimension of the
% problem.

AMeanCallSobol.bmParam.assembleType = 'PCA'; %change to a PCA construction
[AMeanCallSobolPrice,AoutSobol] = genOptPrice(AMeanCallSobol);
fprintf(['The price of the Asian geometric mean call option using Sobol'' ' ...
   'sampling and PCA is\n   $%3.3f +/- $%2.3f and this took %10.0f paths and %3.6f seconds,\n' ...
   'which is only %1.5f the time required by IID sampling\n'], ...
   AMeanCallSobolPrice,AMeanCallSobol.priceParam.absTol,AoutSobol.nPaths, ...
   AoutSobol.time,AoutSobol.time/out.time)

%% 
% Another option is to use lattice sampling.

AMeanCallLattice = optPrice(AMeanCallSobol); %make a copy of the IID optPrice object
AMeanCallLattice.priceParam.cubMethod = 'lattice' %change to lattice sampling
[AMeanCallLatticePrice,AoutLattice] = genOptPrice(AMeanCallLattice);
fprintf(['The price of the Asian geometric mean call option using lattice ' ...
   'sampling is\n   $%3.3f +/- $%2.3f and this took %10.0f paths and %3.6f seconds,\n' ...
   'which is only %1.5f the time required by IID sampling\n'], ...
   AMeanCallLatticePrice,AMeanCallLattice.priceParam.absTol,AoutLattice.nPaths, ...
   AoutLattice.time,AoutLattice.time/out.time)



%%
% _Author: Fred J. Hickernell_
