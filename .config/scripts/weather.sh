#!/bin/sh

get_icon() {
    case $1 in
        # Icons for Font Awesome (Solid style, black and white)
        01d) icon="&#xf185;";;  # Sun
        01n) icon="&#xf186;";;  # Moon
        02d) icon="&#xf6c4;";;  # Cloud Sun
        02n) icon="&#xf6c5;";;  # Cloud Moon
        03d) icon="&#xf013;";;  # Cloud
        03n) icon="&#xf013;";;  # Cloud
        04*) icon="&#xf013;";;  # Cloud
        09*) icon="&#xf2dc;";;  # Snowflake
        10d) icon="&#xf185;";;  # Sun
        10n) icon="&#xf186;";;  # Moon
        11*) icon="&#xf73b;";;  # Showers
        13*) icon="&#xf2dc;";;  # Snowflake
        50*) icon="&#xf0e7;";;  # Smog
        *) icon="&#xf128;";;  # Question Circle   
	esac

    echo $icon
}

KEY="e434b5435a979de6e155570590bee89b"
CITY="Cheboksary"
UNITS="metric"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi

    weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        weather=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi

if [ -n "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

    icon=$(get_icon "$weather_icon")
    echo "$icon $weather_temp$SYMBOL"
fi

