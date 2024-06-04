/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Task {
    private int task_id;
    private String title;
    private String description;
    private String status;
    private Objective objecttive;

    public Task(String title, String description, String status, Objective objecttive) {
        this.title = title;
        this.description = description;
        this.status = status;
        this.objecttive = objecttive;
    }
    
    
}
