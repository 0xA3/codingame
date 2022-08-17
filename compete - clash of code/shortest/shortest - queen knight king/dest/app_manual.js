c=readline().split` `.map((e)=>e=='D'?e=8:e=='G'?e=9:e=='K'?e=10:e).reduce((s,a)=>s*1+a*1,0)%10
print(c==9?'Noufi':c==0?'Karaa':c)