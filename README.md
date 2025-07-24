# custom_hue_contact_sensor_control
A script to control what a Philips Hue Contact Sensor does when it is engaged/disengaged

Developed using the Philips Hue Developer Docs at https://developers.meethue.com/develop/hue-api-v2/getting-started/

Certificates can be found at https://developers.meethue.com/develop/application-design-guidance/using-https/

## Color Values

CIE Chromaticity Diagram: https://en.wikipedia.org/wiki/Chromaticity#/media/File:PlanckianLocus.png

```ruby
        "color": { "xy": { "x": 0.770, "y": 0.260 } } # red
        "color": { "xy": { "x": 0.590, "y": 0.430 } } # orange
        "color": { "xy": { "x": 0.530, "y": 0.450 } } # yellow
        "color": { "xy": { "x": 0.070, "y": 0.830 } } # green
        "color": { "xy": { "x": 0.175, "y": 0.000 } } # blue
        "color": { "xy": { "x": 0.270, "y": 0.030 } } # purple
```
