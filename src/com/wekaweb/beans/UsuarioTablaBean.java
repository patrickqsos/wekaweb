package com.wekaweb.beans;

public class UsuarioTablaBean {

	private String idUsuario;
	private String nombre;
	private String tabla;
	private String relation;
	private int classIndex;
	private String descripcion;
	private String origen;
	
	/**
	 * @return the idUsuario
	 */
	public String getIdUsuario() {
		return idUsuario;
	}
	/**
	 * @param idUsuario the idUsuario to set
	 */
	public void setIdUsuario(String idUsuario) {
		this.idUsuario = idUsuario;
	}
	/**
	 * @return the nombre
	 */
	public String getNombre() {
		return nombre;
	}
	/**
	 * @param nombre the nombre to set
	 */
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	/**
	 * @return the tabla
	 */
	public String getTabla() {
		return tabla;
	}
	/**
	 * @param tabla the tabla to set
	 */
	public void setTabla(String tabla) {
		this.tabla = tabla;
	}
	/**
	 * @return the relation
	 */
	public String getRelation() {
		return relation;
	}
	/**
	 * @param relation the relation to set
	 */
	public void setRelation(String relation) {
		this.relation = relation;
	}
	/**
	 * @return the classIndex
	 */
	public int getClassIndex() {
		return classIndex;
	}
	/**
	 * @param classIndex the classIndex to set
	 */
	public void setClassIndex(int classIndex) {
		this.classIndex = classIndex;
	}
	/**
	 * @return the descripcion
	 */
	public String getDescripcion() {
		return descripcion;
	}
	/**
	 * @param descripcion the descripcion to set
	 */
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	/**
	 * @return the origen
	 */
	public String getOrigen() {
		return origen;
	}
	/**
	 * @param origen the origen to set
	 */
	public void setOrigen(String origen) {
		this.origen = origen;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "UsuarioTablaBean [idUsuario=" + idUsuario + ", nombre="
				+ nombre + ", tabla=" + tabla + ", relation=" + relation
				+ ", classIndex=" + classIndex + ", descripcion=" + descripcion
				+ ", origen=" + origen + "]";
	}
	
	
	
	
	
	
}
