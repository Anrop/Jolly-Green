pipeline {
    agent {
        label 'mikero'
    }

    stages {
        stage('Install') {
            steps {
                bat 'npm install' 
            }
        }

        stage('Build') {
            steps {
                bat 'npm run build'
                bat 'hemtt build --release' 
            }
        }

        stage('Archive Build') {
            steps {
                archiveArtifacts artifacts: 'releases/0.0.0/@anrop_jolly_green/**/*'
            }
        }

        stage('Publish to Steam Workshop') {
            when {
                branch 'master'
            }

            steps {
                publishSteamWorkshop '1818018494', 'releases/0.0.0/@anrop_jolly_green', env.GIT_COMMIT
            }
        }
    }
}

void publishSteamWorkshop(String id, String mod, String changeNote) {
    bat "\"C:\\Program Files (x86)\\Steam\\SteamApps\\common\\Arma 3 Tools\\Publisher\\PublisherCmd.exe\" update /changeNote:$changeNote /id:$id /path:$mod"
}
