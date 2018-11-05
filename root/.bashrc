export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ..="cd .."
alias ...="cd ../.."
alias a="php artisan"
alias my="mysql -h mysql health"

function hostip() {
    /sbin/ip route|awk '/default/ { print $3 }'
}
