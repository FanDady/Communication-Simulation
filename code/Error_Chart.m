clear
clc
%�����������ʼ��
ERROR_ASK=zeros(1,21);
ERROR_FSK=zeros(1,21);
ERROR_PSK=zeros(1,21);
ERROR_4PSK=zeros(1,21);

%����ȷ�Χ
snr=-10;
snr_db=-10:1:10;
Snr=10.^(snr_db/10);

%ÿһ�������SNR��Ӧ��������
for loop=1:1:21
   ERROR_ASK(loop)=ASK_Function(snr);
   ERROR_FSK(loop)=FSK_Function(snr);
   ERROR_PSK(loop)=PSK_Function(snr);
   ERROR_4PSK(loop)=PSK4_Function(snr);
   snr=snr+1;
   disp(['��ǰ����Ϊ��',num2str(100/21*loop),'%'])
   if loop==21
       disp('�����')
   end
end


%���۵�������
Pe_2ASK_theory=0.5*erfc(sqrt(0.25*Snr));      %���������ʼ���
semilogy(snr_db,Pe_2ASK_theory,'r-');hold on; %������������������
Pe_2FSK_theory=0.5*erfc(sqrt(0.5*Snr));       %���������ʼ���
semilogy(snr_db,Pe_2FSK_theory,'g-');hold on; %������������������
Pe_2PSK_theory=0.5*erfc(sqrt(Snr));
semilogy(snr_db,Pe_2PSK_theory,'b-');hold on; %������������������
Pe_4PSK_theory=0.5*erfc(sqrt(Snr*0.5));
semilogy(snr_db,Pe_4PSK_theory,'y-');hold on;



%ʵ��������
semilogy(snr_db,ERROR_ASK,'r*');hold on;      %����ʵ��������
semilogy(snr_db,ERROR_FSK,'g*');hold on;      %����ʵ��������
semilogy(snr_db,ERROR_PSK,'b*');hold on;      %����ʵ��������
semilogy(snr_db,ERROR_4PSK,'y*');hold on;

grid on;
legend('ERROR_ASK','ERROR_FSK','ERROR_PSK','ERROR_4PSK','Pe_2ASK_theory','Pe_2FSK_theory','Pe_2PSK_theory','Pe_4PSK_theory');
xlabel('�����/dB');
ylabel('������');