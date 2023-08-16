package com.memory.connect.model.member.entity;

import com.memory.connect.model.base.BaseTimeEntity;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "member")
public class Member extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id", nullable = false)
    private int id;

    @Column(name = "member_name")
    private String name;

    @Column(name = "member_age")
    private int age;

    @Column(name = "member_gender")
    private String gender;

}
