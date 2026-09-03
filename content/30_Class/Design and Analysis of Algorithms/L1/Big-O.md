---
created: 2026-08-23T13:57:46+08:00
updated: 2026-08-24T00:17:21+08:00
---
# An upper bound indicating that a function grows no faster than another, up to a constant factor
### Formal Definition
We say $f \in O(g)$ if:
$$\exists c > 0,\; \exists n_0 > 0,\; s.t. \; \forall n\ge n_0, \; f(n) \le c\cdot g(n),$$
#### Example
- $n^2 \in O(n^3)$
- $n^2 \in O(n^2)$ -> ==this is what makes it different from [[Little-o]]==
- $n^2 \in O(n^2 \cdot \lg(n))$