---
created: 2026-08-23T13:57:46+08:00
updated: 2026-08-24T00:17:23+08:00
---
# An upper bound indicating that a function grows strictly slower than another, becoming negligible in comparison as $n \to \infty$.
### Formal Definition
We say $f \in o(g)$ if:
$$\forall c > 0,\; \exists n_0 > 0,\; s.t. \; \forall n\ge n_0, \; f(n)<c\cdot g(n),$$

### Limit Test
We say $f \in o(g)$ if:
$$\lim_{n \to \infty} \frac{f(n)}{g(n)} = 0$$
#### Example
- $n^2 \in o(n^3)$
- $n^2 \notin o(n^2)$ -> ==this is what makes it different from [[Big-O]]==
- $n^2 \in o(n^2 \cdot \lg(n))$