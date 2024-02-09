%ICP2
%bioe240
%ICP2
clear all
hold on
t=0:0.3:10 ;
y = abs(t) ;
y = 2 .* t  ;
error = abs ( y - 11 ) ;
%find(error==min(t)
timepoint11 = t(find(min(error)==error)) 
a = [ 't' , 'error' , 'y' ];

plot(t,error);

title (' Distance vs. Time ' );
xlabel('Time');
ylabel('Distance');
savefig = plot(t ,error);
saveas(savefig, 'figtest.pdf');
saveas(savefig, 'figtest.jpg');

datasave =  [ 't' , 'error' , 'y' ];
fid =fopen('testfile2.txt', 'w');
fprintf( fid, '-%d %d  %d\n' , datasave');
fclose (fid);




