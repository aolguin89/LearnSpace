package ar.edu.unrc.citic.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * User entity representing a user in the LearnSpace system.
 * Corresponds to the 'users' table in the database.
 * <p>
 * Users can have three roles: admin, professor, or student.
 *
 * @author Alvaro Olguin Armendariz
 * @version 1.0
 */
public class User {

    private int id;
    private String username;
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private String dni;
    private String address;
    private String phone;
    private Date birthDate;
    private String gender;
    private String role;
    private Timestamp createdAt;
    private Timestamp lastLogin;
    private Timestamp updatedAt;
    private boolean isActive;

    /**
     * Default constructor.
     */
    public User() {
    }

    /**
     * Full constructor for creating a User with all fields.
     *
     * @param id        User ID
     * @param username  Unique username
     * @param email     Unique email address
     * @param password  Hashed password
     * @param firstName User's first name
     * @param lastName  User's last name
     * @param dni       National ID number
     * @param address   Physical address
     * @param phone     Phone number
     * @param birthDate Date of birth
     * @param gender    Gender (M, F, other)
     * @param role      User role (admin, professor, student)
     * @param createdAt Account creation timestamp
     * @param lastLogin Last login timestamp
     * @param updatedAt Last update timestamp
     * @param isActive  Account active status
     */
    public User(int id, String username, String email, String password, String firstName, String lastName,
                String dni, String address, String phone, Date birthDate, String gender, String role,
                Timestamp createdAt, Timestamp lastLogin, Timestamp updatedAt, boolean isActive) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dni = dni;
        this.address = address;
        this.phone = phone;
        this.birthDate = birthDate;
        this.gender = gender;
        this.role = role;
        this.createdAt = createdAt;
        this.lastLogin = lastLogin;
        this.updatedAt = updatedAt;
        this.isActive = isActive;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Timestamp lastLogin) {
        this.lastLogin = lastLogin;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    /**
     * Returns a string representation of the User.
     * Does not include password for security reasons.
     *
     * @return User details as string
     */
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", dni='" + dni + '\'' +
                ", role='" + role + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}