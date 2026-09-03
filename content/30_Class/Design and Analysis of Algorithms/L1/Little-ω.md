---
created: 2026-08-23T13:57:46+08:00
updated: 2026-08-24T00:17:24+08:00
---
# A lower bound indicating that a function grows strictly faster than another, dominating it completely as $n \to \infty$.
### Formal Definition
We say $f \in \omega (g)$ if:
$$\forall c > 0,\; \exists n_0 > 0,\; s.t. \; \forall n\ge n_0, \; f(n)>c\cdot g(n),$$

### Limit Test
We say $f \in \omega(g)$ if:
$$\lim_{n \to \infty} \frac{f(n)}{g(n)} = \infty$$
#### Example
- $n^3 \in \omega(n^2)$
- $n^2 \notin \omega(n^2)$ -> ==this is what makes it different from [[Big-Ω]]==
- $n^2 \cdot \lg(n) \in \omega(n^2)$