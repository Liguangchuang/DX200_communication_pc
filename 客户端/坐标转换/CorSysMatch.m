%---------------------------
% ����ϵƥ���ӳ���
% ����ԭ����ϵ4�����3ά�����Ŀ������ϵ��Ӧ4�����3ά����
% ͨ��4�μ��� ��ƽ��
% ���ƥ����Ҫ����תƽ�ƾ���
%---------------------------
function [RotAng,ShiftXYZ] = CorSysMatch(PA,PB)
%----------------------------
% �����ӳ���
[RotA,Shift] = CormatchV1(PA,PB);
% ��ƽ�ƺ���ת
PB1(:,1) = PB(:,1) - Shift(2,1);
PB1(:,2) = PB(:,2) - Shift(2,2);
PB1(:,3) = PB(:,3) - Shift(2,3);
for idn =1:5
    RotAng = RotA(idn,:);
    [PB1(:,1),PB1(:,2),PB1(:,3)] = Rotation3D(PB1(:,1),PB1(:,2),PB1(:,3),RotAng);
end
PB1(:,1) = PB1(:,1) + Shift(1,1);
PB1(:,2) = PB1(:,2) + Shift(1,2);
PB1(:,3) = PB1(:,3) + Shift(1,3);
%-------------------------------
% ����ƽ��
PA = [PA(2:end,:); PA(1:1,:)];
PB = [PB(2:end,:); PB(1:1,:)];
[RotA,Shift] = CormatchV1(PA,PB);
% ��ƽ�ƺ���ת
PB2(:,1) = PB(:,1) - Shift(2,1);
PB2(:,2) = PB(:,2) - Shift(2,2);
PB2(:,3) = PB(:,3) - Shift(2,3);
for idn =1:5
    RotAng = RotA(idn,:);
    [PB2(:,1),PB2(:,2),PB2(:,3)] = Rotation3D(PB2(:,1),PB2(:,2),PB2(:,3),RotAng);
end
PB2(:,1) = PB2(:,1) + Shift(1,1);
PB2(:,2) = PB2(:,2) + Shift(1,2);
PB2(:,3) = PB2(:,3) + Shift(1,3);
% ��������
PB2 = [PB2(end:end,:); PB2(1:end-1,:)];
%-------------------------------
% ����ƽ��
PA = [PA(2:end,:); PA(1:1,:)];
PB = [PB(2:end,:); PB(1:1,:)];
[RotA,Shift] = CormatchV1(PA,PB);
% ��ƽ�ƺ���ת
PB3(:,1) = PB(:,1) - Shift(2,1);
PB3(:,2) = PB(:,2) - Shift(2,2);
PB3(:,3) = PB(:,3) - Shift(2,3);
for idn =1:5
    RotAng = RotA(idn,:);
    [PB3(:,1),PB3(:,2),PB3(:,3)] = Rotation3D(PB3(:,1),PB3(:,2),PB3(:,3),RotAng);
end
PB3(:,1) = PB3(:,1) + Shift(1,1);
PB3(:,2) = PB3(:,2) + Shift(1,2);
PB3(:,3) = PB3(:,3) + Shift(1,3);
% ��������
PB3 = [PB3(end-1:end,:); PB3(1:end-2,:)];
%-------------------------------
% ����ƽ��
PA = [PA(2:end,:); PA(1:1,:)];
PB = [PB(2:end,:); PB(1:1,:)];
[RotA,Shift] = CormatchV1(PA,PB);
% ��ƽ�ƺ���ת
PB4(:,1) = PB(:,1) - Shift(2,1);
PB4(:,2) = PB(:,2) - Shift(2,2);
PB4(:,3) = PB(:,3) - Shift(2,3);
for idn =1:5
    RotAng = RotA(idn,:);
    [PB4(:,1),PB4(:,2),PB4(:,3)] = Rotation3D(PB4(:,1),PB4(:,2),PB4(:,3),RotAng);
end
PB4(:,1) = PB4(:,1) + Shift(1,1);
PB4(:,2) = PB4(:,2) + Shift(1,2);
PB4(:,3) = PB4(:,3) + Shift(1,3);
% ��������
PB4 = [PB4(end-2:end,:); PB4(1:end-3,:)];
% ����ԭ
PA  = [PA(2:end,:); PA(1:1,:)];
PB  = [PB(2:end,:); PB(1:1,:)];
%------------------------------
% ��ƽ�� �õ��µı�׼����ϵ
NewPA(:,1) = PB1(:,1)./4 + PB2(:,1)./4 + PB3(:,1)./4 + PB4(:,1)./4;
NewPA(:,2) = PB1(:,2)./4 + PB2(:,2)./4 + PB3(:,2)./4 + PB4(:,2)./4;
NewPA(:,3) = PB1(:,3)./4 + PB2(:,3)./4 + PB3(:,3)./4 + PB4(:,3)./4;
% ���±�׼����ϵ����תƽ����
[RotAng,ShiftXYZ] = CormatchV1(NewPA,PB);

return




%-----