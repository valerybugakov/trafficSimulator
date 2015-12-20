# TrafficSimulator

Traffic simulator and road lights adjuster using
[Intelligent Driver Model](https://en.wikipedia.org/wiki/Intelligent_driver_model)
and lane-changing model MOBIL. Written in CoffeeScript and HTML5.

Currently it provides only simulator with visualizer but in future releases
traffic lights optimizer will be added to construct best possible schedule and
avoid traffic jams.

## Usage

* Mouse and wheel - scrolling and zoom
* shift + click -- create intersection
* shift + drag from one intersection to another -- create road
* command + click -- create building

Or just press generateMap in control panel and add cars with carsNumber slider.

## Build
To run simulator

```sh
npm install
npm run start
```
