#ifndef __MAIN_H__
#define __MAIN_H__

#include <iostream>
using namespace std;

#include <blaze/Math.h>
using blaze::CompressedMatrix;
using blaze::DynamicVector;
using blaze::DenseSubvector;

typedef complex<double>                  Element;
typedef blaze::CompressedMatrix<Element> Matrix;
typedef blaze::DynamicVector<Element>    Vector;
typedef blaze::DenseSubvector<Vector>    Subvector;

#endif