%---------------------------
% �ռ�3ά������ת �ӳ���
% ����X��Y��Z���꣬�Լ���ת��RotA = [RotX,RotY,RotZ]
% ����RotX,RotY,RotZ�ֱ��ʾ3ά������X��Y��Z�����ת�Ƕȣ���λΪ����
% �����ת�������X',Y',Z'
%---------------------------

function [X2_3D,Y2_3D,Z2_3D] = Rotation3D(X1_3D,Y1_3D,Z1_3D,RotA)

% ����������ݵ�������
    [Szy,Szx] = size(X1_3D);
% �����ʼ��
    X2_3D = X1_3D;
    Y2_3D = Y1_3D;
    Z2_3D = Z1_3D;
% ��X����ת
    AngX  = RotA(1);
    if AngX ~= 0
        for idy = 1:Szy
            for idx = 1:Szx
                TmpX   = X2_3D(idy,idx);
                TmpY   = Y2_3D(idy,idx);
                TmpZ   = Z2_3D(idy,idx);
                X2_3D(idy,idx) =  TmpX;
                Y2_3D(idy,idx) =  TmpY*cos(AngX)-TmpZ*sin(AngX);
                Z2_3D(idy,idx) =  TmpY*sin(AngX)+TmpZ*cos(AngX);
            end
        end
    end
% ��Y����ת
    AngY  = RotA(2);
    if AngY ~= 0
        for idy = 1:Szy
            for idx = 1:Szx
                TmpX   = X2_3D(idy,idx);
                TmpY   = Y2_3D(idy,idx);
                TmpZ   = Z2_3D(idy,idx);
                X2_3D(idy,idx) =  TmpX*cos(AngY)+TmpZ*sin(AngY);
                Y2_3D(idy,idx) =  TmpY;
                Z2_3D(idy,idx) =  -TmpX*sin(AngY)+TmpZ*cos(AngY);
            end
        end
    end
% ��Z����ת
    AngZ  = RotA(3);
    if AngZ ~= 0
        for idy = 1:Szy
            for idx = 1:Szx
                TmpX   = X2_3D(idy,idx);
                TmpY   = Y2_3D(idy,idx);
                TmpZ   = Z2_3D(idy,idx);
                X2_3D(idy,idx) =  TmpX*cos(AngZ)-TmpY*sin(AngZ);
                Y2_3D(idy,idx) =  TmpX*sin(AngZ)+TmpY*cos(AngZ);
                Z2_3D(idy,idx) =  TmpZ;
            end
        end
    end
  
return
