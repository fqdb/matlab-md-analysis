function C = read_poscar()

C = readtable('POSCAR.csv');
C=C(:,1:3);
C = C{:,:};
for i = 1:3
    C(:,i) = C(1+i,i)*C(:,i);
end
C = C(8:end,:);
