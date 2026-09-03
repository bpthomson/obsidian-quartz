---
created: 2026-08-23T13:57:46+08:00
updated: 2026-08-24T00:17:20+08:00
---
# An tight bound indicating that a function grows as fast as another, up to a constant factor
### Formal Definition
We say $f \in \Theta(g)$ if:
$$\exists c_1,c_2 > 0,\; \exists n_0 > 0,\; s.t. \; \forall n\ge n_0, \; c_1 \cdot g(n) \le f(n) \le c_2\cdot g(n),$$
#### Example
- $n^2 \notin \Theta(n^3)$
- $n^2 \in \Theta(n^2)$
- $n^2 \in \Theta(2n^2)$