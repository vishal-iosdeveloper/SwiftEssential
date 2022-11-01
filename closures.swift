// Filter
var topStudnetFilter:(Student) -> Bool = { student in
    return student.testScore > 80
}

func topStudnetFilterF(student: Student) -> Bool{
    return student.testScore > 90
}

print("List of Top students are : \(students.filter(topStudnetFilter))")
print("List of Top students are : \(students.filter(topStudnetFilterF))")


// Sorting
var sortingClosure: (Student, Student) -> Bool = { student1, student2  in
    return student1.testScore > student2.testScore
}
print("List of Top students are : \(students.sorted(by: sortingClosure))")
print("List of Top students are : \(students.sorted(by: {$0.testScore > $1.testScore}))")
