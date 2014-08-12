#include "mex.h"

// Multiply a vector by H_i using magic multiply
void multiply_by_h_i(int dim, double* input_r, double* input_i, double* output_r, double* output_i) {
    int m = 1;
    int in = 0;
    int out = 0;

    while (dim > 1) {
        dim = dim >> 1;
        m *= 2;

        for (int i = 0; i < dim; i++) {
            for (int j = 0; j < m; j++) {
                out = j * dim + i;
                in = (j % 2 == 0 ? out + dim : out - dim);

                // -= because all entries in H_i contain -1
                output_r[out] -= input_r[in];
                output_i[out] -= input_i[in];
            }
        }
    }

    return;
}

// Multiply a vector by H_f
void multiply_by_h_f(int dim, double* h_f_r, double* input_r, double* input_i, double* output_r, double* output_i) {
    for (int i = 0; i < dim; i++) {
        output_r[i] = h_f_r[i] * input_r[i];
        output_i[i] = h_f_r[i] * input_i[i];
    }

    return;
}

// Input order: H_f, T, psi_in, step, tol, installment
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) {
    if (nlhs != 1 || nrhs != 6)
        mexErrMsgTxt("Called with incorrect number of input/outputs\n");

    int dim = mxGetNumberOfElements(prhs[0]);
    int dims[] = {dim}; // Used to pass to mxCreateNumericArray

    // Real part of H_f
    double* h_f = mxGetPr(prhs[0]);

    // Both parts of psi_in
    double* psi_in_r = mxGetPr(prhs[2]);
    double* psi_in_i = mxGetPi(prhs[2]);

    // Scalars
    double t = mxGetScalar(prhs[1]);
    double step = mxGetScalar(prhs[3]);
    double tol = mxGetScalar(prhs[4]);
    double installment = mxGetScalar(prhs[5]);

/*
i_by_psi_in = H_i * psi_in;
f_by_psi_in = H_f_diag .* psi_in;
*/
    // Imaginary part of c
    double c_i = -1 * t;
    // Real part of d
    double d = (installment - 1) * step;

/*
i_by_psi_in = H_i * psi_in;
f_by_psi_in = H_f_diag .* psi_in;
*/

    // i_by_psi_in
    mxArray* i_by_psi_in_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* i_by_psi_in_r = mxGetPr(i_by_psi_in_mx);
    double* i_by_psi_in_i = mxGetPi(i_by_psi_in_mx);

    // f_by_psi_in
    mxArray* f_by_psi_in_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* f_by_psi_in_r = mxGetPr(f_by_psi_in_mx);
    double* f_by_psi_in_i = mxGetPi(f_by_psi_in_mx);

    multiply_by_h_i(dim, psi_in_r, psi_in_i, i_by_psi_in_r, i_by_psi_in_i);
    multiply_by_h_f(dim, h_f, psi_in_r, psi_in_i, f_by_psi_in_r, f_by_psi_in_i);

/*
psi_n_min_2 = psi_in;
psi_n_min_1 = c * ((1-d) * i_by_psi_in + d * f_by_psi_in);
psi = psi_n_min_1 * step + psi_n_min_2;

i_by_min_2 = i_by_psi_in;
f_by_min_2 = f_by_psi_in;
*/
    
    // Initialize all the recurrence variables
    
    // psi_n_min_2
    mxArray* psi_n_min_2_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* psi_n_min_2_r = mxGetPr(psi_n_min_2_mx);
    double* psi_n_min_2_i = mxGetPi(psi_n_min_2_mx);

    // psi_n_min_1
    mxArray* psi_n_min_1_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* psi_n_min_1_r = mxGetPr(psi_n_min_1_mx);
    double* psi_n_min_1_i = mxGetPi(psi_n_min_1_mx);

    // psi
    mxArray* psi_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* psi_r = mxGetPr(psi_mx);
    double* psi_i = mxGetPi(psi_mx);

    // psi_n
    mxArray* psi_n_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* psi_n_r = mxGetPr(psi_n_mx);
    double* psi_n_i = mxGetPi(psi_n_mx);

    // cor
    mxArray* cor_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* cor_r = mxGetPr(cor_mx);
    double* cor_i = mxGetPi(cor_mx);

    // i_by_min_2
    mxArray* i_by_min_2_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* i_by_min_2_r = mxGetPr(i_by_min_2_mx);
    double* i_by_min_2_i = mxGetPi(i_by_min_2_mx);

    // i_by_min_1
    mxArray* i_by_min_1_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* i_by_min_1_r = mxGetPr(i_by_min_1_mx);
    double* i_by_min_1_i = mxGetPi(i_by_min_1_mx);

    // f_by_min_2
    mxArray* f_by_min_2_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* f_by_min_2_r = mxGetPr(f_by_min_2_mx);
    double* f_by_min_2_i = mxGetPi(f_by_min_2_mx);

    // f_by_min_1
    mxArray* f_by_min_1_mx = mxCreateNumericArray(1, dims, mxDOUBLE_CLASS, mxCOMPLEX);
    double* f_by_min_1_r = mxGetPr(f_by_min_1_mx);
    double* f_by_min_1_i = mxGetPi(f_by_min_1_mx);

    for (int i = 0; i < dim; i++) {
        // psi_n_min_2 = psi_in
        psi_n_min_2_r[i] = psi_in_r[i];
        psi_n_min_2_i[i] = psi_in_i[i];

        // psi_n_min_1 = c * ((1-d) * i_by_psi_in + d * f_by_psi_in)
        // Real part = c * imag * -1, Imaginary part = c * real
        psi_n_min_1_r[i] = c_i * ((1 - d) * i_by_psi_in_i[i] + d * f_by_psi_in_i[i]) * -1;
        psi_n_min_1_i[i] = c_i * ((1 - d) * i_by_psi_in_r[i] + d * f_by_psi_in_r[i]);

        // psi = psi_n_min_1 * step + psi_n_min_2
        psi_r[i] = psi_n_min_1_r[i] * step + psi_n_min_2_r[i];
        psi_i[i] = psi_n_min_1_i[i] * step + psi_n_min_2_i[i];
    }

/*
nrm_cor = 1;
n = 1;
*/

    // Needed later for MATLAB call
    mxArray* nrm_cor_mx = mxCreateDoubleScalar(0);
    mxArray* norm_input[] = {cor_mx};
    mxArray* norm_output[] = {nrm_cor_mx};

    double nrm_cor = 1;
    double n = 1;

    // ALGORITHM LOOP

/*
while (nrm_cor > tol)
n = n+1;
*/

    double stepn = step;
    while (nrm_cor > tol) {
        n++;
        stepn = stepn * step;

    /*
    i_by_min_1 = H_i * psi_n_min_1;
    f_by_min_1 = H_f_diag .* psi_n_min_1;
    */

        multiply_by_h_i(dim, psi_n_min_1_r, psi_n_min_1_i, i_by_min_1_r, i_by_min_1_i);
        multiply_by_h_f(dim, h_f, psi_n_min_1_r, psi_n_min_1_i, f_by_min_1_r, f_by_min_1_i);

    /*
    psi_n = (c/n)*((1-d) * i_by_min_1 + d * f_by_min_1 + f_by_min_2 - i_by_min_2)
    cor = psi_n*step^n;
    
    psi = psi + cor;
    */

        for (int i = 0; i < dim; i++) {
            // TODO
            psi_n_r[i] = (c_i / n) * ((1 - d) * i_by_min_1_i[i] + d * f_by_min_1_i[i] + f_by_min_2_i[i] - i_by_min_2_i[i]) * -1;
            psi_n_i[i] = (c_i / n) * ((1 - d) * i_by_min_1_r[i] + d * f_by_min_1_r[i] + f_by_min_2_r[i] - i_by_min_2_r[i]);

            cor_r[i] = psi_n_r[i] * stepn;
            cor_i[i] = psi_n_i[i] * stepn;

            psi_r[i] += cor_r[i];
            psi_i[i] += cor_i[i];
        }

    /*
    nrm_cor = norm(cor);
    */

        mexCallMATLAB(1, norm_output, 1, norm_input, "norm");
        nrm_cor = mxGetScalar(nrm_cor_mx);

    /*
    psi_n_min_2 = psi_n_min_1;
    psi_n_min_1 = psi_n;

    i_by_min_2 = i_by_min_1;
    f_by_min_2 = f_by_min_1;
    */

        for (int i = 0; i < dim; i++) {
            psi_n_min_2_r[i] = psi_n_min_1_r[i];
            psi_n_min_2_i[i] = psi_n_min_1_i[i];

            psi_n_min_1_r[i] = psi_n_r[i];
            psi_n_min_1_i[i] = psi_n_i[i];

            i_by_min_2_r[i] = i_by_min_1_r[i];
            i_by_min_2_i[i] = i_by_min_1_i[i];

            f_by_min_2_r[i] = f_by_min_1_r[i];
            f_by_min_2_i[i] = f_by_min_1_i[i];
        }
    }

/*
psi_fin = psi;
*/

    plhs[0] = psi_mx;

    // Free all other variables
    mxDestroyArray(i_by_psi_in_mx);
    mxDestroyArray(f_by_psi_in_mx);

    mxDestroyArray(psi_n_min_2_mx);
    mxDestroyArray(psi_n_min_1_mx);
    mxDestroyArray(psi_n_mx);

    mxDestroyArray(i_by_min_2_mx);
    mxDestroyArray(i_by_min_1_mx);
    mxDestroyArray(f_by_min_2_mx);
    mxDestroyArray(f_by_min_1_mx);

    mxDestroyArray(cor_mx);

    return;
}