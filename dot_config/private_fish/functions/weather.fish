function weather --description 'Display weather forecast for your current location'
    # Get public IP address
    set -l ip (curl -s https://ifconfig.me)
    
    if test -z "$ip"
        echo "Error: Could not determine IP address"
        return 1
    end
    
    # Get location from IP
    set -l location_json (curl -s "http://ip-api.com/json/$ip")
    
    # Extract city and region from JSON
    set -l city (echo $location_json | string match -r '"city":"([^"]+)"' | string split ':' -f2 | string trim -c '"')
    set -l region (echo $location_json | string match -r '"regionName":"([^"]+)"' | string split ':' -f2 | string trim -c '"')
    
    if test -z "$city"
        echo "Error: Could not determine location"
        return 1
    end
    
    # Format location for wttr.in (replace spaces with underscores)
    set -l location_formatted (echo "$city"_"$region" | string replace -a ' ' '_')
    
    echo "📍 Location: $city, $region"
    echo ""
    
    # Fetch and display weather
    curl -s "https://wttr.in/$location_formatted"
end
