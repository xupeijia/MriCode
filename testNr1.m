nrTable = readmatrix('nrTable.xlsx', Sheet='Sheet1', Range='A1:J14');
nc = [31.5 63 125 250 500 1000 2000 4000 8000];
spl = [75 68 65 58 50 45 44 35 24];
nr1 = calNr1(spl, nc, nrTable);

nr2 = calNr2(spl, nc);
