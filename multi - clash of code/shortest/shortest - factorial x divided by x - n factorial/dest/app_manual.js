let t=+readline(),r=+readline(),l=(t)=>{if(0==t)return 1;let r=t,e=1;for(;e<t;)r*=e++;return r};print(l(t)/l(t-r))

/*
function f(k){return k>1?k*f(--k):1}
x=readline()
print(f(x)/f(x-readline()))
*/