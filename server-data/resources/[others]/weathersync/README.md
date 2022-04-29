# RedM weather and time sync

## Features

- Syncs time and weather for all players

- Configurable weather pattern

- Weather is queued so players can get a forecast of upcoming weather

- Different weather for different regions

- Adjustable timescale

## Examples

| Forecast and admin UI | Region-specific weather | Adjustable timescale |
|---|---|---|
| [![Forecast and admin UI](https://i.imgur.com/Scn0z0Em.jpg)](https://imgur.com/Scn0z0E) | [![Region-specific weather](https://i.imgur.com/Loif9SMm.jpg)](https://imgur.com/Loif9SM) | [![Adjustable timescale](https://i.imgur.com/WkqHAs4m.jpg)](https://imgur.com/WkqHAs4) |

## Commands

| Command      | Description                                               |
|--------------|-----------------------------------------------------------|
| `/forecast`  | Displays a forecast of upcoming weather.                  |
| `/syncdelay` | Set how often the server syncs with clients.              |
| `/time`      | Set the server time.                                      |
| `/timescale` | Set the ratio of in-game seconds to real-time seconds.    |
| `/weather`   | Set the server weather.                                   |
| `/weatherui` | Opens the admin UI for changing the time/weather/wind.    |
| `/wind`      | Set the wind direction and base speed.                    |

## Configuration

| Variable                 | Description                                         | Example                               |
|--------------------------|-----------------------------------------------------|---------------------------------------|
| `Config.Time`            | Initial time when the resource starts.              | `HMSToTime(6, 0, 0)` (06:00:00)       |
| `Config.Timescale`       | Initial timescale when the resource starts          | `30.0` (30 in-game secs per real sec) |
| `Config.TimeIsFrozen`    | Whether time is frozen when the resource starts.    | `false`                               |
| `Config.Weather`         | Initial weather when the resource starts.           | `'sunny'`                             |
| `Config.WeatherInterval` | How often the weather changes.                      | `HMSToTime(1, 0, 0)` (1 in-game hour) |
| `Config.WeatherIsFrozen` | Whether weather is frozen when the resource starts. | `false`                               |
| `Config.MaxForecast`     | Number of weather intervals to queue up.            | `23` (24-hour forecast)               |
| `Config.WindDirection`   | Initial wind direction when the resource starts.    | `0.0` (North)                         |
| `Config.WindSpeed`       | Initial base wind speed when the resource starts.   | `0.0`                                 |
| `Config.WindIsFrozen`    | Whether wind direction/speed are frozen.            | `false`                               |
| `Config.SyncDelay`       | How often in ms to sync with clients.               | `5000`                                |
| `Config.WeatherPattern`  | A table describing the the weather pattern.         | See [config.lua](config.lua)          |
| `Config.WeatherIcons`    | Icons to use for each weather type in the forecast. | See [config.lua](config.lua)          |
