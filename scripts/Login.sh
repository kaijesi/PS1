function login {
    read -p " Which alias? : " alias
    read -p " Which sandbox (y/n)? : " issandbox
    sandboxstr=""
    if [[ "$issandbox" =~ ^(yes|y)$ ]] ; then
        sandboxstr=" -r https://test.salesforce.com"
    else 
        sandboxstr=
    fi
    run "sfdx force:auth:web:login -a $alias $sandboxstr"       
}