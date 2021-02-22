function listDownload(outputDirectoryName)
    list=textread('urllist.txt','%s');
    OUTDIR=outputDirectoryName;
    mkdir(OUTDIR);
    for i=1:size(list,1)
      fname=strcat(OUTDIR,'/',num2str(i,'%04d'),'.jpg')
      websave(fname,list{i});
    end
end