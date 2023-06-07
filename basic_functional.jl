using OptimalControl

# Parameters
t0 = 0
tf = 1

A = [ 0 1
      0 0 ]
B = [ 0
      1 ]

# Functional model
ocp = Model()

time!(ocp, [t0, tf])
state!(ocp, 2)
control!(ocp, 1)

constraint!(ocp, :initial, [ -1, 0 ])
constraint!(ocp, :final,   [  0, 0 ])

dynamics!(ocp, (x, u) -> A*x + B*u)

objective!(ocp, :lagrange, (x, u) -> 0.5u^2)

# Solve
sol = solve(ocp, grid_size=50)

# Plot
plot(sol)