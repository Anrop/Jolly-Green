const fs = require('fs-extra')
const path = require('path')

const worlds = require('./worlds')

const outputDirectory = 'build'
const baseMissionDirectory = 'mission'
const worldsDirectory = 'worlds'

function createWorldVersions (world) {
  const { name, mission } = world

  const missionWorldDirectory = path.join(worldsDirectory, mission)
  const missionWorldFile = path.join(missionWorldDirectory, 'mission.sqm')
  const missionWorldOutputDirectory = path.join(outputDirectory, name)
  const missionWorldOutputFile = path.join(missionWorldOutputDirectory, 'mission.sqm')

  return fs.emptyDir(missionWorldOutputDirectory)
    .then(() => fs.copy(baseMissionDirectory, missionWorldOutputDirectory))
    .then(() => fs.copy(missionWorldFile, missionWorldOutputFile))
}

function createWorlds () {
  return fs.emptyDir(outputDirectory)
    .then(() => Promise.all(worlds.map(createWorldVersions)))
}

createWorlds()
