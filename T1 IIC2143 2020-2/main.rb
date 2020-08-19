# Importaciones
require_relative 'funciones'

# ARGVS
carpeta = ARGV[0]
instrucciones = ARGV[1]
output = ARGV[2]
# carpeta = "data"
# instrucciones = "instructions.txt"
# output = "output.txt"

# Cargado de los datos
array_alumnos = procesar_alumnos("#{carpeta}/alumnos.csv")
array_ayudantes = procesar_ayudantes("#{carpeta}/ayudantes.csv")
array_grupos = procesar_grupos("#{carpeta}/grupos.csv")

# Apertura y respuesta a archivo de instrucciones
File.open(instrucciones, "r").each do |instruccion|
  if instruccion == "aprobados\n"
    agregar_lineas(output, aprobados(array_alumnos, array_grupos))
  elsif instruccion == "reprobados\n"
    agregar_lineas(output, reprobados(array_alumnos, array_grupos))
  elsif instruccion == "proyecto\n"
    agregar_lineas(output, proyecto(array_alumnos, array_ayudantes))
  elsif instruccion == "top_grupos\n"
    agregar_lineas(output, top_grupos(array_grupos))
  elsif instruccion == "top_ayudante\n"
    agregar_lineas(output, top_ayudante(array_ayudantes, array_grupos))
  end
end