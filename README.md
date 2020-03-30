# Development environment

 # Requirements: 
- Virtualbox 6.1 <br/>
- Vagrant

# Steps to follow:
 1. Clone this repo into your host machine by running: <br/>
    - `vagrant up`

 2. Log into the virtual machine using the following credentials: <br/>
    - `username: vagrant`
    - `password: vagrant`

3. Run the provisioning script: <br/>
    - `sudo ./scripts/dev-env.sh`

4. Once the script has finished run execute the following command: <br/>

    - `sudo shutdown now -r`

5. After the environment has restarted run the following commands: <br/>
    - `./scripts/virtualbox-setup.sh`

    - `./scripts/practicum-setup.sh`