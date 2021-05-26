# Brain-Age-Estimation
A collection of different regression models for predicting Brain Age from T1 weighted MRI Images. To be used as a reference to the paper: **Predicting brain age using machine learning algorithms: A comprehensive evaluation (IEEE JBHI-EMBS)** `https://doi.org/10.1109/JBHI.2021.3083187 `.  

## Authors
**Iman Beheshti**: Department of Human Anatomy and Cell Science, Rady Faculty of Health Sciences, Max Rady College of Medicine,
University of Manitoba, Winnipeg, MB, Canada   
**M. Tanveer**: Department of Mathematics, Indian Institute of Technology Indore, India  
**Imran Razzak**: School of Information Technology, Deakin University, Geelong, Australia   
**M.A. Ganaie**: Post-Doctoral Student, Department of Mathematics, Indian Institute of Technology Indore, India   
**Aryan Rastogi**: Undergraduate Student, Department of Electrical Engineering, Indian Institute of Technology Indore, India  
**Vardhan Paliwal**: Undergraduate Student, Department of Electrical Engineering, Indian Institute of Technology Indore, India  

## Regression Algorithms evaluated:
1. Bagged Ensemble Trees
2. Binary Decision Tree
3. Fast Decorrelated Neural Network Ensembles(DNNE)
4. Gaussian Regression(Exponential kernel)
5. Gaussian Support Vector Regression
6. Kernel Ridge Regression
7. Lasso Regression
8. Linear Regression
9. Linear Varepsilon Twin Support Vector Regression(ETSVR)
10. Linear Support Vector Regression
11. Least Square Ensemble Trees
12. Gaussian Regression(Matern32 kernel)
13. Gaussian Regression(Matern52 kernel)
14. Nystr&ouml;m Kernel Ridge Regression
15. Quadratic Support Vector Regression
16. Ridge Regression
17. Gaussian regression(Rational Quadratic kernel)
18. Gaussian regression(Squared exponential kernel)
19. Weighted Mean K-Nearest Neighbor
20. Neural Network  
21. Regularized K-Nearest Neighbor based Weighted Twin Support Vector Regression(RKNNWTSVR)  
22. Lagrangian Twin Support Vector Regression(LTSVR)

## Running the codes  
The ideal set of parameters can be found using `Grid_Searcher.m` (wherever applicable), and the final results can be inferenced from `Main_Code.m`.  

## Citation  
If you intend to use this work, kindly cite us as follows:  

@ARTICLE{9439893,  
  author={Beheshti, Iman and Ganaie, M.A. and Paliwal, Vardhan and Rastogi, Aryan and Razzak, Imran and Tanveer, M.},  
  journal={IEEE Journal of Biomedical and Health Informatics},   
  title={Predicting brain age using machine learning algorithms: A comprehensive evaluation},   
  year={2021},  
  volume={},  
  number={},  
  pages={1-1},  
  doi={10.1109/JBHI.2021.3083187}}  
  

## Acknowledgements
The codes have been written in MATLAB&reg; and tested on versions R2020b and above. We would like to express our gratitude to the respective authors for using their works. 


