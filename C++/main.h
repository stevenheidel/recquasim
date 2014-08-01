#ifndef __MAIN_H__
#define __MAIN_H__

#include <cstdlib>
#include <ctime>
#include <iostream>
using namespace std;

#include <blaze/Math.h>
using blaze::CompressedMatrix;
using blaze::DynamicVector;
using blaze::DenseSubvector;

typedef complex<double>                  Complex;
typedef blaze::CompressedMatrix<Complex> Matrix;
typedef blaze::DynamicVector<Complex>    Vector;
typedef blaze::DenseSubvector<Vector>    Subvector;

#endif