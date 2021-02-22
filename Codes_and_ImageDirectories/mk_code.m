function code=mk_code(codebook, tlist)

  k=size(codebook,1);
  dim=size(codebook,2);
 
  code=[];
 
  for i=1:length(tlist)
    c=zeros(k,1);
    I=rgb2gray(tlist{i});
    %pnt=detectSURFFeatures(I);
    pnt=createRandomPoints(I,1000);
    [fea,vpnt] = extractFeatures(I,pnt);
 
    for j=1:size(fea,1)
      s=zeros(1,k);
      for t=1:dim
        %fprintf("(%d %d %d,%d) ", j, t, height(fea),width(fea));
        s=s+(codebook(:,t)-fea(j,t)).^2;
      end
      [dist,sidx]=min(s);
      c(sidx,1)=c(sidx,1)+1.0;
    end
    c=c/sum(c);
    code=[code c];
  end
end