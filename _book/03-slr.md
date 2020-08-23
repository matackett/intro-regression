---
title: "Simple Linear Regression"
output:
  pdf_document:
    number_sections: yes
  html_document: default
---

# Distribution Theory {#ch-distthry}

## Learning Objectives



## Derivation for $\hat{\beta}_0$ and $\hat{\beta}_1$ 

This document contains the mathematical details for deriving the least-squares estimates for slope ($\beta_1$) and intercept ($\beta_0$). We obtain the estimates, $\hat{\beta}_1$ and $\hat{\beta}_0$ by finding the values that minimize the sum of squared residuals (\ref{ssr}).

\begin{equation}
\label{ssr}
SSR = \sum\limits_{i=1}^{n}[y_i - \hat{y}_i]^2 = [y_i - (\hat{\beta}_0 + \hat{\beta}_1 x_i)]^2 = [y_i - (\hat{\beta}_0 - \hat{\beta}_1 x_i]^2
\end{equation}

Recall that we can find the values of $\hat{\beta}_1$ and $\hat{\beta}_0$ that minimize (\ref{ssr}) by taking the partial derivatives of (\ref{ssr}) and setting them to 0. Thus, the values of $\hat{\beta}_1$ and $\hat{\beta}_0$ that minimize the respective partial derivative also minimize the sum of squared residuals. The partial derivatives are

\begin{equation}
\label{par-deriv}
\begin{aligned}
&\frac{\partial \text{SSR}}{\partial \hat{\beta}_1} = -2 \sum\limits_{i=1}^{n}x_i(y_i - \hat{\beta}_0 - \hat{\beta}_1 x_i)  \\[10pt]
&\frac{\partial \text{SSR}}{\partial \hat{\beta}_0} = -2 \sum\limits_{i=1}^{n}(y_i - \hat{\beta}_0 - \hat{\beta}_1 x_i)
\end{aligned}
\end{equation}

Let's begin by deriving $\hat{\beta}_0$. 

\begin{equation}
\label{est-beta0}
\begin{aligned}
\frac{\partial \text{SSR}}{\partial \hat{\beta}_0} &= -2 \sum\limits_{i=1}^{n}(y_i - \hat{\beta}_0 - \hat{\beta}_1 x_i) = 0 \\[10pt]
&\Rightarrow -\sum\limits_{i=1}^{n}(y_i + \hat{\beta}_0 + \hat{\beta}_1 x_i) = 0 \\[10pt]
&\Rightarrow - \sum\limits_{i=1}^{n}y_i + n\hat{\beta}_0 + \hat{\beta}_1\sum\limits_{i=1}^{n}x_i = 0 \\[10pt]
&\Rightarrow n\hat{\beta}_0  = \sum\limits_{i=1}^{n}y_i - \hat{\beta}_1\sum\limits_{i=1}^{n}x_i \\[10pt]
&\Rightarrow \hat{\beta}_0  = \frac{1}{n}\Big(\sum\limits_{i=1}^{n}y_i - \hat{\beta}_1\sum\limits_{i=1}^{n}x_i\Big)\\[10pt]
&\Rightarrow \hat{\beta}_0  = \bar{y} - \hat{\beta}_1 \bar{x} \\[10pt]
\end{aligned}
\end{equation}

Now, we can derive $\hat{\beta}_1$ using the $\hat{\beta}_0$ we just derived

\begin{equation}
\label{est-beta1-pt1}
\begin{aligned}
&\frac{\partial \text{SSR}}{\partial \hat{\beta}_1} = -2 \sum\limits_{i=1}^{n}x_i(y_i - \hat{\beta}_0 - \hat{\beta}_1 x_i) = 0  \\[10pt]
&\Rightarrow -\sum\limits_{i=1}^{n}x_iy_i + \hat{\beta}_0\sum\limits_{i=1}^{n}x_i + \hat{\beta}_1\sum\limits_{i=1}^{n}x_i^2 = 0 \\[10pt]
\text{(Fill in }\hat{\beta}_0\text{)}&\Rightarrow -\sum\limits_{i=1}^{n}x_iy_i + (\bar{y} - \hat{\beta}_1\bar{x})\sum\limits_{i=1}^{n}x_i + \hat{\beta}_1\sum\limits_{i=1}^{n}x_i^2 = 0 \\[10pt]
&\Rightarrow  (\bar{y} - \hat{\beta}_1\bar{x})\sum\limits_{i=1}^{n}x_i + \hat{\beta}_1\sum\limits_{i=1}^{n}x_i^2 = \sum\limits_{i=1}^{n}x_iy_i \\[10pt]
&\Rightarrow \bar{y}\sum\limits_{i=1}^{n}x_i - \hat{\beta}_1\bar{x}\sum\limits_{i=1}^{n}x_i + \hat{\beta}_1\sum\limits_{i=1}^{n}x_i^2 = \sum\limits_{i=1}^{n}x_iy_i \\[10pt]
&\Rightarrow n\bar{y}\bar{x} - \hat{\beta}_1n\bar{x}^2 + \hat{\beta}_1\sum\limits_{i=1}^{n}x_i^2 = \sum\limits_{i=1}^{n}x_iy_i \\[10pt]
&\Rightarrow \hat{\beta}_1\sum\limits_{i=1}^{n}x_i^2 - \hat{\beta}_1n\bar{x}^2  = \sum\limits_{i=1}^{n}x_iy_i - n\bar{y}\bar{x} \\[10pt]
&\Rightarrow \hat{\beta}_1\Big(\sum\limits_{i=1}^{n}x_i^2 -n\bar{x}^2\Big)  = \sum\limits_{i=1}^{n}x_iy_i - n\bar{y}\bar{x} \\[10pt] 
&\hat{\beta}_1 = \frac{\sum\limits_{i=1}^{n}x_iy_i - n\bar{y}\bar{x}}{\sum\limits_{i=1}^{n}x_i^2 -n\bar{x}^2}
\end{aligned}
\end{equation}

To write $\hat{\beta}_1$ in a form that's more recognizable, we will use the following: 

\begin{equation}
\label{cov}
\sum x_iy_i - n\bar{y}\bar{x} = \sum(x - \bar{x})(y - \bar{y}) = (n-1)\text{Cov}(x,y)
\end{equation}

\begin{equation}
\label{var_x}
\sum x_i^2 - n\bar{x}^2 - \sum(x - \bar{x})^2 = (n-1)s_x^2
\end{equation}

where $\text{Cov}(x,y)$ is the covariance of $x$ and $y$, and $s_x^2$ is the sample variance of $x$ ($s_x$ is the sample standard deviation).

Thus, applying (\ref{cov}) and (\ref{var_x}), we have 

\begin{equation}
\label{est-beta1-pt2}
\begin{aligned}
\hat{\beta}_1 &= \frac{\sum\limits_{i=1}^{n}x_iy_i - n\bar{y}\bar{x}}{\sum\limits_{i=1}^{n}x_i^2 -n\bar{x}^2} \\[10pt]
&= \frac{\sum\limits_{i=1}^{n}(x-\bar{x})(y-\bar{y})}{\sum\limits_{i=1}^{n}(x-\bar{x})^2}\\[10pt]
&= \frac{(n-1)\text{Cov}(x,y)}{(n-1)s_x^2}\\[10pt]
&= \frac{\text{Cov}(x,y)}{s_x^2}
\end{aligned}
\end{equation}



The correlation between $x$ and $y$ is $r = \frac{\text{Cov}(x,y)}{s_x s_y}$. Thus, $\text{Cov}(x,y) = r s_xs_y$. Plugging this into (\ref{est-beta1-pt2}), we have 

\begin{equation}
\hat{\beta}_1 = \frac{\text{Cov}(x,y)}{s_x^2} = r\frac{s_ys_x}{s_x^2} = r\frac{s_y}{s_x}
\end{equation}












