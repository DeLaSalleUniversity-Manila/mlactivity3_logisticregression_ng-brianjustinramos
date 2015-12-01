%LAB03
%Graph of Hypothesis function usng logistic regression
for z = -10:0.01:10
    y = 1/(1+(2.718^-z));
    hold on
    plot(z,y,'r')
end
%Resulting plot is a sigmund
