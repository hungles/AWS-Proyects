#Usar la imagen oficial de Ubuntu para Docker (Ubuntu 24.1)
FROM ubuntu:oracular-20240527

#Argumento para tomar la ruta del home que ejecuta el build (en /home/admin/)
ARG USER_HOME

#Descargar paquetes necesarios para conectarse por SSH
RUN apt update && apt install -y sudo openssh-server

#Crear el usuario ansible y una contraseña
RUN useradd -m ansible && echo "ansible:123" | chpasswd

#Agregar el usuario ansible al grupo sudo
RUN usermod -aG sudo ansible

#Agregar las intrucciones al archivo .sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

#Crear la carpeta .ssh/ y el archivo authirized keys
RUN mkdir /home/ansible/.ssh; touch /home/ansible/.ssh/authorized_keys

#Copiar la llave publica de la maquina local en la carpeta ./ssh del usuario ansible
COPY ./id_rsa.pub /home/ansible/.ssh

#Copiar el contenido de la llave y borrar la llave
RUN cat /home/ansible/.ssh/id_rsa.pub >> /home/ansible/.ssh/authorized_keys

#Reiniciar el daemon de ssh
RUN /etc/init.d/ssh restart

#Definir el usuario por defecto
USER ansible

#Definir el directorio de trabajo
WORKDIR /home/ansible

#Comando al iniciar el contenedor
CMD ["/bin/bash"]

