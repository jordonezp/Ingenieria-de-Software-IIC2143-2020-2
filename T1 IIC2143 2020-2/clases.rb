class Persona

  def initialize(id, nombre)
    @id = id.to_i
    @nombre = nombre
  end

end

###########################################

class Ayudante < Persona

  attr_accessor :grupos, :id, :nombre

  def initialize(id, nombre, grupos)
    super(id, nombre)
    @grupos = grupos.split(":")
  end

  def promedio_grupos(array_grupos)
    contador = 0
    suma = 0
    @grupos.each do |n_grupo|
      array_grupos.each do |grupo|
        if grupo.id == n_grupo.to_i
          suma += grupo.np
          contador += 1
        end
      end
    end
    suma / contador
  end

end

###########################################

class Alumno < Persona

  attr_accessor :grupo, :id, :nombre

  def initialize(id, nombre, nota_i1, nota_i2, nota_ex, grupo)
    super(id, nombre)
    @nota_i1 = nota_i1.to_i
    @nota_i2 = nota_i2.to_i
    @nota_ex = nota_ex.to_i
    @grupo = grupo.to_i
  end

  def nc
    if @nota_ex == "P"
      "NA"
    else
      (@nota_i1 + @nota_i2 + @nota_ex) / 3
    end
  end

  def paso_curso(np)
    if not nc == "NA"
      if np >= 4 and nc >= 4
        [true, (np + nc) / 2]
      else
        [false, [3.9, (np + nc) / 2].min]
      end
    else
      "NA"
    end
  end

end

###########################################

class Grupo

  attr_accessor :id

  def initialize(id, nota_e0, nota_e1, nota_e2,  nota_e3, nota_ef, nota_presentacion)
    @id = id.to_i
    @nota_e0 = nota_e0.to_i
    @nota_e1 = nota_e1.to_i
    @nota_e2 = nota_e2.to_i
    @nota_e3 = nota_e3.to_i
    @nota_ef = nota_ef.to_i
    @nota_presentacion = nota_presentacion.to_i
  end

  def np
    0.5 * (@nota_e0 + @nota_e1 + @nota_e2 + @nota_e3) / 4 + 0.2 * @nota_ef + 0.3 *
        @nota_presentacion
  end

end

###########################################