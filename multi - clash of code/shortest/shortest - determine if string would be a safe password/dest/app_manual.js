e=readline(),r=0,t=0,n=0,a=0,i=e.length;for(;a<i;){let i=e.charCodeAt(a++);i>=48&&i<=57&&++r,i>=97&&i<=122&&++t,i>=65&&i<=90&&++n}print(e.length>7&&r>0&&t>0&&n>0)

// regex solution
// s=readline()
// f=x=>x.test(s)
// print(s.length>7&&f(/\d/)&&f(/[a-z]/)&&f(/[A-Z]/))