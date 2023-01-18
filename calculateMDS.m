function MDS = calculateMDS(BW,NF)
    MDS = -174 + 10 * log10(BW)  +NF;
end