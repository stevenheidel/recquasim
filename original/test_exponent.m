function eT = test_exponent(T, iter)

eT = 1;
next = 1;
for n = 1:iter
    next = next*T/n;
    eT = eT + next;
end