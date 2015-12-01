%LAB03

clear all; close all; clc
x = load('xNew.dat'); 
y = load('yNew.dat');
theta = zeros(3,1);

m = length(x);
x = [ones(m, 1), x];

pos = find(y==1);
neg = find(y ==0);

%Procedure 3.1
    plot(x(pos, 2), x(pos, 3), ('*'));
    hold on
    plot(x(neg,2), x(neg,3), 'o');
    xlabel('Exam 1 Score');
    ylabel('Exam 2 Score');
    title('Test Scores');
    legend('Admitted', 'Not Admitted');

    %z = theta\x;
    g = inline('1.0 ./ (1.0 + exp(-z))'); 

%Procedure 3.2
    iter = 7;
    J = zeros(iter, 1);
        for i = 1:iter
            z = x * theta;
            h = g(z);
            %Cost Function
            J(i) =(1/m)*sum(-y.*log(h) - (1-y).*log(1-h));
            %Newton's Law
                %Logistic Regression
                grad = (1/m).*x' * (h-y);
                %Hessian
                H = (1/m).*x' * diag(h) * diag(1-h) * x;
                %Update Rule
                theta = theta - H\grad; 
        end

        figure;
        plot(0:iter-1,J(1:iter),'r');
        xlabel('Iteration');
        ylabel('J');
        title('Number of Iterations');

        plot_x = [min(x(:,2))-2,  max(x(:,2))+2];
        plot_y = (-1./theta(3)).*(theta(2).*plot_x +theta(1));

        figure;
        plot(x(pos, 2), x(pos, 3), ('*'));
        hold on
        plot(x(neg,2), x(neg,3), 'o');
        xlabel('Exam 1 Score');
        ylabel('Exam 2 Score');
        title('Admitted or Not?');
        hold on;
        plot(plot_x, plot_y)
        legend('Admitted', 'Not admitted', 'Decision Boundary')
        hold off

        % Plot J
        figure
        plot(0:iter-1, J, 'o', 'MarkerFaceColor', 'g', 'MarkerSize', 9);
        xlabel('Iteration'); 
        ylabel('J');
        title('Number of Iteration Before Convergence');
    
    %Procedure 3.3
    %Theta
    theta
    Iterations = 5
    J
    probability_of_not_passing = 1 - g([1, 20, 80]*theta)
    probability_of_passing = 1 - g([2, 20, 80]*theta)
    %not admitted = 1, admitted = 2
    %exam 1 = 20, exam 2 = 80