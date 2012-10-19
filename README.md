xampphost
=========


## Automatic creation of new hosts for XAMPP/Mac

Script creates new directory and subdirectory 'www' in a directory, where you store your web projects. Then, adds this directory to XAMPP vhosts file and creates hostname, adds hostname to `/etc/hosts` and restarts XAMPP's Apache. 

### Usage

1. Download xampphost.sh
2. Make it executable (`chmod +x xampphost.sh`)
3. Edit file, configure path to your project folder and XAMPP location
4. Run: `sudo ./xampphost.sh newhost`

Script will create directory `newhost/www` in your webproject folder and adds 2 hosts newhost and newhost.dev. Also it creates basic index.html file to show it works.

