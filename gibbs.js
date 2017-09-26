var jStat = require('jStat').jStat;

function gibbs(N, thin) {
    var x = 0;
    var y = 0;
    console.log("Iter  x  y");
    for (i=0;i<N;i++) {
        for (j=0;j<thin;j++) {
            // POSSIBLE PROBLEM: 1/scale instead of scale?
            x=jStat.gamma.sample(3, 1.0/(y*y+4));
            y=jStat.normal.sample(1.0/(x+1), 1.0/Math.sqrt(2*x+2));
        }
        console.log(i, x, y);
    }
}

gibbs(50000, 1000);
