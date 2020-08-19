# Importación
require_relative 'clases'
require 'csv'

########################################## Interacción con archivos

# Retorna una lista de instancias de grupo
def procesar_alumnos(path)
  array_alumnos = Array.new
  csv_alumnos = CSV.read(path)
  contador = 0
  csv_alumnos.each do |alumno|
    if contador == 0
      contador += 1
    else
      array_alumnos.append(Alumno.new(*alumno))
    end
  end
  array_alumnos
end

# Retorna una lista de instancias de ayudante
def procesar_ayudantes(path)
  array_ayudantes = Array.new
  csv_ayudantes = CSV.read(path)
  contador = 0
  csv_ayudantes.each do |ayudante|
    if contador == 0
      contador += 1
    else
      array_ayudantes.append(Ayudante.new(*ayudante))
    end
  end
  array_ayudantes
end

# Retorna una lista de instancias de grupo
def procesar_grupos(path)
  array_grupos = Array.new
  csv_grupos = CSV.read(path)
  contador = 0
  csv_grupos.each do |grupo|
    if contador == 0
      contador += 1
    else
      array_grupos.append(Grupo.new(*grupo))
    end
  end
  array_grupos
end

# Escribir el texto en el documento dado
def agregar_lineas(path, texto)
  File.open(path, "a") do |archivo|
    texto.each do |linea|
      archivo.puts linea
    end
  end
end

########################################## Funciones de filtrado

def aprobados(array_alumnos, array_grupos)
  texto = Array.new(1, "COMIENZA APROBADOS")
  array_alumnos.each do |alumno|
    n_grupo = alumno.grupo
    np = array_grupos[n_grupo].np
    if alumno.paso_curso(np) == "NA"
    elsif alumno.paso_curso(np)[0]
      texto.append("#{alumno.id} #{alumno.nombre} #{alumno.paso_curso(np)[1]}")
    end
  end
  texto.append("TERMINA APROBADOS")
  texto
end

def reprobados (array_alumnos, array_grupos)
  texto = Array.new(1, "COMIENZA REPROBADOS")
  array_alumnos.each do |alumno|
    n_grupo = alumno.grupo
    np = array_grupos[n_grupo].np
    if alumno.paso_curso(np) == "NA"
    elsif not alumno.paso_curso(np)[0]
      texto.append("#{alumno.id} #{alumno.nombre} #{alumno.paso_curso(np)[1]}")
    end
  end
  texto.append("TERMINA REPROBADOS")
  texto
end

def proyecto(array_alumnos, array_ayudantes)
  texto = Array.new(1, "COMIENZA PROYECTO")
  array_ayudantes.each do |ayudante|
    texto.append("ayudante:")
    texto.append("#{ayudante.id} #{ayudante.nombre}")
    ayudante.grupos.each do |grupo|
      texto.append("grupo:")
      texto.append("#{grupo}")
      texto.append("integrantes:")
      integrantes = ""
      array_alumnos.each do |alumno|
        if alumno.grupo == grupo.to_i
          integrantes += "#{alumno.id} #{alumno.nombre} "
        end
      end
      texto.append(integrantes.strip)
    end
  end
  texto.append("TERMINA PROYECTO")
  texto
end

def top_grupos(array_grupos)
  texto = Array.new(1, "COMIENZA TOP GRUPOS")
  nueva_array = array_grupos.clone
  nueva_array.sort_by!{|grupo| -grupo.np}
  array_final = nueva_array[0, 3]
  array_final.sort_by!{|grupo| grupo.id}
  array_final.each do |grupo|
    texto.append("#{grupo.id} #{grupo.np}")
  end
  texto.append("TERMINA TOP GRUPOS")
  texto
end

def top_ayudante(array_ayudantes, array_grupos)
  texto = Array.new(1, "COMIENZA TOP AYUDANTE")
  nueva_array = array_ayudantes.clone
  nueva_array.sort_by!{|ayudante| ayudante.promedio_grupos(array_grupos)}
  mejor_ayudante = nueva_array[-1]
  texto.append("#{mejor_ayudante.id} #{mejor_ayudante.nombre} #{mejor_ayudante.promedio_grupos(array_grupos)}")
  texto.append("TERMINA TOP AYUDANTE")
  texto
end