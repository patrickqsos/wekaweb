package com.wekaweb.beans;

public class UsuarioBean {

	private String id;
	private String idSocial;
	private String nombre;
	private String apellido;
	private String email;
	private String password;
	private String token;
	private boolean activo;
	private String tipo;
	
	public UsuarioBean(){
		this.id = null;
		this.idSocial = null;
		this.nombre = null;
		this.apellido = null;
		this.email = null;
		this.password = null;
		this.token = null;
		this.activo = false;
		this.tipo = null;
	}
	
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the idSocial
	 */
	public String getIdSocial() {
		return idSocial;
	}
	/**
	 * @param id the idSocial to set
	 */
	public void setIdSocial(String idSocial) {
		this.idSocial = idSocial;
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
	 * @return the apellido
	 */
	public String getApellido() {
		return apellido;
	}
	/**
	 * @param apellido the apellido to set
	 */
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public boolean isActivo() {
		return activo;
	}
	public void setActivo(boolean activo) {
		this.activo = activo;
	}
	/**
	 * @return the tipo
	 */
	public String getTipo() {
		return tipo;
	}
	/**
	 * @param tipo the tipo to set
	 */
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	@Override
	public String toString() {
		return "UsuarioBean [id=" + id + ", nombre=" + nombre + ", apellido="
				+ apellido + ", email=" + email + ", password=" + password
				+ ", token=" + token + ", activo=" + activo + ", tipo=" + tipo
				+ "]";
	}
	
	
	
}
