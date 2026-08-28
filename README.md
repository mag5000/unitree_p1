=================================================
==========   Entrar al contenedor  ==============

# Dar permisos a la interfaz gráfica X11
xhost +local:root

# Ir al directorio del proyecto
cd ~/ros2_unitree

# Reconstruir la imagen (solo la primera vez o tras modificar el Dockerfile)
docker compose build

# Levantar el contenedor en segundo plano
docker compose up -d

# Entrar al contenedor
docker compose exec unitree_mujoco bash


=================================================
==========    Iniciar simulación   ==============

# Ir a la carpeta del simulador y ejecutarlo
cd /workspace/unitree_mujoco/simulate_python
python3 unitree_mujoco.py


=================================================
===========    Cerrar contenedor   ==============

# Cerrar
docker compose down
