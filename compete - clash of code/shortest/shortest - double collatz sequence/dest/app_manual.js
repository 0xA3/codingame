let m=(t)=>{let r=1;for(;t>1;)t%2==0?t/=2:t=3*t+1,++r;return r};print(m(m(parseFloat(readline()))))