using Distributions

function gibbs(N, thin)
    x = 0
    y = 0
    println("Iter  x  y")
    i = 0
    for i = 1:N
        for j = 0:thin
            x = rand(Gamma(3, 1.0/(y*y+4)))
            y = rand(Normal(1.0/(x+1), 1/sqrt(2*x+2)))
        end
        println(i, ' ', x, ' ', y)
    end
end

gibbs(50000, 1000)
