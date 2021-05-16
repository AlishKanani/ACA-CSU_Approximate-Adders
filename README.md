# ACA-CSU_Approximate-Adders

This is GitHub repository of MATLAB and HDL models of ACA-CSU approximate adders. 

## Performance matrices
----


|     Adder    | Error Rate |     NED     |     MRED    | Delay |    Area    |   Power  |
|:------------:|:----------:|:-----------:|:-----------:|:-----:|:----------:|:--------:|
| [ACA-CSU_8_2](Verilog/aca_csu8_2.v) |   7.9021   |  0.0552865  | 0.017437931 |  0.38 |  61.977999 |  39.086  |
| [ACA-CSU_8_4](Verilog/aca_csu8_4.v) |      0     |      0      |      0      |  0.49 |   62.244   |  43.6306 |
| [ACA-CSU_16_2](Verilog/aca_csu16_2.v) |   24.9375  | 0.058585522 | 0.019796793 |  0.38 | 134.329999 |  86.0472 |
| [ACA-CSU_16_4](Verilog/aca_csu16_4.v) |   2.8121   |   0.015506  | 0.001319723 |  0.55 | 140.979999 |  99.634  |
| [ACA-CSU_16_8](Verilog/aca_csu16_8.v) |      0     |      0      |      0      |  0.64 |   161.196  | 115.9792 |
| [ACA-CSU_32_2](Verilog/aca_csu32_2.v) |   50.3333  | 0.058429095 | 0.019830952 |  0.38 | 279.033998 |  179.223 |
| [ACA-CSU_32_4](Verilog/aca_csu32_4.v) |   8.4845   | 0.015462372 | 0.001305994 |  0.55 | 298.451998 | 210.1809 |
| [ACA-CSU_32_8](Verilog/aca_csu32_8.v) |   0.1967   | 0.000988836 |   5.37E-06  |  0.71 | 352.183999 | 254.6506 |

- Naming convention: ACA-CSU_N_M, N signifies bit length and M is the block size. i.e., if for a 16-bit number the block size is 2, then ACA-CSU_16_2 adder should be used. 
- In the Matlab code, K is the block size of CarryPredict. For comparison purpose M and K are kept same for the above table.

## Reference
----
This library is licenced under [MIT licence](LICENCE.md). If you use the library in your research, please refer the following paper:

A. Kanani, J. Mehta and N. Goel, "ACA-CSU: A Carry Selection Based Accuracy Configurable Approximate Adder Design," 2020 IEEE Computer Society Annual Symposium on VLSI (ISVLSI), 2020, pp. 434-439, doi: [10.1109/ISVLSI49217.2020.00085](https://doi.org/10.1109/ISVLSI49217.2020.00085) 
```bibtex
@INPROCEEDINGS{aca-csu,
  author={Kanani, Alish and Mehta, Jigar and Goel, Neeraj},
  booktitle={2020 IEEE Computer Society Annual Symposium on VLSI (ISVLSI)}, 
  title={ACA-CSU: A Carry Selection Based Accuracy Configurable Approximate Adder Design}, 
  year={2020},
  volume={},
  number={},
  pages={434-439},
  doi={10.1109/ISVLSI49217.2020.00085}}
```
