function gyolo --wraps="git add * && git commit -m 'update' && git push" --description "alias gyolo=git add * && git commit -m 'update' && git push"
    git add * && git commit -m 'update' && git push $argv
end
