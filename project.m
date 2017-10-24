% github.com/jonesc10/2ellipses-and-beyond

% How many points for each curve:
POINTS = 20000;
% Starting radii of 2 concentric  circles:
A = 7;
B = 10;
% How deep do you want to go?
ITERATIONS = 2;
% Generate theta values in radians
thetas = linspace(0, pi/2, POINTS)';

% Generate initial points
ellipse1 = ellipse(A,B);
ellipse2 = ellipse(B,A);
Axys = zeros(POINTS,2);
Bxys = zeros(POINTS,2);
for i = 1:POINTS
    E1(i,:) = ellipse1(thetas(i));
    E2(i,:) = ellipse2(thetas(i));
end
% Done with initial point generation

[X1,Y1,X2,Y2] = generatePoints(E1,E2);


hold on;
pbaspect([1 1 1]);
% plot(E1(:,1),E1(:,2));
% plot(E2(:,1),E2(:,2));

plot(X1,Y1);
plot(X2,Y2);


function [X1,Y1,X2,Y2] = generatePoints(Axys,Bxys)
    curA = 1;
    curB = 1;
    curI = 1;
    [N,M] = size(Axys);
    newA = zeros(N,2);
    newB = zeros(N,2);
    while curA <= N & curB <= N-1
        C = (Axys(curA,2)/Axys(curA,1) - Bxys(curB,2)/Bxys(curB,1));
        C = C * (Axys(curA,2)/Axys(curA,1) - Bxys(curB+1,2)/Bxys(curB+1,1));
        if sign(C) <= 0
            newA(curI,:) = [Axys(curA,1),(Bxys(curB,2)+Bxys(curB+1,2))/2];
            newB(curI,:) = [(Bxys(curB,1)+Bxys(curB+1,1))/2,Axys(curA,2)];
            curA = curA + 1;
            curI = curI + 1;
        else
            curB = curB + 1;
        end
    end
    
    X1 = newA(:,1);
    Y1 = newA(:,2);
    X2 = newB(:,1);
    Y2 = newB(:,2);
end

function f = circle(R)
    f = @(theta) [R*cos(theta), R*sin(theta)];
end

function f = ellipse(A,B)
    f = @(theta) [A*cos(theta), B*sin(theta)];
end

