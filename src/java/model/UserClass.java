/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.*;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserClass {
    private int userClass_id;
    private int student_id;
    private int class_id;
    private Class classes;
    private Student student;
}
