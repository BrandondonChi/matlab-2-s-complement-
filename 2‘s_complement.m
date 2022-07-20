clc;clear;
% rx_signal=textread('rx1.txt');
% rx_signal=rx_signal(:,1);
% fid=fopen('rx1.txt','wt');
% fprintf(fid,'%.4f\n',rx_signal);
% fclose(fid);
rx_signal=round(textread('rx1.txt'));
rx_signal(24,1)

rx_2complement=zeros(800,13);%²¹Âë
rx_1complement=zeros(800,13);%·´Âë

for i=1:800

    if rx_signal(i)<0        
        rx_2complement(i,13)=1;
        rx_1complement(i,13)=1;
        rx_temp=dec2bin(abs(rx_signal(i)));
        len=length(rx_temp);
        temp=0;
        sum1=0;
         for j=1:12
            if (13-j)>len
                rx_1complement(i,13-j)=1;
            else
                k=13-j;
                rx_1complement(i,(j+len-12))=1-str2double(rx_temp(k));
            end
            temp=rx_1complement(i,j)*2^(j-1);
            
         end
         rx_1complement(1,:);
sum1=rx_1complement(i,1)+rx_1complement(i,2)*2+rx_1complement(i,3)*(2^2)+rx_1complement(i,4)*(2^3)+rx_1complement(i,5)*(2^4)+rx_1complement(i,6)*(2^5)+rx_1complement(i,7)*(2^6)+rx_1complement(i,8)*(2^7)+rx_1complement(i,9)*(2^8)+rx_1complement(i,10)*(2^9)+rx_1complement(i,11)*(2^10)+rx_1complement(i,12)*(2^11);

        rx_2complement_str=dec2bin(sum1+1);
        for m=12:-1:1
            if m>length(rx_2complement_str)
                rx_2complement(i,m)=0;
            else
                rx_2complement(i,length(rx_2complement_str)-m+1)=str2double(rx_2complement_str(m));
            end
        end

    else 
        rx_2complement(i,13)=0;
        rx_1complement(i,13)=0;
        rx_temp=dec2bin(abs(rx_signal(i)));
        len=length(rx_temp);
        for j=1:12
            if (13-j)>len
                rx_2complement(i,13-j)=0;
            else
                rx_2complement(i,(j+len-12))=str2double(rx_temp(13-j));
            end
        end
    end
end
rx_2complement_hex=zeros(800,1);
for i=1:800
    for j=1:13
        rx_2complement_hex(i)=rx_2complement(i,j)*2^(j-1)+rx_2complement_hex(i);
    end
end

fid=fopen('rx_hex_signed.txt','wt');
for i=1:800
   a=dec2hex(rx_2complement_hex(i));
   
   fprintf(fid,'%c',a);
   fprintf(fid,',\n');
end
fclose(fid);

% rx_signal=abs(rx_signal);
% a=dec2bin(5)
% a(1)
% str2double('101')
% % rx_signal=round(rx_signal.*10000);
% rx_signal1=zeros(800,2);
% fid=fopen('rx_hex.txt','wt');
% for i=1:800
%    a=dec2hex(rx_signal(i));
%    
%    fprintf(fid,'%c',a);
%    fprintf(fid,'\n');
% end
% fclose(fid);

