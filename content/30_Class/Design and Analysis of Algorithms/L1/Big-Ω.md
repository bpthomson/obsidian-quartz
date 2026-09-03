---
created: 2026-08-23T13:57:46+08:00
updated: 2026-08-24T00:17:23+08:00
---
# A lower bound indicating that a function grows no slower than another, up to a constant factor
### Formal Definition
We say $f \in \Omega (g)$ if:
$$\exists c > 0,\; \exists n_0 > 0,\; s.t. \; \forall n\ge n_0, \; f(n) \ge c\cdot g(n),$$
#### Example
- $n^3 \in \Omega(n^2)$
- $n^2 \in \Omega(n^2)$ -> ==this is what makes it different from [[Little-ω]]==
- $n^2 \cdot \lg(n) \in \Omega(n^2)$