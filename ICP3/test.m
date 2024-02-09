%ICP3
%ICP3
%BIOE 240


ctB = 0; %  B 
ctC = 0; %  C
ctD = 0; %  D
ctF = 0; %f
%scores [ ] = grades (s);


function myfunction 
i = 1 ; 
count = 0;
while i <= 5

%s = scores(i); 
   if (s >= 90) 
       ctA = ctA + 1; 
   end 
   if (s >= 80 && s<= 89) 
       ctB = ctB + 1;
   end
   if (s >= 70 && s<= 79) 
       ctC = ctC + 1;
   end
   if (s >= 60 && s<= 69) 
       ctD = ctD + 1;
   end
   if (s < 60 )
       ctF = ctF +1;
   end
   i = i + 1  

end
end






