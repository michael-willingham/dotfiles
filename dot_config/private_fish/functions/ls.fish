function ls --wraps='eza -lh --icons' --description 'alias ls=eza -lh --icons'
  eza -lho --git --icons $argv
        
end
