# -*- mode: ruby -*-
# vi: set ft=ruby :

# ##############################################################################
#
# Ejemplo de creación de VM compatibles con MAC M1, M2, M2...
# utilizando Vagrant y VirtualBox.
#
#    user:root            |         user:vagrant
#    pass:vagrant         |         pass:vagrant
#
#  @author    Óscar Novás (oscarnovas.com)
#  @version   v1.0.0
#  @license   GNU/GPL v3+
# ##############################################################################

# Configuración de directorios
STORAGE_DIR = './.vagrant/storage'

Vagrant.configure("2") do |config|

  # ############################################################################
  # CONFIGURACIÓN GENERAL.
  # ############################################################################
  config.vm.boot_timeout = 1200

  # Deshabilitar Guest Additions automáticas
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.installer_options = { allow_kernel_upgrade: true }
  end

  # Crear directorio storage si no existe
  Dir.mkdir(STORAGE_DIR) unless Dir.exist?(STORAGE_DIR)

  # Configurar la caja por defecto
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 2
    vb.customize ['modifyvm', :id, '--groups', '/LPI', '--cableconnected1', 'on']
    # Crear controlador SATA si no existe
    vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--controller', 'IntelAHCI']
  end

  # ############################################################################
  # SINCRONIZACIÓN DE CARPETAS.
  # ############################################################################

  # RECOMENDACIONES USUARIOS MAC SILICON (M1, M2...):
  # - Las carpetas compartidas tipo "virtualbox" no funcionan bien
  #   por lo que se recomienda usar "nfs" o "rsync".
  # - Si el proyecto está alojado en un disco duro externo "nfs" no funcionará,
  #   por lo que se recomienda usar "rsync".

  # DESHABILITAR carpetas compartidas por defecto de VirtualBox
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Carpeta compartida tipo "virtualbox".
  # config.vm.synced_folder "./html", "/var/www/html",
  #   type: "virtualbox"

  # Carpeta compartida tipo "nfs".
  # config.vm.synced_folder "./html", "/var/www/html",
  #   type: "nfs",
  #   nfs_udp: false,
  #   nfs_version: 3

  # Carpeta compartida tipo "rsync".
  # No sincroniza automáticamente, hay que ejecutar:
  # - `vagrant rsync <maquina>`          sincronizar HOST -> VM.
  # - `vagrant rsync-back <maquina>`     sincronizar VM -> HOSTS.
  config.vm.synced_folder "./html", "/var/www/html",
    type: "rsync",
    rsync__auto: true,
    rsync__exclude: [".git/", ".DS_Store"]

  # ############################################################################
  # ROCKY LINUX.
  # ############################################################################
  config.vm.define "rocky" do |rocky|
    rocky.vm.box = "bento/rockylinux-9"
    rocky.vm.hostname = "rocky"

    rocky.vm.network "private_network", ip: "192.168.33.10"
    # rocky.vm.network "forwarded_port", guest: 80, host: 8010
    # rocky.vm.network "forwarded_port", guest: 10000, host: 10010

    rocky.vm.provider "virtualbox" do |vb|
      vb.name = "Rocky"
      vb.memory = "4096"

      # Disco adicional 1 - 10GB
      rocky_disk = File.join(STORAGE_DIR, 'rocky-disk1.vdi')
      unless File.exist?(rocky_disk)
        vb.customize ['createhd', '--filename', rocky_disk, '--size', 10 * 1024]
      end
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', rocky_disk]
    end

    rocky.vm.provision "shell", path: "provision/rocky/_base.sh"
    rocky.vm.provision "shell", path: "provision/rocky/docker.sh"
    rocky.vm.provision "shell", path: "provision/rocky/webmin.sh"
    # rocky.vm.provision "shell", path: "provision/rocky/rocky-gui.sh"
  end


  # ############################################################################
  # DEBIAN.
  # ############################################################################
  config.vm.define "debian" do |debian|
    debian.vm.box = "koalephant/debian12"
    debian.vm.hostname = "debian"

    debian.vm.network "private_network", ip: "192.168.33.11"
    # debian.vm.network "forwarded_port", guest: 80, host: 8011
    # debian.vm.network "forwarded_port", guest: 10000, host: 10011

    debian.vm.provider "virtualbox" do |vb|
      vb.name = "Debian"
      vb.memory = "2048"

      # Disco adicional 1 - 10GB
      debian_disk = File.join(STORAGE_DIR, 'debian-disk1.vdi')
      unless File.exist?(debian_disk)
        vb.customize ['createhd', '--filename', debian_disk, '--size', 10 * 1024]
      end
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', debian_disk]
    end

    debian.vm.provision "shell", path: "provision/debian/_base.sh"
    debian.vm.provision "shell", path: "provision/debian/docker.sh"
    debian.vm.provision "shell", path: "provision/debian/webmin.sh"
  end

end
