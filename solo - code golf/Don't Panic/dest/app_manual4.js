s=()=>readline().split(0),t=s(),r=+t[7],a=[],n=0;for(;n<r;){++n;let t=s();a[+t[0]]=+t[1]}for(a[r]=+t[4];;){let t=s(),r=+t[1],n=t[2][0],e=a[+t[0]]
print("L"==n&&e>r||"R"==n&&e<r?"BLOCK":"WAIT")}