pncTable = readmatrix('pncTable.xlsx', Sheet='Sheet1', Range='A1:J12');
nc = [31.5 63 125 250 500 1000 2000 4000 8000];
% spl = [55 46 43 37 40 65 30 28 24];
spl = [80 77 74 71 68 65 62 59 59];
pnc = calPnc(spl, nc, pncTable);