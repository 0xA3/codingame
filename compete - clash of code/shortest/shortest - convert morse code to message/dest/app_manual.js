let t=readline().split(" "),r=+readline(),n=[],a=[],l=0;for(;l<r;){++l;let t=readline().split(" ");n.push(t[0]),a.push(t[1])}let i=[],s=0;for(;s<t.length;){let e=t[s];++s,"/"==e?i.push(" "):a.includes(e)?i.push(n[a.indexOf(e)]):i.push("[]")}print(i.join(""))