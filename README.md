# Jolly Green

Based on the [Arma 3 mission made by Shuko](https://steamcommunity.com/sharedfiles/filedetails/?id=450865369)

Creates an Arma 3 mod with all flavours of the Jolly Green mission with different mods and worlds.

## Building

1. Install [HEMTT](https://github.com/BrettMayson/HEMTT) and [Node.js](https://nodejs.org/en/)

2. Run `npm install` to install Node.js dependencies required for building

3. Run `npm run build` to create all flavours of the Jolly Green mission

4. Run `hemtt build` to assemble the mod

## Adding a new mod

Update `mods.js` with a new object for your mod with suffix and classes for west and east.

## Adding a new world

Copy one of the existing missions from `worlds` folder.
Open it in the Arma 3 editor with your new desired and move the units and markers so that they are not underground and in relevant positions on the map i.e. and airfield.
Do not remove or change units!

Once your mission is ready copy it to the `worlds` folder.
The mission folder name should be the world suffix used by mission.
Add your new world to `worlds.json`.
