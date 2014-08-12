% Parameters

N = 6;

% Experiment

Hs = {};
Js = {};
count = 0;

total = 2 ^ (N * (N-1) / 2);
while count < total
    [H, J] = RandomIsing(N);

    % Search through the Hs
    found = 0;
    for k = 1:count
        if isequal(H, Hs{k})
            found = k;

            if !isequal(J, Js{k})
                error('Not bijective');
            end

            break;
        end
    end

    if found == 0
        count = count + 1;
        Hs{count} = H;
        Js{count} = J;

        disp(sprintf('%i / %i', count, total));
    end

    fflush(stdout);
end

count