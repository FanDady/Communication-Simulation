clear
clc

i=10;
j=5000;
t=linspace(0,5,j);
f1=10;
fm=i/5;

SNR_DB=-10:2:10;    %ȡ������Χ
SNR=10.^(SNR_DB/10);%ת����λ
error=0;            %������Ԫ����

for echo=1:1:1  %һ��ѭ��echo������
%���������ƻ����ź�
a=round(rand(1,i));
st1=t;
for n=1:10
    if a(n)<1
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=0;
        end
    else
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=1;
        end
    end
end
st0=st1;
figure(1);
subplot(411);
plot(t,st0);
title('�����ƻ����ź�');
axis([0,5,-2,2]);
st2=t;
for n=1:j
    if st1(n)==1
        st2(n)=0;
    else
        st2(n)=1;
    end
end
subplot(412);
plot(t,st2);
title('���������ź�');
axis([0,5,-1,2]);
%���������ز��ź�
s1=cos(2*pi*f1*t);
s2=cos(2*pi*f1*2*t);
subplot(413);
plot(s1);
title('�ز��ź�1');
subplot(414);
plot(s2);
title('�ز��ź�2');
%2FSK����
F1=st1.*s1;
F2=st2.*s2;
figure(2);
subplot(411);
plot(t,F1);
title('F1');
subplot(412);
plot(t,F2);
title('F2');
e_fsk=F1+F2;
subplot(413);
plot(t,e_fsk);
title('2FSK�ź�');
%�����˹������;
fsk=awgn(e_fsk,10);%��������
subplot(414);
plot(t,fsk);
title('�����������ź�');
%��ͨ�˲�
[b1,a1]=butter(4,[0.07 0.13]);
fsk1=filter(b1,a1,fsk);
[b2,a2]=butter(4,[0.13 0.28]);
fsk2=filter(b2,a2,fsk);
%ͨ����ͨ�˲���
st1=fsk1.*s1;             
[f,sf1] = Florier(t,st1);     
[t,st1] = LowPassFilter(f,sf1,2*fm); 
figure(3);
subplot(311);
plot(t,st1);
title('���ز�1��˺���');
st2=fsk2.*s2;            
[f,sf2] = Florier(t,st2);      
[t,st2] = LowPassFilter(f,sf2,2*fm);
subplot(312);
plot(t,st2);
title('���ز�2��˺���');
 
for m=0:i-1
    if st1(1,m*500+250)>st2(1,m*500+250)
        for j=m*500+1:(m+1)*500
            at(1,j)=1;
        end
    else
        for j=m*500+1:(m+1)*500
            at(1,j)=0;
        end
    end
end
for k=1:1:5000 
    if st0(k)~=at(k)
        error=error+1;
    end
end
subplot(313);
plot(t,at);
axis([0,5,-1,2]);
title('�����о�����')

end
error_rate=error/500/(10*1);   %����������

