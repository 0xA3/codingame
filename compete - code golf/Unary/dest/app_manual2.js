a=i=e="",s=t=0,r=readline();for(;t<r.length;)e+=(256+r.charCodeAt(t++)).toString(2).substr(-7);for(;s<e.length;){let r=e[s++];r==i?a+=0:(i=r,a+="1"==r?" 0 0":" 00 0")}print(a.substr(1))