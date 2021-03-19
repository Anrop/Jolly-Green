const spawn = require('child_process').spawn
const fs = require('fs-extra')
const path = require('path')

const mods = require('./mods')
const worlds = require('./worlds')

const outputDirectory = path.join('addons', 'missions')
const baseMissionDirectory = 'mission'
const worldsDirectory = 'worlds'

const pboPrefix = 'anrop_jolly_green_missions'
const configFileCfgPatches = `class CfgPatches
{
  class anrop_jolly_green_missions
  {
    units[] = {};
    weapons[] = {};
    requiredVersion = 1.0;
    requiredAddons[] = {"A3_Data_F"};
    addonRootClass = "A3_Data_F";
  };
};`

function createConfigFile (missions) {
  const configFile = path.join(outputDirectory, 'config.cpp')
  const missionsClasses = missions.map((mission) =>
    `    class ${mission.split('.')[0]}
    {
      directory = "${pboPrefix}\\${mission}";
    };`
  ).join('\n')
  const configFileContent = `${configFileCfgPatches}
class CfgMissions
{
  class MPMissions
  {
${missionsClasses}
  };
};
`

  return writeFile(configFile, configFileContent)
}

function createPboPrefixFile () {
  const pboPrefixFile = path.join(outputDirectory, '$PBOPREFIX$')
  return writeFile(pboPrefixFile, pboPrefix)
}

function replaceUnits (content, units) {
  if (!units) {
    return content
  }

  for (const originalClass in units) {
    const replacementClass = units[originalClass]
    content = content.replace(new RegExp(originalClass, 'g'), replacementClass)
  }
  return content
}

function updateDescriptionFile (descriptionFile, mod) {
  return readFile(descriptionFile)
    .then((content) => content.replace('CSAR Jolly Green 28', `CSAR Jolly Green 28 (${mod.name})`))
    .then((content) => content.replace('CSAR JOLLY GREEN 28', `CSAR JOLLY GREEN 28 (${mod.name})`))
    .then((content) => writeFile(descriptionFile, content))
}

function updateInitServerFile (initServerFile, mod, type) {
  const units = mod[type] || mod.woodland || {}

  return readFile(initServerFile)
    .then((content) => replaceUnits(content, units.redfor))
    .then((content) => writeFile(initServerFile, content))
}

function updateMissionFile (missionFile, mod, type) {
  const units = mod[type] || mod.woodland || {}

  return readFile(missionFile)
    .then((content) => content.replace('CO 11 CSAR Jolly Green 28', `CO 11 CSAR Jolly Green 28 (${mod.name})`))
    .then((content) => replaceUnits(content, units.blufor))
    .then((content) => writeFile(missionFile, content))
}

function updateParaTroopsFile (paraTroopsFile, mod, type) {
  const units = mod[type] || mod.woodland || {}

  return readFile(paraTroopsFile)
    .then((content) => replaceUnits(content, units.redfor))
    .then((content) => writeFile(paraTroopsFile, content))
}

function updateMission (missionDirectory, mod, type) {
  const descriptionFile = path.join(missionDirectory, 'description.ext')
  const initServerFile = path.join(missionDirectory, 'init_server.sqf')
  const missionFile = path.join(missionDirectory, 'mission.sqm')
  const paraTroopsFile = path.join(missionDirectory, 'paraTroops.sqf')

  return Promise.all([
    updateDescriptionFile(descriptionFile, mod),
    updateInitServerFile(initServerFile, mod, type),
    updateMissionFile(missionFile, mod, type),
    updateParaTroopsFile(paraTroopsFile, mod, type)
  ])
}

function createWorldVersions (world) {
  return Promise.all(mods.map((mod) => {
    const missionDirectoryName = `jolly_green${mod.suffix}_${world.name}.${world.name}`
    const missionWorldDirectory = path.join(worldsDirectory, world.mission)
    const missionWorldFile = path.join(missionWorldDirectory, 'mission.sqm')
    const missionOutputDirectory = path.join(outputDirectory, missionDirectoryName)
    const missionOutputFile = path.join(missionOutputDirectory, 'mission.sqm')

    return fs.emptyDir(missionOutputDirectory)
      .then(() => fs.copy(baseMissionDirectory, missionOutputDirectory))
      .then(() => fs.copy(missionWorldFile, missionOutputFile))
      .then(() => updateMission(missionOutputDirectory, mod, world.type))
      .then(() => missionDirectoryName)
  }))
}

function createWorlds () {
  return fs.emptyDir(outputDirectory)
    .then(() => Promise.all(worlds.map(createWorldVersions)))
    .then((missions) => flatten(missions))
    .then((missions) => createConfigFile(missions))
    .then(() => createPboPrefixFile())
}

function readFile (file) {
  return new Promise((resolve, reject) => {
    fs.readFile(file, { encoding: 'utf8' }, (err, content) => {
      if (err) {
        return reject(err)
      }

      return resolve(content)
    })
  })
}

function writeFile (file, content) {
  return new Promise((resolve, reject) => {
    fs.writeFile(file, content, { encoding: 'utf8' }, (err) => {
      if (err) {
        return reject(err)
      }

      return resolve()
    })
  })
}

const flatten = list => list.reduce(
    (a, b) => a.concat(Array.isArray(b) ? flatten(b) : b), []
)

createWorlds()
