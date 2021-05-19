clear
clc

i=10;              %������Ԫ��Ϊ10��
j=5000;            %�����ܹ�10����Ԫռ��0-5��5000����ÿ����Ԫռ��500����
t=linspace(0,5,j); %tΪʱ����ֳ���0-5��5000����
fc=10;             %�ز�Ƶ��
B=2*i/5;
DB=10;             %ѡ���������ȵĴ�С��λ��dB

for echo=1:1:1     %һ��ѭ��echo������   
%���������ƻ����ź�
x=(rand(1,i));
a=round(x);
st=t;
for n=1:10
    if a(n)<1
        for m=j/i*(n-1)+1:j/i*n  
            st(m)=0;
        end
    else
        for m=j/i*(n-1)+1:j/i*n
            st(m)=1;
        end
    end
end
figure(1);
subplot(421);
plot(t,st);
axis([0,5,-1,2]);
title('�����ƻ����ź�');
%�����ز�
s1=cos(2*pi*fc*t);
subplot(422);
plot(s1);
title('�ز��ź�');
%2ASK����
e_2ask=st.*s1;%st�ǻ����ź�,s1���ز�
subplot(423);
plot(t,e_2ask);
title('�����ź�2ASK');
%�����˹������;
e_2ask=awgn(e_2ask,DB);%��������
subplot(424);
plot(t,e_2ask);
title('���������ĵ����ź�');
%��ͨ�˲�
[B,A]=butter(4,[0.06 0.14]);
bpf_2ask=filter(B,A,e_2ask);
at=bpf_2ask.*cos(2*pi*fc*t);
at=at-mean(at);
subplot(425);
plot(t,at);
title('�ز���˺��ź�');
%ͨ����ͨ�˲���
[f,af] = Florier(t,at);
[t,at] = LowPassFilter(f,af,B);
subplot(426);
plot(t,at);
title('������ͨ�˲�������ź�');
%�����о�
for m=0:i-1 
    if (at(1,m*500+250)+0.5)<0.5
        for j=m*500+1:(m+1)*500
            at(1,j)=0;
        end
    else
        for j=m*500+1:(m+1)*500
            at(1,j)=1;
        end
    end
end

subplot(427);
plot(t,at);
axis([0,5,-1,2]);
title('�����о�����')

end
