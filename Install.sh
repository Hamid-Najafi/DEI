# -------==========-------
# Pre Install
# -------==========-------
# Do everthing in Setup.sh script.
wget https://raw.githubusercontent.com/Hamid-Najafi/DEI/PreInstall.sh
chmod +x PreInstall.sh
sudo ./PreInstall.sh

# -------==========-------
# Docker
# -------==========-------
# Install Docker
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
curl -L --fail https://raw.githubusercontent.com/linuxserver/docker-docker-compose/master/run.sh -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker login

# -------==========-------
# Clone Repos
# -------==========-------
sudo git clone https://github.com/Hamid-Najafi/DEI.git

# -------==========-------
# Setup Traefik
# -------==========-------
mkdir -p ~/docker
cp -R ~/DEI/Traefik ~/docker/traefik
cd ~/docker/traefik 
nano docker-compose.yml 
# Set Host
    #   - "traefik.http.routers.traefik.rule=Host(`traefik.goldenstarc.ir`)"
docker network create web
docker-compose up -d

# -------==========-------
# Setup Website
# -------==========-------
# 1. Restore Database Using TablePlus App
# 2. Start Virgol Services
mkdir -p ~/docker/website
cp ~/DEI/Website/docker-compose.yml ~/docker/website/
cd ~/docker/website
docker-compose up -d

# -------==========-------
# Add New Master Admin
# -------==========-------
1. Restore postgres DB RAW

2. Config postgres settings

3. Check Openldap is working

4. Postman: 
A) LoginAdmin
B) AddNewMasterAdmin

5. Fullfill detail in database (AspNetUsers)

6. Postman: 
A) Sync LDAP with Virgol
B) Sync Virgol Moodle ID

7. Check
    Users: https://moodle.vir-gol.ir/admin/user.php
    Courses & Categories: https://moodle.vir-gol.ir/course/management.php

# -------==========-------
# Post install ToDo
# -------==========-------
1. Restore postgres DB (backup is in main directory)

2. Config postgres settings (any optimization if needed)

3. Check Openldap is working

4. Postman: Sync LDAP with Virgol

5. Restore moodle settings as documented 

6. Restore moodle ldap users 
docker exec -it virgol_moodle php ./bitnami/moodle/auth/ldap/cli/sync_users.php

7. Database: Set moodle token (SiteSettings)

8. Database: Set all moodleId => AdminDetails & Schools to -1, AspNetUsers to 0
UPDATE "AdminDetails" SET "orgMoodleId" = -1;
UPDATE "Schools" SET "Moodle_Id" = -1;
UPDATE "AspNetUsers" SET "Moodle_Id" = 0;

9. Postman: Sync Virgol Moodle ID

10. Postman: Recreate School Moodle (if want to fix admin without school, leave desiredSchoolId with random number)

11. Check
    Users: https://moodle.vir-gol.ir/admin/user.php
    Courses & Categories: https://moodle.vir-gol.ir/course/management.php
