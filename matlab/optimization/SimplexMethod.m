function [x_min, z_min, A, b, base] = SimplexMethod(c, A, b, base)
[m, n] = size(A);
if nargin < 4
    % δ�ṩ�������н⣬���ö��׶η�Ѱ�һ������н⡣
    [~, ~, A, b, base] = SimplexMethod([zeros(n, 1); ones(m, 1)], [A, eye(m)], b, (n + 1 : n + m)');
    A = A(:, 1 : n);
end
B = eye(m);
for i = 1 : 100
    cB = zeros(m, 1);
    for j = 1 : m
        cB(j) = c(base(j));
    end
    % �ж��Ƿ���ö�ż�����η�
    isDual = 0;
    for j = 1 : m
        if b(j) < 0
            isDual = 1;
            break;
        end
    end
    if isDual
        % Ѱ�����ʸ��
        out = -1;
        minB = 1e100;
        for j = 1 : m
            if b(j) < minB
                minB = b(j);
                out = j;
            end
        end
        % Ѱ�ҽ���ʸ��
        in = -1;
        minR = 1e100;
        w = (cB' * B)';
        for j = 1 : n
            if A(out, j) < 0
                z = w' * A(:, j);
                r = (z - c(j)) / A(out, j);
                if r < minR
                    minR = r;
                    in = j;
                end
            end
        end
    else
        % Ѱ�ҽ���ʸ��
        in = -1;
        minR = 1e100;
        for j = 1 : n
            y = A(:, j);
            z = cB' * y;
            r = c(j) - z;
            R(j) = j;
            if r < minR
                minR = r;
                in = j;
            end
        end
        % ������������0�������˳�ѭ��
        if minR >= 0.0
            break;
        end
        % Ѱ�����ʸ��
        out = -1;
        minY = 1e100;
        for j = 1 : m
            if A(j, in) > 0
                y = b(j) / A(j, in);
                if y < minY
                    minY = y;
                    out = j;
                end
            end
        end
    end
    % �任��
    E = eye(m);
    for j = 1 : m
        if out ~= j
            E(j, out) = -A(j, in) / A(out, in);
        end
    end
    E(out, out) = 1.0 / A(out, in);
    B = E * B;
    % ת�������α�
    scale = A(out, in);
    for j = 1 : n
        A(out, j) = A(out, j) / scale;
    end
    b(out) = b(out) / scale;
    for j = 1 : m
        if j ~= out
            scale = A(j, in);
            for k = 1 : n
                A(j, k) = A(j, k) - scale * A(out, k);
            end
            b(j) = b(j) - scale * b(out);
        end
    end
    base(out) = in;
end
x_min = zeros(n, 1);
for i = 1 : m
    x_min(base(i)) = b(i);
end
z_min = c' * x_min;