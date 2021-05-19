function [Output] = PSK_Chart(SNR,PERIOD)
i=10;
j=5000;
t=linspace(0,5,j);
fc=10;
fm=i/5;
B=2*fm;
 
 
error=0;           %��ȡ������Ԫ�ĸ���
for echo=1:1:PERIOD  %һ��ѭ��echo������

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
figure(1);
subplot(421);
plot(t,st1);
title('�����ƻ����ź�');
axis([0,5,-1,2]);
 
%�����ƻ����ź���
st2=t;
for k=1:j
    if st1(k)>=1
        st2(k)=0;
    else
        st2(k)=1;
    end
end
 
st3=st1-st2;
subplot(422);
plot(t,st3);
title('˫���Ի����ź�');
axis([0,5,-2,2]);
 
%�����ز��ź�
s1=sin(2*pi*fc*t);
subplot(423);
plot(s1);
title('�ز��ź�');
 
%2PSK����
e_psk=st3.*s1;

subplot(424);
plot(t,e_psk);
title('2PSK�����ź�');
 
%��˹������
psk=awgn(e_psk,SNR);
subplot(425);
plot(t,psk);
title('������ź�');

%��ͨ�˲���
[b1,a1]=ellip(4,0.11,30,[9,11]*2/40);
psk=filter(b1,a1,psk);
 
psk=psk.*s1;
subplot(426);
plot(t,psk);
title('���ز���˺��ź�');

[B,A]=butter(4,0.14);
psk=filter(B,A,psk);
subplot(427);
plot(t,psk);
title('��ͨ�˲���');
 
%�����о�
for m=0:i-1
    if psk(1,m*500+250)<0
        for j=m*500+1:(m+1)*500
            psk(1,j)=0;
        end
    else
        for j=m*500+1:(m+1)*500
            psk(1,j)=1;
        end
    end
end
for k=1:1:5000 
    if st1(k)~=psk(k)
        error=error+1;
    end
end
subplot(428);
plot(t,psk);
axis([0,5,-1,2]);
title('�����о�����');
end
error_rate=error/500/(10*PERIOD);   %����������
Output=error/500;
end

