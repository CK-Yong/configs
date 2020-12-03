export ZSH="/Users/cyong/.oh-my-zsh"

autoload -Uz compinit && compinit

ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    )

source $ZSH/oh-my-zsh.sh


##########################
### My custom commands ###
##########################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR="code -w"

PATH=$PATH:/usr/local/anaconda3/bin:$HOME/bin

alias chrome-no-cors='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security --ignore-certificate-errors'

alias update-aks-credentials='az aks get-credentials --resource-group test-environment-freemium-we-cai --name test-aks-environment-we --overwrite-existing && \
az aks get-credentials --resource-group testw-environment-freemium-we-cai --name testw-aks-environment-we --overwrite-existing && \
az aks get-credentials --resource-group acc-environment-freemium-we-cai --name acc-aks-environment-we --overwrite-existing && \
az aks get-credentials --resource-group accw-environment-freemium-we-cai --name accw-aks-environment-we --overwrite-existing && \
az aks get-credentials --resource-group prdw-environment-freemium-we-cai --name prdw-aks-environment-we --overwrite-existing && \
az aks get-credentials --resource-group prdn-environment-freemium-ne-cai --name prdn-aks-environment-ne --overwrite-existing'

clean()
{
    echo Cleaning all bin and obj folders from "$1"
    find "$1" -iname "bin" -o -iname "obj" | xargs rm -rf
}

alias show-bytes='od -c'

alias docker-kill-all='docker container kill $(docker ps -q)'
alias docker-clean-all='docker container rm $(docker ps -a -q)'

kubectl-restart(){
    kubectl patch deployment "$1" -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"restartedAt\":\"$(date +%s)\"}}}}}" -n $2
}

kubectl-clean(){
    kubectl get po -n $1 --field-selector 'status.phase!=Running' -o json | kubectl delete -f - -n $1
}

kubectl-pod-containers(){
    kubectl get pods $1 -n $2 -o jsonpath='{.spec.containers[*].name}*'
}

flushdns(){
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
}

argo-workflows(){
    open -a "Google Chrome.app" http://localhost:2746/workflows/watch &
    kubectl port-forward svc/argoworkflows-server -n argo 2746:2746 
}
