for i = 1:T+1
    for j = 1:N
        if OBJ{i}(j,:) == single_gbestobj
            fprintf('��������ΪCOEF{%5.0f}(%4.0f)',i,j);
        end
    end
end

for i = 1:T+1
    for j = 1:N
        if sum(OBJ{i}(j,:)) == sum(REF)
            fprintf('��������ΪCOEF{%5.0f}(%4.0f)',i,j);
        end
    end
end