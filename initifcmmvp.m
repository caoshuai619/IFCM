function [Miuij,Vij,Paiij]=initifcmmvp(data)


Miuij=data;  %������
alpha=0.85;   %����     %�������������ʵ��Ľ������alpha��0.8-0.9֮��Ч���ȽϺ�
Vij=(1-Miuij.^alpha).^(1/alpha); %��������
Paiij=1-Miuij-Vij;  %��ȷ���Ⱦ���
end
