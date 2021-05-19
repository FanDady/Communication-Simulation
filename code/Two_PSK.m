i=10;
j=5000;
t=linspace(0,5,j);
fc=10;
fm=i/5;
B=2*fm;
 

DB=10;              %ѡ���������ȵĴ�С��λ��dB

error=0;           %��ȡ������Ԫ�ĸ���
for echo=1:1:1  %һ��ѭ��echo������

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
subplot(411);
plot(t,st1);
title('�����ź�st1');
axis([0,5,-1,2]);
 
%�����ź���
st2=t;
for k=1:j
    if st1(k)>=1
        st2(k)=0;
    else
        st2(k)=1;
    end
end
subplot(412);
plot(t,st2);
title('�����źŷ���');
axis([0,5,-1,2]);
 
st3=st1-st2;
subplot(413);
plot(t,st3);
title('˫���Ի����ź�');
axis([0,5,-2,2]);
 
%�ز��ź�
s1=sin(2*pi*fc*t);
subplot(414);
plot(s1);
title('�ز��ź�');
%2PSK����
e_psk=st3.*s1;
figure(2);
subplot(511);
plot(t,e_psk);
title('���ƺ���2psk');
 
%����
psk=awgn(e_psk,DB);%��������
subplot(512);
plot(t,psk);
title('�������');

%��ͨ�˲���
[b1,a1]=ellip(4,0.1,40,[999.9,1000.1]*2/5000);
psk=filter(b1,a1,psk);

psk=psk.*s1;%���ز����
subplot(513);
plot(t,psk);
title('���ز���˺���');
[f,af] = Florier(t,psk);%����Ҷ�任
[t,psk] = LowPassFilter(f,af,B);%ͨ����ͨ�˲���
subplot(514);
plot(t,psk);
title('��ͨ�˲�����');
 
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
subplot(515);
plot(t,psk);
axis([0,5,-1,2]);
title('�����о�����');
end