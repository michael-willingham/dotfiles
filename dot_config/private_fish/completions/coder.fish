
function _coder_completions
	# Capture the full command line as an array
	set -l args (commandline -opc)
	set -l current (commandline -ct)
    COMPLETION_MODE=1 $args $current
end

# Setup Fish to use the function for completions for 'coder'
complete -c coder -f -a '(_coder_completions)'
