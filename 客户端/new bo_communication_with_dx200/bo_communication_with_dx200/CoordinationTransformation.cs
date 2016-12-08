using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Emgu;
using Emgu.CV;
using Emgu.CV.CvEnum;
using Emgu.CV.Util;
using Emgu.CV.Cuda;
using Emgu.CV.XFeatures2D;
using System.Drawing;
using System.Collections;
using Emgu.CV.Structure;
using System.IO;

namespace bo_communication_with_dx200
{
    class CoordinationTransformation
    {
        public int[] sub(double x1, double y1)
        {
            double a = 3.0050; double b = 1.8004;
            double x0 = 0; double y0 = 0; double z0 = 0;
            int[] result = new int[2];

            Matrix<double> V = new Matrix<double>(1, 3);
            V.Data[0, 0] = x0;
            V.Data[0, 1] = y0;
            V.Data[0, 2] = z0;
            Matrix<double> R = new Matrix<double>(1, 3);
            R.Data[0, 0] = 0.791 * x1 + 143.966;
            R.Data[0, 1] = 0.791 * y1 + 107.362;
            R.Data[0, 2] = 0;
            Matrix<double> S = new Matrix<double>(3, 3);
            S.Data[0, 0] = 1;
            S.Data[0, 1] = 0;
            S.Data[0, 2] = 0;
            S.Data[1, 0] = 0;
            S.Data[1, 1] = Math.Cos(a);
            S.Data[1, 2] = Math.Sin(a);
            S.Data[2, 0] = 0;
            S.Data[2, 1] = -Math.Sin(a);
            S.Data[2, 2] = Math.Cos(a);
            Matrix<double> T = new Matrix<double>(3, 3);
            T.Data[0, 0] = 1;
            T.Data[0, 1] = 0;
            T.Data[0, 2] = 0;
            T.Data[1, 0] = 0;
            T.Data[1, 1] = Math.Cos(b);
            T.Data[1, 2] = Math.Sin(b);
            T.Data[2, 0] = 0;
            T.Data[2, 1] = -Math.Sin(b);
            T.Data[2, 2] = Math.Cos(b);
            Matrix<double> U = new Matrix<double>(1, 3);
            U.Data[0, 0] = 915.0406;
            U.Data[0, 1] = -310.634;
            U.Data[0, 2] = 0;

            Matrix<double> S1 = new Matrix<double>(1, 3);
            Matrix<double> S2 = new Matrix<double>(1, 3);
            S1 = R.Mul(S);
            S2 = S1.Mul(T);
            V = S2 + U;
          

            result[0] =(int) V.Data[0, 0];
            result[1] =(int) V.Data[0, 1];


          return (result);

            
        }
    }
}
